# SwiftySyntax
Swift wrapper around the Tree-Sitter lib, an incremental parser system for syntax.

## Installation 

Just add `github "ZkHaider/SwiftySyntax" "master"` to your Cartfile and run `carthage`.

## Usage

Let's take a normal `UITextView` with some source code as an attributed string value, and set the text color to white:

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

let textView: UITextView = {
    let view = UITextView(frame: .zero)
    view.font = UIFont.systemFont(ofSize: 16.0)
    view.textColor = .white
    view.backgroundColor = .clear
    return view
}()

let mutableAttributedString = NSMutableAttributedString(string: self.sourceCode)
mutableAttributedString.addAttribute(
    .foregroundColor,
    value: UIColor.white,
    range: NSRange(location: 0, 
                   length: self.sourceCode.count)
)

self._view.textView.attributedText = mutableAttributedString
```

We get the following:

<img src="https://github.com/ZkHaider/SwiftySyntax/blob/master/imgs/nothighlighted.png" />

Now let's highlight the JSON syntax:

```swift
struct Colors {
    static let matteRed: UIColor = {
        return UIColor(red: 0.942, green: 0.566, blue: 0.498, alpha: 1.0)
    }()
    static let gold: UIColor = {
        return UIColor(red: 0.839, green: 0.78, blue: 0.463, alpha: 1.0)
    }()
}


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

let textView: UITextView = {
    let view = UITextView(frame: .zero)
    view.font = UIFont.systemFont(ofSize: 16.0)
    view.textColor = .white
    view.backgroundColor = .clear
    return view
}()

let mutableAttributedString = NSMutableAttributedString(string: self.sourceCode)
mutableAttributedString.addAttribute(
    .foregroundColor,
    value: UIColor.white,
    range: NSRange(location: 0, 
                   length: self.sourceCode.count)
)

for match in self.parser.matches(with: .pairCombined, on: tree.rootNode) {
    for capture in match.captures {
        switch capture.captureType {
        case .pairKey:
            let startByte = capture.node.startByte
            let endByte = capture.node.endByte
            let range = NSRange(location: startByte, length: endByte - startByte)
            mutableAttributedString.addAttribute(
                .foregroundColor,
                value: Colors.matteRed,
                range: range
            )
        case .pairString:
            let startByte = capture.node.startByte
            let endByte = capture.node.endByte
            let range = NSRange(location: startByte, length: endByte - startByte)
            mutableAttributedString.addAttribute(
                .foregroundColor,
                value: Colors.matteRed,
                range: range
            )
        case .pairNumber:
            let startByte = capture.node.startByte
            let endByte = capture.node.endByte
            let range = NSRange(location: startByte, length: endByte - startByte)
            mutableAttributedString.addAttribute(
                .foregroundColor,
                value: Colors.gold,
                range: range
            )
        case .pairArray:
            continue
        case .pairObject:
            continue
        default: continue
        }
    }
}

self._view.textView.attributedText = mutableAttributedString
```

Now we get this:

<img src="https://github.com/ZkHaider/SwiftySyntax/blob/master/imgs/highlighted.png" />

Lots more work to come. Python, PHP, Javascript, Rust, and even Swift grammars will be implemented soon.
