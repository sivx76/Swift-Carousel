//
//  PageIndicator.swift
//  Carousel
//
//  Created by Ben Alemu on 8/3/22.
//

import Foundation
import UIKit


/// The indicator dots of the Carousel. Quickly change the colors, sizing and more.
class PageIndicator: UIPageControl {
    
    public enum Size {
        case small
        case medium
        case large
        case extraLarge
        case largest
    }
    
    
    // MARK: - Properties
    private let defaultFrame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 30)

    private var size: Size = .small
    
    
    // MARK: - Initializers
    init() {
        super.init(frame: defaultFrame)
        
        defaultStyle()
        determineSize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper Methods
    private func defaultStyle() {
        self.currentPageIndicatorTintColor = .blue
        self.pageIndicatorTintColor = .systemGray
    }
    
    
    private func determineSize() {
        switch size {
            case .small:
                return
            case .medium:
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            case .large:
                self.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            case .extraLarge:
                self.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            case .largest:
                self.transform = CGAffineTransform(scaleX: 2.2, y: 2.2)
            }
    }
    
    
    // MARK: - Public Methods
    
    /// Change the color of the indicator, when we are on the page.
    public func selectedColor(color: UIColor) {
        self.currentPageIndicatorTintColor = color
    }
    
    /// Change the color of the indicator, when we are NOT on the page.
    public func unselectedColor(color: UIColor) {
        self.pageIndicatorTintColor = color
    }
    
    /// Change the color of the rectangle behind the indicator dots.
    public func backgroundColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    /// Change the size of the indicator dots, from small to largest options.
    public func setSize(size: Size) {
        self.size = size
        determineSize()
    }
    
    
    /// Move the y-axis of the indicator placement downward.
    public func offset(shiftDown: Int) {
        let newFrame: CGRect = CGRect(x: self.frame.minX, y: CGFloat(Int(frame.origin.y) + shiftDown), width: self.frame.width, height: self.frame.height)

        self.frame = newFrame
    }
    
    /// Move the y-axis of the indicator placement upward.
    public func offset(shiftUp: Int) {
        let newFrame: CGRect = CGRect(x: self.frame.minX, y:  CGFloat(Int(frame.origin.y) - shiftUp), width: self.frame.width, height: self.frame.height)

        self.frame = newFrame
    }
    
    
}
