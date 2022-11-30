//
//  Carousel.swift
//  Carousel
//
//  Created by Ben Alemu on 8/1/22.
//

import UIKit


// MARK: - For Delegate
enum ScrollSource: String, CaseIterable {
    case user
    case automatic
}

/// The contract that allows a View Controller to respond when a Carousel or ScrollingCarousel has it's page changed or the user taps on a page.
protocol CarouselDelegate {
    func pageChanged(index: Int, page: UIView, source: ScrollSource)
    func pageTapped(index: Int, page: UIView)
}


/// A horizontal ScrollView that provides an interactable Carousel along with a PageIndicator of horizontal dots.
///
/// Conform to the ``CarouselDelegate`` to be notify when the page has changed or when the page has been tapped.
///
/// Useful for presenting complex multimedia - photos, tutorials, onboarding experiences and more.
///
///  ```swift
///  let carousel = Carousel(pages: assembledPages, frame: view.frame)
///  let carouselView = carousel.show()
///  view.addSubview(carouselView)
///  ```
class Carousel: NSObject {
    
    // MARK: - Delegate
    var delegate: CarouselDelegate?
    
    
    // MARK: - UI Elements
     var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        
        return scroll
    }()
    
    public var indicator: PageIndicator = {
        let dotIndicator = PageIndicator()
        return dotIndicator
    }()
    
    
    
    // MARK: - Properties
    private var carouselView: UIView
    private var pages: [UIView]?
    
    var carouselFrame = CGRect()
    
    var numberOfPages: Int {
        return pages?.count ?? 0
    }
    
    var selectedIndex: Int = 0
    
    var pageIndex: Int = 0
    private var lastTranslation: Float = 0
    
        
    
    // MARK: - Initializers
     init(pages: [UIView]?, frame: CGRect) {
        self.pages = pages
        self.carouselFrame = frame
        self.carouselView = UIView()
        
        super.init()

        configureDelegates()
        standardizeSubviews()
        refreshCarousel()
        setupTapGesture()
         
       carouselView.frame = carouselFrame
    }
    
    
    override convenience init() {
        let emptyPage: [UIView]? = nil
        let emptyFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 80)
        
        self.init(pages: emptyPage, frame: emptyFrame)
    }



    
    // MARK: - Setup
    private func configureDelegates() {
        scrollView.delegate = self
    }
    
    private func standardizeSubviews() {
        guard let pages = pages else { return }

        for page in pages {
            page.frame = carouselFrame
            
            if type(of: page) == UIImageView.self {
                page.contentMode = .scaleAspectFit
            }
        }
    }
    
    
    private func refreshCarousel() {
        addSubviews()
        indicator.numberOfPages = numberOfPages
        
        // carouselView.frame = carouselFrame
    }
    
    private func setupTapGesture() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(pageTapped(_:)))
        recognizer.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(recognizer)
    }
    
    
    
    private func addSubviews() {
        if carouselView.subviews.count == 0 {
            carouselView.addSubview(scrollView)
            carouselView.addSubview(indicator)
            
            scrollView.frame = CGRect(x: 0, y: 0, width: carouselFrame.width, height: carouselFrame.height)
            indicator.frame = CGRect(x: 0, y: carouselFrame.height - 100, width: 0, height: 30)
        }
        
        
        configureScrollView()
    }
    
    
    private func configureScrollView() {
        if carouselView.subviews.count > 0 {
            for view in scrollView.subviews {
                view.removeFromSuperview()
            }
        }


        guard let pages = self.pages else { return }
                
        scrollView.contentSize = CGSize(width: carouselFrame.width * CGFloat(numberOfPages), height: carouselFrame.height)
        scrollView.isPagingEnabled = true
        
        
        // Add pages
        for (index, page) in pages.enumerated() {
            
            if index == 0 {
                page.frame = CGRect(x: 0.0, y: page.frame.origin.y, width: page.frame.width, height: page.frame.height)
            } else {
                let lastPage = pages[index - 1]
                let lastWidth = lastPage.frame.origin.x
                
                let currentX = page.frame.width
                let currentY = page.frame.origin.y
                
                
                page.frame = CGRect(x: lastWidth + currentX, y: currentY, width: page.frame.width, height: page.frame.height)
            }
            
            
            scrollView.addSubview(page)
        }
    }
    
    
    
    
    // MARK: - Public Methods
    
    /// Returns the UIView that contains the Carousel and the PageIndicator.
    public func show() -> UIView {
        return carouselView
    }
    
    /// Returns the pages that determine what is shown on the Carousel.
    public func showPages() -> [UIView]? {
        return pages ?? nil
    }
    
    
    /// Add one more page to the Carousel.
    public func append(page: UIView) {
        pages?.append(page)
        refreshCarousel()
    }
    
    /// Decide where to add one more page to the Carousel.
    public func insert(page: UIView, at index: Int) {
        pages?.insert(page, at: index)
        refreshCarousel()
    }
    
    
    /// Change the pages that determine the content of the Carousel.
    public func setPages(pages: [UIView]) {
        self.pages = pages
        refreshCarousel()
    }
    
    /// Move the sizing and position of the frame that contains the Carousel and the PageIndicator.
    public func setCarouselFrame(frame: CGRect) {
        self.carouselFrame = frame
        refreshCarousel()
    }
    
    /// Randomly shuffle the content shown in the Carousel.
    public func shufflePages() {
        guard let pages = self.pages else { return }
        
        let shuffledPages = pages.shuffled()
        setPages(pages: shuffledPages)
    }
    
    
    /// Remove the indicator dots that are shown with the Carousel.
    public func hideIndicator() {
        indicator.isHidden = true
    }
    
    
    /// Remove both the Carousel and PageIndicator from being shown.
    public func hide() {
        scrollView.isHidden = true
        indicator.isHidden = true
    }
    
    
}


// MARK: - Notify delegate
extension Carousel: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let translation: Float = Float(scrollView.contentOffset.x)

        guard let pages = pages else { return }

        // Determine pageIndex
        if translation > lastTranslation {
            pageIndex += 1
        } else if translation < lastTranslation {
            pageIndex -= 1
        }
        
        
        // Correction
        if pageIndex < 0 {
            pageIndex = 0
        } else if pageIndex > pages.count - 1 {
            pageIndex = pages.count - 1
        }

        lastTranslation = translation
        
        
        // Set visual state
        indicator.currentPage = Int(pageIndex)
        selectedIndex = Int(pageIndex)


        let currentIndex = selectedIndex
        let currentView = pages[selectedIndex]

        delegate?.pageChanged(index: currentIndex, page: currentView, source: .user)
    }
    

}


extension Carousel {
    @objc func pageTapped(_ sender: UITapGestureRecognizer) {
        guard let pages = pages else { return }
        
        let tapIndex = selectedIndex
        let tapView = pages[tapIndex]
        
        delegate?.pageTapped(index: tapIndex, page: tapView)
    }
}


