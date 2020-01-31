# RxSemaphore

[![CI Status](https://img.shields.io/travis/Adelais0/RxSemaphore.svg?style=flat)](https://travis-ci.org/Adelais0/RxSemaphore)
[![Version](https://img.shields.io/cocoapods/v/RxSemaphore.svg?style=flat)](https://cocoapods.org/pods/RxSemaphore)
[![License](https://img.shields.io/cocoapods/l/RxSemaphore.svg?style=flat)](https://cocoapods.org/pods/RxSemaphore)
[![Platform](https://img.shields.io/cocoapods/p/RxSemaphore.svg?style=flat)](https://cocoapods.org/pods/RxSemaphore)

This operator's arguments include multiple source observables and a transform closure (optional). Each element in a source observable means the start of a new task, and more importantly, it ends the previous task. With multiple source observables, multiple tasks exist at the same time. This operator is like a serial queue, and these tasks are queued. If a task is pending, and the relevant observable emits a new element, this task will be cancelled and the new one will be queued.

## Example

To run the example playground, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* [RxSwift](https://github.com/ReactiveX/RxSwift)

## Installation

RxSemaphore is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxSemaphore'
```

## Author

Adelais0, lilingfengzero@gmail.com

## License

RxSemaphore is available under the MIT license. See the LICENSE file for more info.
