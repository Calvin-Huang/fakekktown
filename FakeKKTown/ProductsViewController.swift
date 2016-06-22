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
    
    private var activeIndicator: UIView = {
        let indicator = UIView()
        indicator.frame = CGRect(origin: CGPointZero, size: CGSize(width: TabListItem.itemSize.width, height: 5))
        indicator.backgroundColor = UIColor.blackColor()
        indicator.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin
        
        return indicator
    }()
    
    
    private var disposeBag = DisposeBag()
    private var circleProgress: UICircleProgressView?
    private var currentProgress = 0.0
    
    private let tabListViewModel = TabListViewModel()
    
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
    private func configureTabList() {
        tabList.registerNib(UINib(nibName: "\(TabListItem.self)", bundle: nil), forCellWithReuseIdentifier: TabListItem.reuseIdentifier)
        
        let collectionViewLayout = tabList.collectionViewLayout as! UICollectionViewFlowLayout
        collectionViewLayout.itemSize = TabListItem.itemSize
        
        tabList.addSubview(activeIndicator)
        activeIndicator.center = CGPoint(x: 0 + activeIndicator.bounds.width * 0.5, y: tabList.bounds.height - activeIndicator.bounds.height * 0.5)
        
        // Prepare padding left and right.
        tabList.contentInset = UIEdgeInsets(top: tabList.contentInset.top, left: TabListItem.itemSize.width, bottom: 0, right: TabListItem.itemSize.width)
        
        tabListViewModel.categories
            .asObservable()
            .bindTo(tabList.rx_itemsWithCellIdentifier("\(TabListItem.self)", cellType: TabListItem.self)) { (_, category, cell) in
                cell.name = category.title
            }
            .addDisposableTo(disposeBag)
    }
    
    private func configureTabListOnScrolling() {
        tabList.rx_scrollViewDidEndDragging
            .subscribeNext { (scrollView: UIScrollView, willDecelerate: Bool) in
                if (!willDecelerate) {
                    self.scrollCenterTabItem()
                }
            }
            .addDisposableTo(disposeBag)
        
        tabList.rx_scrollViewDidEndDecelerating
            .subscribeNext { (scrollView: UIScrollView) in
                self.scrollCenterTabItem()
            }
            .addDisposableTo(disposeBag)
    }
    
    private func configureTabListOnItemClick() {
        tabList.rx_itemSelected
            .subscribeNext { (indexPath) in
                do {
                    self.tabListViewModel.activedCategory.value = try self.tabList.rx_modelAtIndexPath(indexPath)
                } catch {
                    
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    private func configureDefaultActivedTab() {
        tabListViewModel.categories
            .asDriver()
            .filter { (categories) -> Bool in
                return categories.count > 0
            }
            .driveNext { [unowned self] (categories) in
                self.tabListViewModel.activedCategory.value = categories.first!
            }
            .addDisposableTo(disposeBag)
    }
    
    private func scrollCenterTabItem() {
        let scrollView = tabList
        
        let currentOffset = scrollView.contentOffset
        let remainder = currentOffset.x % TabListItem.itemSize.width
        
        let targetOffsetX = floor(currentOffset.x / TabListItem.itemSize.width) * TabListItem.itemSize.width + round(remainder / TabListItem.itemSize.width) * TabListItem.itemSize.width
        
        UIView.animateWithDuration(0.2) {
            self.activeIndicator.center = CGPoint(x: targetOffsetX + self.view.center.x, y: self.activeIndicator.center.y)
            scrollView.contentOffset = CGPoint(x: targetOffsetX, y: scrollView.contentOffset.y)
        }
    }
}