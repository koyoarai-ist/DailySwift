//
//  InitPageViewController.swift
//  DailySwift
//
//  Created by 新井 恒陽 on 2018/10/31.
//  Copyright © 2018 新井 恒陽. All rights reserved.
//

import UIKit

class InitPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self //追加

        // Do any additional setup after loading the view.
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// 複数のViewControllerはdataSourceプロトコルを使い実装する

extension InitPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ initPageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: FirstViewController.self) {
            // 1 -> 2
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            // 2 -> 3
            return getThird()
        } else {
            // 3 -> end of the road
            return nil
        }
        
    }
    
    func pageViewController(_ initPageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: ThirdViewController.self) {
            // 3 -> 2
            return getSecond()
        } else if viewController.isKind(of: SecondViewController.self) {
            // 2 -> 1
            return getFirst()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
}
