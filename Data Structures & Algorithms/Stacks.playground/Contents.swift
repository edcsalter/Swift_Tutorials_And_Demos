// Copyright (c) 2019 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// Defining backing storage type for Stack: an array
// Array chosen because of constant time insertions and deletions at one end
// via 'append' and 'popLast' which will also make the stacks LIFO.

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() {}
    
    //O(1)
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    //O(1)
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
}

extension Stack: CustomStringConvertible {
    /**
    EXPLANATION:
        Create array mapping elements to string:
            storage.map { "\($0)"}
     
        Reverse the previous array:
            reversed()
     
        Flatten array into string with new line inbetween each element
    */
    public var description: String {
        """
        ---top---
        \(storage.map { "\($0)"}.reversed().joined(separator: "\n"))
        ---------
        """
    }
}

example(of: "Using a Stack") {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    stack.push(5)
    
    print(stack)
    
    if let poppedElement = stack.pop() {
        assert(5 == poppedElement)
        print("Popped: \(poppedElement)")
    }
}
