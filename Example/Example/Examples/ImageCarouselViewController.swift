//
//  ImageCarouselViewController.swift
//  Example
//
//  Created by Ben Alemu on 11/27/22.
//

import UIKit

class ImageCarouselViewController: UIViewController {
    
    // MARK: - UI Elements
    var carousel = Carousel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageCarousel()
        customizeIndicator()
    }
    

    func setupImageCarousel() {
        let firstImageView = UIImageView()
        firstImageView.image = UIImage(systemName: "sun.max")
        
        let secondImageView = UIImageView()
        secondImageView.image = UIImage(systemName: "cloud.hail.fill")
        
        let thirdImageView = UIImageView()
        thirdImageView.image = UIImage(systemName: "aqi.medium")
        

        // Carousel
       carousel = Carousel(pages: [firstImageView, secondImageView, thirdImageView], frame: CGRect(x: 40, y: 0, width: view.frame.width * 0.8, height: view.frame.height * 0.6))
        carousel.delegate = self

        

        let carouselView = carousel.show()
        view.addSubview(carouselView)
    }
    
    
    func customizeIndicator() {
        carousel.indicator.selectedColor(color: .red)
        carousel.indicator.unselectedColor(color: .black)
        carousel.indicator.setSize(size: .large)
    }
    

}

extension ImageCarouselViewController: CarouselDelegate {
    func pageChanged(index: Int, page: UIView, source: ScrollSource) {
        print("Now at index: \(index) - triggered by: \(source.rawValue)")
    }
    
    func pageTapped(index: Int, page: UIView) {
        print("Tapped on page #: \(index)")
    }
    
    
}
