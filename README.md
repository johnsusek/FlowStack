## Update July 2020 - latest SwiftUI now has built-in components to do this, which should be used instead. 

# FlowStack

FlowStack is a SwiftUI component for laying out content in a grid.

## Requirements

Xcode 11 beta on MacOS 10.14 or 10.15

## Installation

In Xcode, choose File -> Swift Packages -> Add Package Dependency and enter [this repo's URL](https://github.com/johnsusek/FlowStack).

## Usage 

### FlowStack(*columns*, *numItems*, *alignment*) { *index*, *colWidth* in }

<dl>
  <dt>columns (Int)</dt> 
  <dd>The number of columns to display.</dd>
  <dt>numItems (Int)</dt> 
  <dd>The total count of items you will be displaying.</dd>
  <dt>alignment (HorizontalAlignment?)</dt> 
  <dd>Default: .leading<br>The alignment of any trailing columns in the last row.</dd>
</dl>

#### Callback parameters
<dl>
  <dt>index (Int)</dt> 
  <dd>The index of the item currently being processed.</dd>
  <dt>colWidth (CGFloat)</dt> 
  <dd>The computed width of the column currently being processed.</dd>
</dl>

## Examples

### 1) Simple

The simplest possible example:

```swift
FlowStack(columns: 3, numItems: 27, alignment: .leading) { index, colWidth in
  Text(" \(index) ").frame(width: colWidth)
}
```

You should always add `.frame(width: colWidth)` to the immediate child of `FlowStack`.

![Screen Shot 2019-06-25 at 10 43 41 PM](https://user-images.githubusercontent.com/611996/60149560-b7727480-979a-11e9-8759-cc9ec2eea01b.png)

### 2) Displaying Data

```swift
struct Item {
  var image: String
  var label: String
}

let items = [
  Item(image: "hand.thumbsup", label: "Up"),
  Item(image: "tortoise", label: "Tortoise"),
  Item(image: "forward", label: "Forward"),
  Item(image: "hand.thumbsdown", label: "Down"),
  Item(image: "hare", label: "Hare"),
  Item(image: "backward", label: "Backward")
]

FlowStack(columns: 3, numItems: items.count, alignment: .leading) { index, colWidth in
  Button(action: { print("Tap \(index)!") }) {
    Image(systemName: items[index].image)
    Text(items[index].label).font(Font.caption)
  }
  .padding()
  .frame(width: colWidth)
}
```

![Screen Shot 2019-06-25 at 10 54 25 PM](https://user-images.githubusercontent.com/611996/60149936-34521e00-979c-11e9-91c9-04e2f59c77b8.png)


### Padding/Borders/Actions

Let's draw a border on our cells to visualize some concepts:
```swift
FlowStack(columns: 3, numItems: 27, alignment: .leading) { index, colWidth in
  Text(" \(index) ").frame(width: colWidth).border(Color.gray)
}
```

![Screen Shot 2019-06-25 at 11 03 05 PM](https://user-images.githubusercontent.com/611996/60150233-69ab3b80-979d-11e9-96e6-b8795adff041.png)

Now let's swap the `.frame` and `.border` order and note what happens. This demonstrates the **order of operations is important when chaining layout modifiers**.

```swift
FlowStack(columns: 3, numItems: 27, alignment: .leading) { index, colWidth in
  Text(" \(index) ").border(Color.gray).frame(width: colWidth)
}
```

![Screen Shot 2019-06-25 at 11 04 58 PM](https://user-images.githubusercontent.com/611996/60150297-abd47d00-979d-11e9-8e09-892a11916c7f.png)

Now let's swap the order back and add some padding:

```swift
FlowStack(columns: 3, numItems: 27, alignment: .leading) { index, colWidth in
  Text(" \(index) ").padding().frame(width: colWidth).border(Color.gray)
}
```

![Screen Shot 2019-06-25 at 11 10 10 PM](https://user-images.githubusercontent.com/611996/60150446-69f80680-979e-11e9-95a9-ff18dc67ab17.png)

To add actions, you can of course **just put buttons in your cells** like example #2. But there is also a way to detect a tap on the entire cell. Note we add a background to detect taps in the empty areas outside the text.

```swift
FlowStack(columns: 3, numItems: 27, alignment: .leading) { index, colWidth in
  Text(" \(index) ")
    .padding()
    .frame(width: colWidth)
    .border(Color.gray)
    .background(Color.white)
    .tapAction {
      print("Tap!")
    }
}
```

### Example with images

Here's an example with images. LoadableImageView is from [here](https://github.com/schmidyy/SwiftUI-ListFetching/blob/23c1d5d4b506236e0a7a34a2aa5f991edd4091f4/Views.swift). 
```swift
FlowStack(columns: 3, numItems: 27, alignment: .leading) { index, colWidth in
  VStack {
    LoadableImageView(with: "https://cataas.com/cat?type=sq?foo")
      .padding()
      .frame(width: colWidth, height: colWidth)
      .tapAction { print("Meow!") }
    Text(" \(index) ")
  }
  .padding()
  .frame(width: colWidth)
  .border(Color.gray)
  .background(Color.white)
  .tapAction {
    print("Tap!")
  }
}
```

![Screen Shot 2019-06-25 at 11 41 18 PM](https://user-images.githubusercontent.com/611996/60151555-c78e5200-97a2-11e9-94de-0a4ccc768629.png)

### Evenly spaced grid

```swift
FlowStack(columns: 4, numItems: 27, alignment: .leading) { index, colWidth in
  LoadableImageView(with: "https://cataas.com/cat?type=sq?rando")
    .padding(5)
    .frame(width: colWidth, height: colWidth)
}.padding(5)
```

![Screen Shot 2019-06-26 at 12 13 21 AM](https://user-images.githubusercontent.com/611996/60152721-3ff71200-97a7-11e9-91b2-b338edaab58c.png)


## Feedback

Please file a github issue if you're having trouble or spot a bug.
