//
//  PageViewManager.swift
//  PicsNStuff
//
//  Created by Zach Lockett-Streiff on 8/15/19.
//  Copyright © 2019 Swingaroo2. All rights reserved.
//

import Foundation
import UIKit

class PageViewManager: NSObject {
    // Properties and initializers
    
    // Protocol for mock object injection
    let service: FlickrService
    let pageViewController: UIPageViewController
    var gallery: Gallery?
    
    @objc init(service: FlickrService,and pageViewController: UIPageViewController) {
        self.service = service
        self.gallery = nil
        self.pageViewController = pageViewController
        super.init()
        self.fetchData()
    }
    
    private func fetchData() {
        self.service.initiate() { [weak self] gallery, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.gallery = gallery
            }
        }
    }
}

extension PageViewManager: UIPageViewControllerDelegate {
    
}

extension PageViewManager: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}
