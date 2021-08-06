//
//  EventViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/05.
//

import UIKit
import RxSwift
import RxCocoa

class EventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.0.asPercent(with: .WIDTH),
                                 height: 90.0.asPercent(with: .WIDTH))
        layout.minimumLineSpacing = 5
        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return uiCollectionView
    }()
    
    let items = BehaviorSubject(value: [EventData(eventImage: UIImage(named: "img1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
                                        EventData(eventImage: UIImage(named: "img2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
                                        EventData(eventImage: UIImage(named: "img3")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
                                        EventData(eventImage: UIImage(named: "img4")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
                                        EventData(eventImage: UIImage(named: "img5")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
                                        EventData(eventImage: UIImage(named: "img6")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")])
    let disposeBag = DisposeBag()
    var currentIdx: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        collectionViewInit()
        initDataSource()
        configure()
        cellClick()
    }
    
    func cellClick() {
        collectionView.rx.itemSelected
            .subscribe(onNext: { index in
                print("\(index.row)")
            })
            .disposed(by: disposeBag)
    }
    
    func initDataSource() {
        self.items
            .bind(to: collectionView.rx.items(cellIdentifier: CollectionViewCell.identifier, cellType: CollectionViewCell.self)) { row, element, cell in
                cell.imageView.image = element.eventImage
                cell.titleLabel.text = element.eventTitle
                cell.subTitleLabel.text = element.eventSubTitle
        }.disposed(by: disposeBag)
    }
    
    func configure() {
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func collectionViewInit() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(90.0.asPercent(with: .WIDTH))
        }
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
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

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
    
    var containerView: UIView = {
       let uiView = UIView()
        uiView.backgroundColor = .systemPink
        return uiView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img6")
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:18)
        label.textColor = UIColor.black
        label.backgroundColor = .white
        label.text = "titleLabel"
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize:12)
        label.textColor = UIColor.black
        label.backgroundColor = .white
        label.text = "subTitleLabel"
        return label
    }()
         
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
    }
        
    func setUpCell() {
        contentView.addSubview(containerView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        containerView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(90.asPercent(with: .WIDTH))
            $0.height.equalTo(65.asPercent(with: .WIDTH))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(2.0.asPercent(with: .WIDTH))
            $0.left.equalTo(imageView.snp.left)
            $0.width.equalTo(imageView.snp.width)
            $0.height.equalTo(10.0.asPercent(with: .WIDTH))
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2.0.asPercent(with: .WIDTH))
            $0.left.equalTo(imageView.snp.left)
            $0.width.equalTo(imageView.snp.width)
            $0.height.equalTo(10.0.asPercent(with: .WIDTH))
        }
       
    }
}
