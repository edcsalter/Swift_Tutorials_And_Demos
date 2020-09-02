// Copyright (c) 2019 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// Defining backing storage type for Stack: an array
// Array chosen because of constant time insertions and deletions at one end
// via 'append' and 'popLast' which will also make the stacks LIFO.

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() {}
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
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

