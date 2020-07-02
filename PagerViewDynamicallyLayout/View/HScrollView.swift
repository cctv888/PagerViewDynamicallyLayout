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

class HScrollView: UIView {
    
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
        //        pagerView!.backgroundColor = UIColor.gray
        pagerView!.layer.masksToBounds = true
        pagerView!.itemSize = CGSize(width: frame.width/4.8, height: frame.width/3.5)
        pagerView!.interitemSpacing = CGFloat(10)
        pagerView!.leadingSpacing = 15
        pagerView!.decelerationDistance = 2
        self.addSubview(pagerView!)
    }
    
    func setPageControl() {
        pageControl = FSPageControl(frame: CGRect(x: 0, y: frame.origin.y+frame.height-25, width: frame.width, height: 20))
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

extension HScrollView: FSPagerViewDelegate, FSPagerViewDataSource {
    
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
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowRadius = 0.6
        cell.contentView.layer.shadowOpacity = 0.7
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        //        pagerView.scrollToItem(at: index, animated: true)
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
