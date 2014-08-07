//
//  ViewController.swift
//  HelloMetal
//
//  Created by Edward Salter on 8/7/14.
//  Copyright (c) 2014 Edward Salter. All rights reserved.
//

import UIKit
import Metal
import QuartzCore
class ViewController: UIViewController {
    
    let vertexData:[Float] = [0.0, 1.0, 0.0, -1.0, -1.0, 0.0, 1.0, -1.0, 0.0]
    var vertexBuffer: MTLBuffer! = nil
    var device: MTLDevice! = nil
    var metalLayer: CAMetalLayer! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    var commandQueue: MTLCommandQueue! = nil
    var timer: CADisplayLink! = nil
    
    override func viewDidLoad() {
        device = MTLCreateSystemDefaultDevice()
        super.viewDidLoad()
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
        
        let dataSize = vertexData.count * sizeofValue(vertexData[0])
        vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: nil)
        
        let defaultLibrary = device.newDefaultLibrary()
        let fragmentProgram = defaultLibrary.newFunctionWithName("basic_fragment")
        let vertexProgram = defaultLibrary.newFunctionWithName("basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm
        
        var pipelineError : NSError?
        pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor, error: &pipelineError)
        if !pipelineState {
            println("Failed to create pipeline state, error \(pipelineError)")
        }
        commandQueue = device.newCommandQueue()
        
        timer = CADisplayLink(target: self, selector: ("gameloop"))
        timer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func render() {
        var drawable = metalLayer.nextDrawable()
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        let commandBuffer = commandQueue.commandBuffer()
        
        let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
        renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
        renderEncoder.endEncoding()
        
        commandBuffer.presentDrawable(drawable)
        commandBuffer.commit()
    }
    
    func gameloop() {
        autoreleasepool {self.render()
        }
    }
}

