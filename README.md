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
parser.parse(code: self.sourceCode)

guard
    let tree = parser.tree
    else {
        assertionFailure()
        return
}

let sourceQuery = """
(object
    (pair
        (string)
        (string)) @pair.string)

(object
    (pair
        (string)
        (array)) @pair.array)

(object
    (pair
        (string)
        (number)) @pair.number)

(object
    (pair
        (string)
        (object)) @pair.object)
"""

let query = Query(language: .json,
                  sourceQuery: sourceQuery)
let matches = parser.matches(with: query,
                             on: tree.rootNode)

for match in matches {
    let ptr = match.captures!.pointee.node
    let startIndex = Int(ts_node_start_byte(ptr))
    let endIndex = Int(ts_node_end_byte(ptr))
    print(self.sourceCode.substring(startIndex: startIndex, length: endIndex - startIndex))
}

/** Output

"counter": 0
"images": [
        {
            "id": 10,
            "url": "https://someimage.com/image/12"
        }
    ]
"id": 10
"url": "https://someimage.com/image/12"

**/
```

Lots more work to come. Python, PHP, Javascript, Rust, and even Swift grammars will be implemented soon.
