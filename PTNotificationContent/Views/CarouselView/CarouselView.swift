//
//  CarouselView.swift
//  PTNotificationContent
//
//  Created by Jay Mehta on 18/08/20.
//  Copyright © 2020 Jay Mehta. All rights reserved.
//

import UIKit

class CarouselView: UIView {

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    var carouselDataObject : [[String : AnyObject]] = [[:]]
    var onceOnly = false
    var isRaisedCarousel = false
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    init(frame: CGRect, carouselData : [[String : AnyObject]]) {
        
        super.init(frame : frame)
        let carouselView = loadNib()
        carouselDataObject.removeAll()
        carouselDataObject = carouselData
        carouselView.frame = bounds
        carouselView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        layoutIfNeeded()
        addSubview(carouselView);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func setupCollectionView(isRaisedCarousel : Bool){
        
        self.isRaisedCarousel = isRaisedCarousel
        if isRaisedCarousel{
            carouselCollectionView.register(UINib(nibName: "CollectionViewCarouselCell", bundle: Bundle(for: CollectionViewCell.self)), forCellWithReuseIdentifier: "carouselRaisedCell")
            if #available(iOSApplicationExtension 11.0, *) {
                let carouselLayout = CarouselLayout()
                carouselCollectionView.collectionViewLayout = carouselLayout
            } else {
                // Fallback on earlier versions
            }
            carouselCollectionView.dataSource = self
            carouselCollectionView.delegate = self
            carouselCollectionView.reloadData()
        }else{
            carouselCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle(for: CollectionViewCell.self)), forCellWithReuseIdentifier: "carouselCell")
            carouselCollectionView.dataSource = self
            carouselCollectionView.delegate = self
            carouselCollectionView.reloadData()
        }
        
        
    }
    
    

}

extension CarouselView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carouselDataObject.count*Carousel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isRaisedCarousel{
            let carouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselRaisedCell", for: indexPath) as! CollectionViewCarouselCell
            let tmpData = carouselDataObject[indexPath.row % carouselDataObject.count]
            carouselCell.imageView.downloaded(from: tmpData["pt_img\(indexPath.row % carouselDataObject.count+1)"] as! String)
            carouselCell.titleLabel.text = tmpData["pt_title\(indexPath.row % carouselDataObject.count+1)"] as? String
            carouselCell.subTitleLabel.text = tmpData["pt_subtitle\(indexPath.row % carouselDataObject.count+1)"] as? String
            return carouselCell
            
        }else {
            let carouselCell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath) as! CollectionViewCell
            let tmpData = carouselDataObject[indexPath.row % carouselDataObject.count]
            carouselCell.imageView.downloaded(from: tmpData["pt_img\(indexPath.row % carouselDataObject.count+1)"] as! String)
            carouselCell.titleLabel.text = tmpData["pt_title\(indexPath.row % carouselDataObject.count+1)"] as? String
            carouselCell.subTitleLabel.text = tmpData["pt_subtitle\(indexPath.row % carouselDataObject.count+1)"] as? String
            return carouselCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isRaisedCarousel{
            return CGSize(width: self.frame.size.width-200, height: self.frame.size.width-200+45)//Carousel Flow Layout
        }else{
            return CGSize(width: self.frame.size.width-50, height: (self.frame.size.width-50)*0.56+50)//Normal Flow Layout
        }
        
    }
    
    
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            //set the row and section you need.
            let indexToScrollTo = IndexPath(row: carouselDataObject.count*Carousel.count/2, section: indexPath.section)
            carouselCollectionView.scrollToItem(at: indexToScrollTo, at:.centeredHorizontally, animated: false)
            onceOnly = true
        }
        
    }
    
    
    
}



