//
//  OnboardingViewController.swift
//  Example
//
//  Created by Ben Alemu on 11/28/22.
//


import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI Elements
    var carousel = Carousel()
    var assembledPages = [UIView]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildPages()
        setupImageCarousel()
        customizeIndicator()
    }
    
    func buildPages() {
        
        // Assembling the first page
        let firstPage = UIView()
        let firstTextLabel = UILabel(frame: CGRect(x: view.frame.width * 0.24, y: 30, width: 400, height: 30))
        firstTextLabel.text = "Adventure awaits!"
        firstTextLabel.font = UIFont.systemFont(ofSize: 24)
        
        let firstSubtitle = UILabel(frame: CGRect(x: 30, y: 80, width: 340, height: 80))
        firstSubtitle.numberOfLines = 2
        firstSubtitle.text = "Use Parks App to find beautiful outdoor experiences."
        firstSubtitle.font = UIFont.systemFont(ofSize: 18)
        firstSubtitle.textColor = .purple
        
        let firstImageView = UIImageView(frame: CGRect(x: 30, y: 170, width: view.frame.width * 0.9, height: view.frame.height * 0.6))
        firstImageView.image = UIImage(named: "hiking")
        
        
        firstPage.addSubview(firstTextLabel)
        firstPage.addSubview(firstImageView)
        firstPage.addSubview(firstSubtitle)
        
        
        // Assembling the second page
        let secondPage = UIView()
        let secondTextLabel = UILabel(frame: CGRect(x: view.frame.width * 0.3, y: 30, width: 400, height: 30))
        secondTextLabel.text = "Find the lake!"
        secondTextLabel.font = UIFont.systemFont(ofSize: 24)
        
        
        let secondSubtitle = UILabel(frame: CGRect(x: 30, y: 80, width: 340, height: 80))
        secondSubtitle.numberOfLines = 2
        secondSubtitle.text = "First adventurer to the lake will find a free gift ~"
        secondSubtitle.font = UIFont.systemFont(ofSize: 18)
        secondSubtitle.textColor = .purple

        
        let secondImageView = UIImageView(frame: CGRect(x: 30, y: 170, width: view.frame.width * 0.9, height: view.frame.height * 0.6))
        secondImageView.image = UIImage(named: "flowers")
        
        
        secondPage.addSubview(secondTextLabel)
        secondPage.addSubview(secondImageView)
        secondPage.addSubview(secondSubtitle)


        // Set result for Carousel to use
        assembledPages = [firstPage, secondPage]
    }
    

    func setupImageCarousel() {
       
        // Carousel
        carousel = Carousel(pages: assembledPages, frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.9, height: view.frame.height * 0.8))
        carousel.delegate = self

        

        let carouselView = carousel.show()
        view.addSubview(carouselView)
    }
    
    
    func customizeIndicator() {
        carousel.indicator.selectedColor(color: .red)
        carousel.indicator.unselectedColor(color: .white)
        carousel.indicator.setSize(size: .extraLarge)

        carousel.indicator.offset(shiftDown: 50)
    }
    

}

extension OnboardingViewController: CarouselDelegate {
    func pageChanged(index: Int, page: UIView, source: ScrollSource) {
        print("Now at index: \(index) - triggered by: \(source.rawValue)")
    }
    
    func pageTapped(index: Int, page: UIView) {
        print("Tapped on page #: \(index)")
    }
    
    
}
