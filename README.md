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

    cursor.preorderTraverse(node: rootNode) { (node) in
        // Perform effect
        print(node)
    }
}

/*
Prints:
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
    childCount: 3
    type: string
    description: (string (string_content))
    startPoint: (column: 4, row: 1)
    endPoint: (column: 13, row: 1)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 4, row: 1)
    endPoint: (column: 5, row: 1)
Node:
    childCount: 0
    type: string_content
    description: (string_content)
    startPoint: (column: 5, row: 1)
    endPoint: (column: 12, row: 1)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 12, row: 1)
    endPoint: (column: 13, row: 1)
Node:
    childCount: 0
    type: :
    description: (":")
    startPoint: (column: 13, row: 1)
    endPoint: (column: 14, row: 1)
Node:
    childCount: 0
    type: number
    description: (number)
    startPoint: (column: 15, row: 1)
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
    childCount: 3
    type: string
    description: (string (string_content))
    startPoint: (column: 4, row: 2)
    endPoint: (column: 12, row: 2)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 4, row: 2)
    endPoint: (column: 5, row: 2)
Node:
    childCount: 0
    type: string_content
    description: (string_content)
    startPoint: (column: 5, row: 2)
    endPoint: (column: 11, row: 2)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 11, row: 2)
    endPoint: (column: 12, row: 2)
Node:
    childCount: 0
    type: :
    description: (":")
    startPoint: (column: 12, row: 2)
    endPoint: (column: 13, row: 2)
Node:
    childCount: 3
    type: array
    description: (array (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content)))))
    startPoint: (column: 14, row: 2)
    endPoint: (column: 5, row: 7)
Node:
    childCount: 0
    type: [
    description: ("[")
    startPoint: (column: 14, row: 2)
    endPoint: (column: 15, row: 2)
Node:
    childCount: 5
    type: object
    description: (object (pair (string (string_content)) (number)) (pair (string (string_content)) (string (string_content))))
    startPoint: (column: 8, row: 3)
    endPoint: (column: 9, row: 6)
Node:
    childCount: 0
    type: {
    description: ("{")
    startPoint: (column: 8, row: 3)
    endPoint: (column: 9, row: 3)
Node:
    childCount: 3
    type: pair
    description: (pair (string (string_content)) (number))
    startPoint: (column: 12, row: 4)
    endPoint: (column: 20, row: 4)
Node:
    childCount: 3
    type: string
    description: (string (string_content))
    startPoint: (column: 12, row: 4)
    endPoint: (column: 16, row: 4)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 12, row: 4)
    endPoint: (column: 13, row: 4)
Node:
    childCount: 0
    type: string_content
    description: (string_content)
    startPoint: (column: 13, row: 4)
    endPoint: (column: 15, row: 4)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 15, row: 4)
    endPoint: (column: 16, row: 4)
Node:
    childCount: 0
    type: :
    description: (":")
    startPoint: (column: 16, row: 4)
    endPoint: (column: 17, row: 4)
Node:
    childCount: 0
    type: number
    description: (number)
    startPoint: (column: 18, row: 4)
    endPoint: (column: 20, row: 4)
Node:
    childCount: 0
    type: ,
    description: (",")
    startPoint: (column: 20, row: 4)
    endPoint: (column: 21, row: 4)
Node:
    childCount: 3
    type: pair
    description: (pair (string (string_content)) (string (string_content)))
    startPoint: (column: 12, row: 5)
    endPoint: (column: 51, row: 5)
Node:
    childCount: 3
    type: string
    description: (string (string_content))
    startPoint: (column: 12, row: 5)
    endPoint: (column: 17, row: 5)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 12, row: 5)
    endPoint: (column: 13, row: 5)
Node:
    childCount: 0
    type: string_content
    description: (string_content)
    startPoint: (column: 13, row: 5)
    endPoint: (column: 16, row: 5)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 16, row: 5)
    endPoint: (column: 17, row: 5)
Node:
    childCount: 0
    type: :
    description: (":")
    startPoint: (column: 17, row: 5)
    endPoint: (column: 18, row: 5)
Node:
    childCount: 3
    type: string
    description: (string (string_content))
    startPoint: (column: 19, row: 5)
    endPoint: (column: 51, row: 5)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 19, row: 5)
    endPoint: (column: 20, row: 5)
Node:
    childCount: 0
    type: string_content
    description: (string_content)
    startPoint: (column: 20, row: 5)
    endPoint: (column: 50, row: 5)
Node:
    childCount: 0
    type: "
    description: (""")
    startPoint: (column: 50, row: 5)
    endPoint: (column: 51, row: 5)
Node:
    childCount: 0
    type: }
    description: ("}")
    startPoint: (column: 8, row: 6)
    endPoint: (column: 9, row: 6)
Node:
    childCount: 0
    type: ]
    description: ("]")
    startPoint: (column: 4, row: 7)
    endPoint: (column: 5, row: 7)
Node:
    childCount: 0
    type: }
    description: ("}")
    startPoint: (column: 0, row: 8)
    endPoint: (column: 1, row: 8)
*/
```

Lots more work to come. Python, PHP, Javascript, Rust, and even Swift grammars will be implemented soon.
