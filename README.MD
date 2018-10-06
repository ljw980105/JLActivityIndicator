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

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate `JLActivityIndicator` into your Xcode project using Carthage, specify it in your `Cartfile`:

```shell
github "ljw980105/JLActivityIndicator"
```

Run `carthage bootstrap` to build the framework in your repository's Carthage directory.

## Usage

Start by adding `import JLActivityIndicator` on the top of your file.

### Available Modes

`JLActivityIndicator` has two modes of animation, as indicated with the  `JLAnimationMode` enum: 

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
// The code below produces the circular animation with the red color, as shown in the beginning.
let spinner = JLActivityIndicator(on: view, mode: .path)
spinner.paths = [JLBezierPath(strokeColor: UIColor.red, strokePath: UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 60, height: 60)))],
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
spinner.paths = [JLBezierPath(strokeColor: UIColor.red, strokePath: path)]
spinner.start()
```
![](https://raw.githubusercontent.com/ljw980105/JLActivityIndicator/master/Demos/Heartbeat.gif)


### Customizable Properties

For the `.image` mode, you can specify the image, the animation duration, whether or not to add a gray backdrop and the direction of rotation. All other customizations will be ignored.
```swift
spinner.image = UIImage(named: "myImage")
spinner.duration = 1.0 // defaults to 1 second
spinner.reverseDirection = false // defaults to false
spinner.enableBackdrop = false // defaults to false
```
For the `.path` mode, there are more customizable options. Adding more items to the `paths` array will cause all paths contained in the array to animate at the same time. 

In addition, the `JLBezierPath` struct is a wrapper for the `UIBezierPath` that this library requests. You can customize the color, width and the actual bezier path of `JLBezierPath`.

```swift 
// All properties of JLBezierPath have default values. 
// strokeWidth defaults to 3.0, strokeColor defaults to lightGray, and the default path is a 60x60 circle.
// To get started by using default values, you can simply call 'let bezierPath = JLBezierPath()'.
let bezierPath = JLBezierPath(strokeWidth: 5.0, 
                              strokeColor: UIColor.blue, 
                              strokePath: UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)))

spinner.duration = 1.0 // defaults to 1 second
spinner.reverseDirection = false // defaults to false
spinner.enableBackdrop = false // defaults to false
spinner.paths = [bezierPath] // if you don't assign the paths, the activity indicator's path will default to a 60 x 60 gray circle w/ a stroke width of 3.0 
```
## License
This repo is licensed under the MIT license. 

### Thanks for stopping by!


