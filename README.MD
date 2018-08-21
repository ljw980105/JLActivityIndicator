# JLActivityIndicator

A replacement for the build-in `UIActivityIndicator` on iOS. Supply a custom image for your spinner or supply any `UIBezierPath`! Written with the Core Animation Framework in Swift.

![](https://raw.githubusercontent.com/ljw980105/JLActivityIndicator/master/Demos/Circle.gif)

## Installation

### Cocoapods

Cocoapods is a dependency manager for Cocoa projects. Make your to install it before executing the following:

To install `JLActivityIndicator`, add the following to your `Podfile`:

```shell  
pod 'JLActivityIndicator'
```
Then run this in the terminal:
```shell  
pod install
```

### Carthage

Coming soon!

## Usage

Start by adding `import JLActivityIndicator` on the top of your file.

### Available Modes

`JLActivityIndicator` has two modes of animation: 

```swift
case path //supply custom UIBezierPath objects for the activity indicator
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

Supply custom  `UIBezierPath` objects, and the code will draw one or many custom paths!  You can add more paths by filling the `paths` array.

```swift
let spinner = JLActivityIndicator(on: view, mode: .path)
spinner.paths = [UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))]
spinner.color  = UIColor.red
spinner.size = CGSize(width: 60, height: 60)
spinner.start()
DispatchQueue.global(qos: .userInitiated).async {
    // time consuming task
    DispatchQueue.main.async {
        spinner.stop()
    }
}
```
Sample Heartbeat Path: 

```swift 

let path = UIBezierPath() // contained in a 100 x 100 frame
path.move(to: CGPoint(x: 0, y: 60))
path.addLine(to: CGPoint(x: 20, y: 60))
path.addLine(to: CGPoint(x: 40, y: 20))
path.addLine(to: CGPoint(x: 60, y: 100))
path.addLine(to: CGPoint(x: 80, y: 60))
path.addLine(to: CGPoint(x: 100, y: 60))

let spinner = JLActivityIndicator(on: view, mode: .path)
spinner.paths = [path]
spinner.size = CGSize(width: 100, height: 100)
spinner.start()
```
![](https://raw.githubusercontent.com/ljw980105/JLActivityIndicator/master/Demos/Heartbeat.gif)


### Customizable Properties

For the `.image` mode, you can specify the image and set the animation duration. All other customizations will be ignored.
```swift
spinner.image = UIImage(named: "myImage")
spinner.duration = 1.0 // defaults to 1 second
```
For the `.path` mode, there are 5 customizable options. Adding more items to the `paths` array will cause all paths contained in the array to animate at the same time. Please make sure that the any paths contained in the `paths` array are contained within a square with the width of `size`: 

```swift 
spinner.duration = 1.0 // defaults to 1 second
spinner.color = UIColor.red // defaults to light grey
spinner.size = CGSize(width: 60, height: 60) // the spinner will be drawn in a rectangle defined by this property. Defaults to 60x60
spinner.paths = [UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60))] // defaults to a 60 x 60 circle
spinner.strokeWidth = 3.0 // defaults to 3.0
```
## License
This repo is licensed under the MIT license. 

### Thanks for stopping by!


