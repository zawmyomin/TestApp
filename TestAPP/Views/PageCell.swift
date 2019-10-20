//
//  PageCell.swift
//  TestAPP
//
//  Created by Justin Zaw on 20/10/2019.
//  Copyright © 2019 Justin Zaw. All rights reserved.
//

import UIKit
import WebKit

class PageCell: UICollectionViewCell {
    var webVeiw: WKWebView?
    override init(frame: CGRect) {
        super.init(frame: frame)
 
    }
    
    
    
    
    func configWebView(_  page:Page){
       webVeiw  =  webVeiw ?? WKWebView()
        
        self.contentView.addSubview(webVeiw!)
        webVeiw?.loadHTMLString(page.htmlString, baseURL: nil)
        webVeiw?.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
