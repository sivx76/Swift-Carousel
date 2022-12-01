# Swift Carousel

For presenting complex multimedia - photos, tutorials, onboarding experiences and more.

Allows you to quickly present a horizontal series of scrolling content. Automatically supports pagination and indicator dots to show your progress through the carousel.

There are two kinds of Carousels:
* Carousel - a horizontal series of content
* Scrolling Carousel - same as above, but has an automatic time interval in which the next screen is shown

Customize what is shown on each screen. Use our delegate methods to respond to events triggered by the Carousel (which screen is shown and which screen is tapped).


![Image examples of two Carousels](https://github.com/sivx76/Swift-Carousel/blob/main/Other/Screenshots/Collection.png)


## Example:
``` swift
   let carousel = Carousel(pages: assembledPages, frame: view.frame)
 
   let carouselView = carousel.show()
   view.addSubview(carouselView)
```


That is all you need!


## Key Ideas:
* In this framework, we refer to each screen or slide of a carousel as a **page**. Each page represents a **UIView.** To show the carousel content, you insert an Array of UIView objects. This will setup the carousel.
* There are 3 classes we have created: Carousel, ScrollingCarousel and PageIndicator.
	* Carousel: the core UI object, which shows pages and can be heavily customized.
	* ScrollingCarousel: has a duration that it waits before automatically cycling to the next page. Can be stopped or resumed.
	* PageIndicator: the series of dots below the carousel that shows the progress. Can have its color, sizing or spacing changed.
* Conform to the **CarouselDelegate** protocol to be able to intercept events from the Carousel. This includes knowing when the carousel’s page changed or if the carousel was tapped. You can access the *ScrollSource* enumeration to detect if the page change was triggered by the user or automatically from the ScrollingCarousel.
* For more detail, check out the Example Xcode project.



## Features:
* Over 20 public methods to customize many aspects of the Carousels - which pages are shown, the appearance of the PageIndicator, the stopping and resuming of the Carousel and much more.
* Includes support for Documentation Compiler (DocC) to show code documentation and tips as you type.
* Compatible with Swift Package Manager and Cocoapods dependency managers.



## Benefits:
* Quickly present an interactive onboarding experience, which guides users step-by-step on how to use your application
* Show other forms of complex multimedia - like a video playlist, photo gallery and etc, without having to implement complex View Hierarchy manipulation


## Methods:
Carousel
* show() -> UIView
* showPages() -> [UIView]?
* append(page: UIView)
* insert(page: UIView, at index: Int)
* setPages(pages: [UIView])
* setCarouselFrame(frame: CGRect)
* shufflePages()
* hideIndicator()
* hide()


ScrollingCarousel
* resume(fromStart: Bool = **false**)
* stop()
* setDuration(duration: Double)
* reportIterations()

PageIndicator
* selectedColor(color: UIColor)
* unselectedColor(color: UIColor)
* backgroundColor(color: UIColor)
* setSize(size: Size)
* offset(shiftDown: Int)
* offset(shiftUp: Int)






## Created by:
Benyam Alemu Sood and Jigyasaa Alemu Sood, 2022.

Swift Carousel is a free and opensource library distributed under the **MIT License**. You may use this source code for free in any of your personal and commercial projects. 

If you would like to, you may create any articles, tutorials or videos describing any component of this library.

Swift Carousel will always be free to use and openly available.



## Collaboration:
We are in active development. We welcome collaboration.

Feel free to send any pull requests or proposed changes to our codebase. Submit your ideas and code improvements.

