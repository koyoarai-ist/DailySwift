//
//  InitPageViewController.swift
//  DailySwift
//
//  Created by 新井 恒陽 on 2018/10/31.
//  Copyright © 2018 新井 恒陽. All rights reserved.
//

import UIKit

class InitPageViewController: UIPageViewController {

    var pageControl = UIPageControl()

    override func viewDidLoad() {
        
        configurePageControl()
        
        super.viewDidLoad()
        // 
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self //追加

        // Do any additional setup after loading the view.
    }
    
    func pageNum(_ currentNum:Int)
    {
        print(currentNum)
        pageControl.currentPage = currentNum
    }
    
    func configurePageControl() {
        
        let NUMPAGES = 4
        
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 250,width: UIScreen.main.bounds.width,height: 300))
        
        pageControl.numberOfPages = NUMPAGES
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        self.view.addSubview(pageControl)
    }
    
    func getFirst() -> FirstViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
    }
    
    func getSecond() -> SecondViewController {
        return storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
    }
    
    func getThird() -> ThirdViewController {
        return storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
    }
    
    func getFour() -> FourViewController {
        return storyboard!.instantiateViewController(withIdentifier: "FourViewController") as! FourViewController
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// 複数のViewControllerはdataSourceプロトコルを使い実装する

extension InitPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ initPageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: FirstViewController.self) {
            // 1 -> 2
            pageNum(0)
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            pageNum(1)
            // 2 -> 3
            return getThird()
        }  else if viewController.isKind(of: ThirdViewController.self) {
            pageNum(2)
            // 3 -> 4
            return getFour()
        } else {
            pageNum(3)
            return nil
        }
    }
    
    func pageViewController(_ initPageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: FourViewController.self) {
            // 4 -> 3
            pageNum(3)
            return getThird()
        } else if viewController.isKind(of: ThirdViewController.self) {
            // 3 -> 2
            pageNum(2)
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            // 2 -> 1
            pageNum(1)
            return getFirst()
        } else {
            // 1 -> end of the road
            pageNum(0)
            return nil
        }
    }
}
