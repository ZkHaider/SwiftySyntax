# SwiftySyntax
Swift wrapper around the Tree-Sitter lib, an incremental parser system for syntax.

## Installation 

Just add `github "ZkHaider/SwiftySyntax" "master"` to your Cartfile and run `carthage`.

## Usage

To use the `Tree-Sitter` library in `Swift` you can do the following:

```swift 
let sourceCode = """
{
    "counter": 0,
    "images": [
        {
            "id": 10,
            "url": "https://someimage.com/image/12"
        }
    ]
}
"""

let parser = SyntaxParser()
parser.parse(code: sourceCode)
if let expression = parser.sExpression() {
    print(expression)
}

/*
Prints:
(value 
    (object 
        (pair 
            (string (string_content)) 
            (number)
        ) 
        (pair 
            (string (string_content)) 
            (array 
                (object 
                    (pair 
                        (string (string_content)) 
                        (number)
                    )
                    (pair 
                        (string (string_content))
                        (string (string_content))
                    )
                )
            )
        )
    )
)
*/

if let syntaxTree = parser.tree {
    let rootNode = syntaxTree.rootNode
    let cursor = rootNode.getCursor()
    print(rootNode)
    var traversing: Bool = true
    while (traversing) {

        // First check if we have a child
        traversing = cursor.goToNextSibling()
        if traversing == false {
            traversing = cursor.goToNextSibling()
            traversing = cursor.goToFirstChild()
        }

        // Get the current node -> print
        let currentNode = cursor.currentNode()
        print(currentNode)
    }
}

/*
Prints:
Node:
    childCount: 1
    type: value
    description: (value (object (pair (string (string_content)) (number)) (pair (string (string_content)) (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content))))))))
    startPoint: (column: 0, row: 0)
    endPoint: (column: 1, row: 8)
Node:
    childCount: 5
    type: object
    description: (object (pair (string (string_content)) (number)) (pair (string (string_content)) (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content)))))))
    startPoint: (column: 0, row: 0)
    endPoint: (column: 1, row: 8)
Node:
    childCount: 0
    type: {
    description: ("{")
    startPoint: (column: 0, row: 0)
    endPoint: (column: 1, row: 0)
Node:
    childCount: 3
    type: pair
    description: (pair (string (string_content)) (number))
    startPoint: (column: 4, row: 1)
    endPoint: (column: 16, row: 1)
Node:
    childCount: 0
    type: ,
    description: (",")
    startPoint: (column: 16, row: 1)
    endPoint: (column: 17, row: 1)
Node:
    childCount: 3
    type: pair
    description: (pair (string (string_content)) (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content))))))
    startPoint: (column: 4, row: 2)
    endPoint: (column: 5, row: 7)
Node:
    childCount: 0
    type: }
    description: ("}")
    startPoint: (column: 0, row: 8)
    endPoint: (column: 1, row: 8)
*/
```

Lots more work to come. Python, PHP, Javascript, Rust, and event Swift grammars will be implemented soon.
