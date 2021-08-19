//
//  EventViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/05.
//

import UIKit
import SnapKit

class NewEventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.0.asPercent(with: .WIDTH),
                                 height: 90.0.asPercent(with: .WIDTH))
        layout.minimumLineSpacing = 5.0.asPercent(with: .WIDTH)
        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        uiCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5.0.asPercent(with: .WIDTH), bottom: 0, right: 5.0.asPercent(with: .WIDTH))
        uiCollectionView.showsHorizontalScrollIndicator = false
        uiCollectionView.delaysContentTouches = false
        uiCollectionView.backgroundColor = .systemPink
        return uiCollectionView
    }()

    var eventDatas: [NewEvent] = [NewEvent(eventImage: UIImage(named: "event1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
                                  NewEvent(eventImage: UIImage(named: "event2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
                                  NewEvent(eventImage: UIImage(named: "img3")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
                                  NewEvent(eventImage: UIImage(named: "img4")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
                                  NewEvent(eventImage: UIImage(named: "img5")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
                                  NewEvent(eventImage: UIImage(named: "img6")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        collectionViewInit()
    }

    func collectionViewInit() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(90.0.asPercent(with: .WIDTH))
        }

        collectionView.delegate = self
        
        collectionView.clipsToBounds = false
    }

   
    var currentIdx: CGFloat = 0.0
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if let cv = scrollView as? UICollectionView {
            let layout = cv.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
            var offset = targetContentOffset.pointee
            let idx = round((offset.x + cv.contentInset.left) / cellWidth)

            if idx > currentIdx {
                currentIdx += 1
            } else if idx < currentIdx {
                if currentIdx != 0 {
                    currentIdx -= 1
                }
            }

            offset = CGPoint(x: currentIdx * cellWidth - cv.contentInset.left, y: 0)
            targetContentOffset.pointee = offset
        }
    }

}

class NewEventCell: UICollectionViewCell {
    
    var containerView: UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .systemBlue
        return uiView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:18)
        label.textColor = UIColor.black
        return label
    }()
    
    var eventData: EventData
    
    init(eventData: EventData) {
        self.eventData = eventData

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




