//
//  PagerView.swift
//  fengmiantu
//
//  Created by 燕陈华 on 2020/6/26.
//  Copyright © 2020 yanchenhua. All rights reserved.
//

import UIKit
import FSPagerView
import Cartography
import Kingfisher

class BannerView: UIView {
    
    var pagerView: FSPagerView?
    var bannerData: BannerData?
    var pageControl: FSPageControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        pagerView = FSPagerView(frame: frame)
        pagerView!.delegate = self
        pagerView!.dataSource = self
        pagerView!.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView!.automaticSlidingInterval = 4.0
        pagerView!.backgroundColor = UIColor.gray
        pagerView!.layer.masksToBounds = true
        pagerView!.layer.cornerRadius = 4
        self.addSubview(pagerView!)
        
        constrain(pagerView!) { (view) in
            view.width == frame.width
            view.height == frame.height
            view.centerX == view.superview!.centerX
            view.top >= view.superview!.top + 15
            view.left >= view.superview!.left + 15
            view.right >= view.superview!.right + 15
        }
    }
    
    func setPageControl() {
        pageControl = FSPageControl(frame: CGRect(x: 0, y: frame.origin.y+frame.height-25, width: UIScreen.main.bounds.size.width, height: 20))
        pageControl!.numberOfPages = bannerData!.url.count
        pageControl!.contentHorizontalAlignment = .right
        pageControl!.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        pageControl!.alpha = 0.6
        self.addSubview(pageControl!)
        
        constrain(pagerView!, pageControl!) { (view1, view2) in
            view2.bottom >= view1.bottom - 10
            view2.right >= view1.superview!.right - 50
        }
    }
    
    func setDataSource(dataSource: BannerData) {
        bannerData = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerView: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerData!.url.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let url = self.bannerData!.url[index]
        cell.imageView?.image = UIImage(systemName: "arrow.2.circlepath.circle")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        //        cell.textLabel?.text = "图片标题"
        cell.imageView?.kf.setImage(with: URL(string: url))
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        if pageControl != nil {
            self.pageControl?.currentPage = targetIndex
        }
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        if pageControl != nil {
            self.pageControl!.currentPage = pagerView.currentIndex
        }
    }
}

