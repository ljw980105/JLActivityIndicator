# JLActivityIndicator

An replacement for the build-in `UIActivityIndicator` on iOS. Supply a custom image for your spinner or supply any `UIBezierPath`! Written with the Core Animation Framework in Swift.

## Usage

Start by adding `import JLActivityIndicator` on the top of your file.

### Available Modes

`JLActivityIndicator` has two modes of animation: 

```swift
case path //supply a UIBezierPath object for the activity indicator
case image // supply a custom image
```

### Custom Image

Supply a custom `UIImage` object. The code will position it as an activity indicator in the center of the view, start spinning when you call the  `start()` method, end spinning when you call  `end()`.

```swift
let spinner = JLActivityIndicator(on: view, mode: .image)
spinner.image = UIImage(named: "myImage")
spinner.start()
DispatchQueue.global(qos: .userInitiated).async {
    // time consuming task
    DispatchQueue.main.async {
        spinner.stop()
    }
}
```

### Custom Path

Supply a `UIBezierPath` object, and the code will draw a custom path! 

```swift
let spinner = JLActivityIndicator(on: view, mode: .path)
spinner.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))
spinner.color  = UIColor.red
spinner.size = 60
spinner.start()
DispatchQueue.global(qos: .userInitiated).async {
    // time consuming task
    DispatchQueue.main.async {
        spinner.stop()
    }
}
```

### Customizable Properties

For the `.image` mode, you can specify the image and set the animation duration. All other customizations will be ignored.
```swift
spinner.image = UIImage(named: "myImage")
spinner.duration = 1.0 // defaults to 1 second
```
For the `.path` mode, there are 5 customizable options. Please make sure that the `path` object is contained within a square with the width of `size`: 

```swift 
spinner.duration = 1.0 // defaults to 1 second
spinner.color = UIColor.red // defaults to light grey
spinner.size = 60 // the spinner will be drawn in a size x size frame. Defaults to 60
spinner.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60)) // defaults to a 60 x 60 circle
spinner.strokeWidth = 3.0 // defaults to 3.0
```
## License
This repo is licensed under the MIT license. 

### Thanks for stopping by!


