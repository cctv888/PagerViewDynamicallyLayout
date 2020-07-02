//
//  ViewController.swift
//  PagerViewDynamicallyLayout
//
//  Created by 燕陈华 on 2020/7/2.
//  Copyright © 2020 yanchenhua. All rights reserved.
//

import UIKit
import Cartography


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let  mWidht = UIScreen.main.bounds.size.width
        
        let pv = BannerView(frame: CGRect(x: 0, y: 10, width: mWidht, height: 150))
        pv.setDataSource(dataSource: BannerData())
        pv.setPageControl()
        self.view.addSubview(pv)

        let sv1 = HScrollView(frame: CGRect(x: 0, y: 10, width: mWidht, height: 160))
        sv1.setDataSource(dataSource: BannerData())
        self.view.addSubview(sv1)
 
        //Automatic layout constraints by Cartography
        constrain(pv, sv1) { (pv, sv1) in
            sv1.width == mWidht
            sv1.height == 160
            sv1.top >= pv.bottom + 10
        }
        
    }


}

