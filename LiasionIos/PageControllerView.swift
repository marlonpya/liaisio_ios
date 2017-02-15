//
//  PageControllerView.swift
//  LiasionIos
//
//  Created by marlon mauro arteaga morales on 2/02/17.
//  Copyright © 2017 marlon. All rights reserved.
//

import Foundation
import UIKit

public class PageControllerView : UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstVC = VCArr.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        let buttonRegistrate = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - 75, y: 450, width:150, height: 50))
        buttonRegistrate.setTitle("Regístrate", for: .normal)
        buttonRegistrate.addTarget(self, action: #selector(clickRegistrate), for: .touchUpInside)
        self.view.addSubview(buttonRegistrate)
        
        let buttonIniciarSesion = UIButton(frame: CGRect(x: (self.view.frame.width / 2) - 75, y: 500, width: 150, height: 50))
        buttonIniciarSesion.setTitle("Iniciar Sesión", for: .normal)
        buttonIniciarSesion.addTarget(self, action: #selector(clickIniciarSesion), for: .touchUpInside)
        self.view.addSubview(buttonIniciarSesion)
    }
    
    @objc private func clickRegistrate(sender: UIButton!) {
        print("registrate")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "idRegistrate")
        present(viewcontroller, animated: true, completion: nil)
    }
    
    @objc private func clickIniciarSesion(sender: UIButton!) {
        print("iniciar sesión")
        let storyRegistrate = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyRegistrate.instantiateViewController(withIdentifier: "idIniciarSesion")
        self.present(vc, animated: true, completion: nil)
    }
    
    lazy var VCArr : [UIViewController] = {
        return [self.VCInstance(name: "view01"),
                self.VCInstance(name: "view02"),
                self.VCInstance(name: "view03")]
    }()
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for case let view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
                return nil
        }
        let index_after : Int = viewControllerIndex - 1
        
        guard index_after >= 0 else {
            return VCArr.last
        }
        
        guard VCArr.count > index_after else {
            return nil
        }

        return VCArr[index_after]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        let index_next : Int = viewControllerIndex + 1
        
        guard index_next < VCArr.count else {
            return VCArr.first
        }
        guard VCArr.count > index_next else {
            return nil
        }
        return VCArr[index_next]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first_index = viewControllers?.first,
            let firstViewControllerIndex = VCArr.index(of: first_index) else {
            return 0
        }
        return firstViewControllerIndex
    }
}
