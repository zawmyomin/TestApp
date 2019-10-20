//
//  SwipeController.swift
//  TestAPP
//
//  Created by Justin Zaw on 20/10/2019.
//  Copyright © 2019 Justin Zaw. All rights reserved.
//

import UIKit

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
      
    var statusLabel:UILabel?
    var  forwardButton:UIBarButtonItem?
    var  backwardButton:UIBarButtonItem?
    
    private   var pages:[Page] = [Page]()
    private var currentPageIndex = 0;
    
    
    convenience init ( ){
        self.init(collectionViewLayout:  {
           let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            return layout
        }())
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setup()
       
        setupNavigationItems()
        setupBottomBar()
         fetchDefaultPages();
         updateButtonState()
    }
    
    private func setup(){
        view.backgroundColor = UIColor.white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        statusLabel = UILabel(frame: CGRect(x: 0, y: 0 , width: view.frame.size.width, height: view.frame.size.height))
        statusLabel?.textAlignment = .center
        statusLabel?.textColor = UIColor.black
        statusLabel?.text = "No Page available, \n Please add a page using \n'Add\' Button"
        statusLabel?.numberOfLines = 0
        view.addSubview(statusLabel!)
        
        
        
        collectionView.backgroundColor = UIColor.white
        
        
         updatePageStatus()
    }
    
    private func fetchDefaultPages(){
        pages.append(contentsOf: [Page(),Page(),Page()])
        updatePageStatus()
        collectionView.reloadData()
        
    }
    func setupNavigationItems(){
        
        
        self.navigationItem.title = "Test App"//"Web Pager"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewPage))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteCurrentPage))
        
    }
    
    @objc func addNewPage(){
        
        let newIndex = pages.count == 0 ? 0 :  currentPageIndex + 1
        pages.insert(Page(), at:newIndex)
        collectionView.insertItems(at:    [IndexPath.init(item: newIndex, section: 0)] )
        collectionView.scrollToItem(at: IndexPath.init(item: newIndex  , section: 0), at: .right, animated: true)
        updateButtonState()
        updatePageStatus()
        
    }
    
    @objc func deleteCurrentPage(){
        
        guard pages.count > 0 else {
            return
        }
        pages.remove(at: currentPageIndex)
        
          let newIndex = currentPageIndex > 0 ?  currentPageIndex - 1 :   currentPageIndex
         collectionView.scrollToItem(at: IndexPath.init(item: newIndex  , section: 0), at: .right, animated: true)
          collectionView.deleteItems(at:[ IndexPath.init(item: currentPageIndex, section: 0)])
        currentPageIndex = newIndex
        updateButtonState()
        updatePageStatus()
    }
    
    
    
    private func updatePageStatus(){
        statusLabel?.isHidden = pages.count > 0
    }
    
    func setupBottomBar(){
        
        
        self.forwardButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: self, action: #selector(forward))
        
        self.backwardButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.rewind, target: self, action: #selector(goBackward))
        
        toolbarItems = [backwardButton!,UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),forwardButton!]
        self.navigationController!.setToolbarHidden(false, animated: false)
    }
    
    private func updateButtonState(){
        debugPrint(currentPageIndex)
        backwardButton?.isEnabled = currentPageIndex > 0
        forwardButton?.isEnabled = currentPageIndex   < ( pages.count  - 1 )
        navigationItem.rightBarButtonItem?.isEnabled = pages.count > 0
    }
     
    @objc func forward(){
       
        guard currentPageIndex < (pages.count - 1 ) else {
            return
        }
       currentPageIndex += 1
        collectionView.scrollToItem(at: IndexPath.init(item: currentPageIndex, section: 0), at: .right, animated: true)
        updateButtonState()
    }
    
    @objc func goBackward(){
        guard currentPageIndex > 0 else {
             return
         }
        currentPageIndex -= 1
         collectionView.scrollToItem(at: IndexPath.init(item: currentPageIndex, section: 0), at: .right, animated: true)
         updateButtonState()
        
    }

}


extension SwipeController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        cell.configWebView(pages[indexPath.row])
         
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPageIndex = Int(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
        updateButtonState()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
