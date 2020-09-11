import UIKit

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct QueueArray<T>: Queue {
    // Space Complexity: O(n)
    
    private var array: [T] = []
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var peek: Element? {
        array.first
    }
    
    public init() {}
    
    // O(1)
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    // O(n)
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
    
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}

var queue = QueueArray<String>()
queue.enqueue("Hi Bob")
queue.enqueue("Marshmellow")
queue.enqueue("Itty Bitty")
queue.enqueue("Lavern")
queue.enqueue("Shirley")
queue.enqueue("Squirrel Mouse")
queue.enqueue("Arlene")
queue
queue.dequeue()
queue
queue.peek

public struct QueueLinkedList<T>: Queue {
    // Space Complexity: O(n)
    
    private var list = DoublyLinkedList<T>()
    public init() {}
    
    // O(1)
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    // O(1)
    public func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        
        return list.remove(element)
    }
    
    public var peek: T? {
        return list.first?.value
    }
    
    public var isEmpty: Bool {
        list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        String.init(describing: list)
    }
}

var queue2 = QueueLinkedList<String>()
queue2.enqueue("Hi Bob")
queue2.enqueue("Marshmellow")
queue2.enqueue("Itty Bitty")
queue2.enqueue("Lavern")
queue2.enqueue("Shirley")
queue2.enqueue("Squirrel Mouse")
queue2.enqueue("Arlene")
print(queue2.description)
queue2.dequeue()
queue2
queue2.peek
print(queue2.description)

public struct QueueRingBuffer<T>: Queue {
    // Space Complexity: O(n)

    private var ringBuffer: RingBuffer<T>
    
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    // O(1)
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    // O(1)
    public var peek: T? {
        ringBuffer.first
    }
    
    // O(1)
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    // O()
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
}

var queue3 = QueueLinkedList<String>()
queue3.enqueue("Hi Bob")
queue3.enqueue("Marshmellow")
queue3.enqueue("Itty Bitty")
queue3.enqueue("Lavern")
queue3.enqueue("Shirley")
queue3.enqueue("Squirrel Mouse")
queue3.enqueue("Arlene")
//print(queue3.description)
queue3.dequeue()
queue3
queue3.peek
//print(queue3.description)

public struct QueueStacks<T>: Queue {
    public var leftStack: [T] = []
    public var rightStack: [T] = []
    
    public init() {}
    
    // O(1)
    public var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    // O(1)
    public var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    // O(1)
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    // O(1)
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}

extension QueueStacks: CustomStringConvertible {
    public var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
}

var queue4 = QueueLinkedList<String>()
queue4.enqueue("Hi Bob")
queue4.enqueue("Marshmellow")
queue4.enqueue("Itty Bitty")
queue4.enqueue("Lavern")
queue4.enqueue("Shirley")
queue4.enqueue("Squirrel Mouse")
queue4.enqueue("Arlene")
print(queue4.description)
queue4.dequeue()
queue4
queue4.peek
print(queue4.description)

