// Copyright (c) 2019 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

// Defining backing storage type for Stack: an array
// Array chosen because of constant time insertions and deletions at one end
// via 'append' and 'popLast' which will also make the stacks LIFO.

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init(_ elements:[Element]) {
        storage = elements
    }
    
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
    
    // Return top element without mutating
    public func peek() -> Element? {
        storage.last
    }
    
    public func isEmpty() -> Bool {
        peek() == nil
    }
    
    public func printInReverse<T>(_ array:[T]) {
        var stack = Stack<T>()
        
        for value in array {
            stack.push(value)
        }
        
        while let value = stack.pop() {
            print(value)
        }
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

extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    storage = elements
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

example(of: "Initializing stack from array") {
    let array = ["A", "B", "C", "D"]
    var stack = Stack(array)
    print(stack)
    stack.pop()
}

example(of: "Initializing stack from array literal") {
    var stack = Stack(arrayLiteral: [1.0, 2.0, 3.0, 4.0])
    print(stack)
    stack.pop()
}

//

let array: [Int] = [1, 2, 3, 4, 5]

func printInReverse<T>(_ array: [T]) {
  var stack = Stack<T>()

  for value in array {
    stack.push(value)
  }

  while let value = stack.pop() {
    print(value)
  }
}

printInReverse(array)

var testString1 = "h((e))llo(world)()"

func checkParentheses(_ string:String) -> Bool {
    var stack = Stack<Character>()
    
    for character in string {
        if character == "(" {
            stack.push(character)
        } else if character == ")" {
            if stack.isEmpty() {
                return false
            } else {
                stack.pop()
            }
        }
    }
    return stack.isEmpty()
}

print(checkParentheses(testString1))
