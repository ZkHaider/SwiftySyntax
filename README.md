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
        (pair (string (string_content)) (number)) 
        (pair (string (string_content)) (array 
            (object 
                (pair (string (string_content)) (number)) 
                (pair (string (string_content)) (string (string_content))))
            )
        )
    )
)
*/
```

Lots more work to come. Python, PHP, Javascript, Rust, and event Swift grammars will be implemented soon.
