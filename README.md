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
        return
}

// Queries are pre compiled static and reusable queries you 
// can use to walk and retrieve Match(s) or Capture(s)
let matches = parser.matches(with: Queries.pairCombined,
                             on: tree.rootNode)

for match in matches {
    for capture in match.captures {
        switch capture.captureType {
        case .pairString:
            let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
            print(subString)
        case .pairNumber:
            let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
            print(subString)
        case .pairObject:
            let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
            print(subString)
        case .pairArray:
            let subString = self.sourceCode[capture.node.startByte..<capture.node.endByte]
            print(subString)
        }
    }
}

/** Output

"counter"
0
"images"
[
        {
            "id": 10,
            "url": "https://someimage.com/image/12"
        }
    ]
"id"
10
"url"
"https://someimage.com/image/12"

**/
```

Lots more work to come. Python, PHP, Javascript, Rust, and even Swift grammars will be implemented soon.
