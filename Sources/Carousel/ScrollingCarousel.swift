//
//  ScrollingCarousel.swift
//  Carousel
//
//  Created by Ben Alemu on 8/1/22.
//

import UIKit


/// A Carousel that automatically moves forward to the next page, based on the provided duration.
class ScrollingCarousel: Carousel {
    
    // MARK: - Variables
    private var timer: Timer?
    private var duration = Double()
    
    private var carouselIndex: Int = 0
    private var shouldRepeat: Bool = true
    
    private var iterations: Int = 0
    
    
    
    // MARK: - Initializers
    init() {
        let emptyPage: [UIView]? = nil
        let emptyFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 80)
        
        super.init(pages: emptyPage, frame: emptyFrame)
    }
    
    
    
    init(pages: [UIView]?, carouselFrame: CGRect,
                duration: Double = 2.0,
                shouldRepeat: Bool = true
    ) {
        self.duration = duration
        self.shouldRepeat = shouldRepeat
        
        super.init(pages: pages, frame: carouselFrame)
        
        
        startCarousel()
    }
    
    
    // MARK: - Public methods
    
    /// If the Carousel is paused, start it moving.
    public func resume(fromStart: Bool = false) {
        if fromStart {
            carouselIndex = 0
        }
        
        startCarousel()
    }
    
    /// Pause the automatic movement of the Carousel.
    public func stop() {
        timer?.invalidate()
    }
    
    
    
    /// Change the time period in which one page waits, before flipping to the next page.
    public func setDuration(duration: Double) {
        self.duration = duration
        
        stop()
        resume()
    }
    
    /// Returns how many completed cycles the Carousel has finished.
    public func reportIterations() -> Int {
        return iterations
    }
    
    
    // MARK: - Helper methods
    private func startCarousel() {
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(carouselScrolled), userInfo: nil, repeats: true)
    }
        
    
    @objc private func carouselScrolled() {
        let finishedCarousel = self.numberOfPages - 1

        
        // Finished carousel
        if carouselIndex >= finishedCarousel {
            if shouldRepeat == false {
                timer?.invalidate()
                return
            } else {
                carouselIndex = 0
            }
            
            iterations += 1
        
        // Carousel running
        } else {
            carouselIndex += 1
        }
        
        indicator.currentPage = carouselIndex
        pageControlDidChange(indicator)
    }
        
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        carouselIndex = sender.currentPage
        self.selectedIndex = carouselIndex
        
        let offset = CGPoint(x: CGFloat(carouselIndex) * scrollView.frame.size.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        
        guard let pages = self.showPages() else { return }
        let currentPage = pages[carouselIndex]
        
        delegate?.pageChanged(index: carouselIndex, page: currentPage, source: .automatic)
    }

        
  
    
}
