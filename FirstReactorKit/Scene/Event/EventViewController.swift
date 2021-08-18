//
//  EventViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/05.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

class EventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.0.asPercent(with: .WIDTH),
                                 height: 90.0.asPercent(with: .WIDTH))
        layout.minimumLineSpacing = 5.0.asPercent(with: .WIDTH)
        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        uiCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5.0.asPercent(with: .WIDTH), bottom: 0, right: 5.0.asPercent(with: .WIDTH))
        uiCollectionView.showsHorizontalScrollIndicator = false
        uiCollectionView.backgroundColor = .clear
        return uiCollectionView
    }()
    
    let items = BehaviorSubject(value:
                                [EventData(viewType: CardViewType.event_CardViewType(bgImage: UIImage(named: "event1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1")),
                                EventData(viewType: CardViewType.event_CardViewType(bgImage: UIImage(named: "event2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2")),
                                EventData(viewType: CardViewType.event_CardViewType(bgImage: UIImage(named: "img1")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3")),
                                EventData(viewType: CardViewType.event_CardViewType(bgImage: UIImage(named: "img2")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4")),
                                EventData(viewType: CardViewType.event_CardViewType(bgImage: UIImage(named: "img3")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5")),
                                EventData(viewType: CardViewType.event_CardViewType(bgImage: UIImage(named: "img4")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6"))])
    let disposeBag = DisposeBag()
    var currentIdx: CGFloat = 0.0
    let transitionManger = CardTransitionManager()
    var indexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        collectionViewInit()
        initDataSource()
        configure()
        cellClick()
        
    }
    
    func cellClick() {
        collectionView.rx.modelSelected(EventData.self)
            .subscribe(onNext: { event in
                let eventDetailVC = DetailView(cardViewModel: event)
                eventDetailVC.modalPresentationStyle = .overCurrentContext
                eventDetailVC.transitioningDelegate = self.transitionManger
                self.navigationController?.pushViewController(eventDetailVC, animated: true)
            })
            .disposed(by: disposeBag)
        collectionView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.indexPath = indexPath
            })
            .disposed(by: disposeBag)
    }
    
    func initDataSource() {
        self.items
            .bind(to: collectionView.rx.items(cellIdentifier: "cell", cellType: CollectionViewCell<CardView>.self)) { row, element, cell in
                cell.cellView = CardView(eventData: element)
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
            $0.width.equalToSuperview()
            $0.height.equalTo(90.0.asPercent(with: .WIDTH))
        }
        
        collectionView.register(CollectionViewCell<CardView>.self, forCellWithReuseIdentifier: "cell")
    }
    
    func selectedCellCardView() -> CardView? {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell<CardView>
        guard let cardView = cell.cellView else { return nil }
        return cardView
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


