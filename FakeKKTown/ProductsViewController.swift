//
//  ProductsViewController.swift
//  CarouselPratice
//
//  Created by Calvin on 6/15/16.
//  Copyright © 2016 CapsLock. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController {
    @IBOutlet weak var tabList: UICollectionView!
    
    fileprivate lazy var activeIndicator: UIView = {
        let indicator = UIView()
        indicator.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: TabListItem.itemSize.width, height: 5))
        indicator.backgroundColor = UIColor.black
        indicator.autoresizingMask = UIViewAutoresizing.flexibleRightMargin
        
        return indicator
    }()
    
    
    fileprivate var disposeBag = DisposeBag()
    
    fileprivate let tabListViewModel = TabListViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureTabList()
        self.configureTabListOnScrolling()
        self.configureTabListOnItemClick()
        self.configureDefaultActivedTab()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Methods
    fileprivate func configureTabList() {
        tabList.register(UINib(nibName: "\(TabListItem.self)", bundle: nil), forCellWithReuseIdentifier: TabListItem.reuseIdentifier)
        
        let collectionViewLayout = tabList.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.itemSize = TabListItem.itemSize
        
        tabList.addSubview(activeIndicator)
        activeIndicator.center = CGPoint(x: 0 + activeIndicator.bounds.width * 0.5, y: tabList.bounds.height - activeIndicator.bounds.height * 0.5)
        
        // Prepare padding left and right.
        tabList.contentInset = UIEdgeInsets(top: tabList.contentInset.top, left: TabListItem.itemSize.width, bottom: 0, right: TabListItem.itemSize.width)
        
        tabListViewModel.categories
            .asObservable()
            .bindTo(tabList.rx.items(cellIdentifier: "\(TabListItem.self)", cellType: TabListItem.self)) { (_, category, cell) in
                cell.name = category.title
            }
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func configureTabListOnScrolling() {
        tabList.rx
            .didEndDragging
            .subscribe(
                onNext: { [weak self] (scrollView: UIScrollView, willDecelerate: Bool) in
                    self?.scrollCenterTabItem()
                }
            )
            .addDisposableTo(disposeBag)
        
        tabList.rx
            .didEndDecelerating
            .subscribe(
                onNext: { [weak self] (scrollView: UIScrollView) in
                    self?.scrollCenterTabItem()
                }
            )
            .addDisposableTo(disposeBag)
    }

    fileprivate func configureTabListOnItemClick() {
        tabList.rx
            .modelSelected(Category.self)
            .subscribe(
                onNext: { [weak self] (category) in
                    print("category: \(category)")
                    self?.tabListViewModel.activedCategory.value = category
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func configureDefaultActivedTab() {
        tabListViewModel.categories
            .asDriver()
            .filter { (categories) -> Bool in
                return categories.count > 0
            }
            .drive(
                onNext: { [weak self] (categories) in
                    self?.tabListViewModel.activedCategory.value = categories.first
                }
            )
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func scrollCenterTabItem() {
        let scrollView = tabList
        
        let currentOffset = scrollView?.contentOffset
        let remainder = currentOffset?.x.truncatingRemainder(dividingBy: TabListItem.itemSize.width)
        
        let targetOffsetX = floor((currentOffset?.x)! / TabListItem.itemSize.width) * TabListItem.itemSize.width + round(remainder! / TabListItem.itemSize.width) * TabListItem.itemSize.width
        
        UIView.animate(withDuration: 0.2, animations: {
            self.activeIndicator.center = CGPoint(x: targetOffsetX + self.view.center.x, y: self.activeIndicator.center.y)
            scrollView?.contentOffset = CGPoint(x: targetOffsetX, y: (scrollView?.contentOffset.y)!)
        }) 
    }

}
