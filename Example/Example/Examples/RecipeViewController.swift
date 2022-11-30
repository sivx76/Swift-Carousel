//
//  RecipeViewController.swift
//  Example
//
//  Created by Ben Alemu on 11/29/22.
//

import UIKit

class RecipeViewController: UIViewController {
   
    
    // MARK: - UI Elements
    var carousel = Carousel()
    var assembledPages = [UIView]()
    
    
    // Data
    let headerText: String = "Deluxe chocolate chip cookies!"
    
    let subtitles: [String] = ["Step 1 - Gather the ingredients",
                               "Step 2 - Make the cookie dough",
                               "Step 3 - Freeze the dough",
                               "Step 4 - Bake"
                                ]
    
    let steps: [String] = [
                        "We need: butter, white sugar, brown sugar, flour, sea salt and chocolate chips.",
                        "Use a cooking scoop to roll into small circular portions.",
                        "Flash-freeze on a baking sheet for 30 minutes. Place in the freezer.",
                        "Bake at 375 degrees for 8-10 minutes."
                        ]
    
    let imageNames: [String] = ["cookie-1", "cookie-2", "cookie-3", "cookie-4"]

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildPages()
        setupImageCarousel()
        customizeIndicator()
    }
    
    
    
    func buildPages() {
        let numberOfPages = 0...3
        
        // Assemble the pages
        for index in numberOfPages {
            let page = UIView()
            
            let header = UILabel(frame: CGRect(x: 30, y: 30, width: 430, height: 30))
            header.text = headerText
            header.font = UIFont.boldSystemFont(ofSize: 22)
            
            
            let subtitle = UILabel(frame: CGRect(x: 30, y: 80, width: 340, height: 80))
            subtitle.numberOfLines = 2
            subtitle.text = subtitles[index]
            subtitle.font = UIFont.boldSystemFont(ofSize: 18)
            subtitle.textColor = .brown
            
            
            let step = UILabel(frame: CGRect(x: 30, y: 120, width: 340, height: 80))
            step.numberOfLines = 2
            step.text = steps[index]
            step.font = UIFont.systemFont(ofSize: 15)
            step.textColor = .black
            
            
            let imageView = UIImageView(frame: CGRect(x: 30, y: 220, width: view.frame.width * 0.9, height: view.frame.height * 0.6))
            imageView.image = UIImage(named: imageNames[index])
            
            
            // Assemble
            page.addSubview(header)
            page.addSubview(subtitle)
            page.addSubview(step)
            page.addSubview(imageView)
            
            assembledPages.append(page)

        }
        
    }
    

    func setupImageCarousel() {
       
        // Carousel
        carousel = Carousel(pages: assembledPages, frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.9, height: view.frame.height * 0.8))
        carousel.delegate = self

        

        let carouselView = carousel.show()
        view.addSubview(carouselView)
    }
    
    
    func customizeIndicator() {
        carousel.indicator.selectedColor(color: .orange)
        carousel.indicator.unselectedColor(color: .black)
        carousel.indicator.setSize(size: .largest)

        carousel.indicator.offset(shiftDown: 150)
    }
    

}

extension RecipeViewController: CarouselDelegate {
    func pageChanged(index: Int, page: UIView, source: ScrollSource) {
        print("Now at index: \(index) - triggered by: \(source.rawValue)")
    }
    
    func pageTapped(index: Int, page: UIView) {
        print("Tapped on page #: \(index)")
    }
    

}
