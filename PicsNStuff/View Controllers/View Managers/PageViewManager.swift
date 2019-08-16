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
    
    let service: FlickrService
    let pageVC: UIPageViewController
    var currentIndex: Int
    var currentVC: UIViewController!
    var gallery: Gallery?
    lazy var viewControllers: [PictureVC] = {
        var controllers = [PictureVC]()
        
        guard let gallery = self.gallery else { return controllers }
        
        gallery.pictures.forEach { picture in
            let pictureVC = PictureVC(imageURL: picture.media.imageURL, andTitle: picture.title)
            controllers.append(pictureVC)
        }
        
        return controllers
    }()
    
    @objc init(service: FlickrService,and pageViewController: UIPageViewController) {
        self.service = service
        self.gallery = nil
        self.pageVC = pageViewController
        self.currentIndex = 0
        super.init()
        self.fetchData()
    }
    
    private func fetchData() {
        self.service.initiate() { [weak self] gallery, error in
            guard let self = self else { return }
            
            guard error == nil else {
                self.pageVC.presentBasicAlert(message: error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self.gallery = gallery
                self.pageVC.delegate = self;
                self.pageVC.dataSource = self;
                guard let firstVC = self.viewControllers.first else { return }
                self.currentVC = firstVC
                self.pageVC.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        }
    }
    
}

extension PageViewManager: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pendingVC = pendingViewControllers.first else { return }
        pageViewController.addChild(pendingVC)
    }
}

extension PageViewManager: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController as! PictureVC) else { return nil }
        let previousIndex = viewControllers.index(before: currentIndex)
        return previousIndex >= 0 ? viewControllers[previousIndex] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = viewControllers.firstIndex(of: viewController as! PictureVC) else { return nil }
        let nextIndex = viewControllers.index(after: currentIndex)
        return nextIndex < viewControllers.count ? viewControllers[nextIndex] : nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
