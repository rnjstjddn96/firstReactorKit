//
//  EventViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/05.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Hero

class NewEventViewController: UIViewController, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {

    let disposeBag = DisposeBag()
    var currentIdx: CGFloat = 0.0
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90.0.asPercent(with: .WIDTH),
                                 height: 90.0.asPercent(with: .WIDTH))
        layout.minimumLineSpacing = 5.0.asPercent(with: .WIDTH)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5.0.asPercent(with: .WIDTH), bottom: 0, right: 5.0.asPercent(with: .WIDTH))
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delaysContentTouches = false
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
        collectionView.register(NewEventCell.self, forCellWithReuseIdentifier: NewEventCell.identifier)
        return collectionView
    }()

    let items = BehaviorSubject(value: [NewEvent(eventImage: UIImage(named: "event1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
                                        NewEvent(eventImage: UIImage(named: "img2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
                                        NewEvent(eventImage: UIImage(named: "img3")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
                                        NewEvent(eventImage: UIImage(named: "img4")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
                                        NewEvent(eventImage: UIImage(named: "img5")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
                                        NewEvent(eventImage: UIImage(named: "img6")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")])
    
    let item: [NewEvent] = [NewEvent(eventImage: UIImage(named: "event1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
                            NewEvent(eventImage: UIImage(named: "event2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
                            NewEvent(eventImage: UIImage(named: "img3")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
                            NewEvent(eventImage: UIImage(named: "img4")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
                            NewEvent(eventImage: UIImage(named: "img5")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
                            NewEvent(eventImage: UIImage(named: "img6")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        collectionViewInit()
//        configure()
//        initDataSource()
        cellClick()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
//        bindCollectionView()
    }

    func collectionViewInit() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(90.0.asPercent(with: .WIDTH))
        }
    }

    func configure() {
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func initDataSource() {
        self.items
            .bind(to: collectionView.rx.items(cellIdentifier: NewEventCell.identifier, cellType: NewEventCell.self)) { row, element, cell in
                cell.imageView.image = element.eventImage
                cell.titleLabel.text = element.eventTitle
                cell.subTitleLabel.text = element.eventSubTitle
        }.disposed(by: disposeBag)
    }
   
    func cellClick() {
        let newEventVC = NewEventDetailViewController()
//        collectionView.rx.itemSelected
//            .subscribe(onNext: { indexPath in
//                print(indexPath.row)
//                newEventVC.id = "\(indexPath.row - 1)"
//            })
//            .disposed(by: disposeBag)
//
        collectionView.rx.modelSelected(NewEvent.self)
            .subscribe(onNext: { event in
                newEventVC.eventImage = event.eventImage
                newEventVC.id = event.eventTitle
                newEventVC.modalPresentationStyle = .fullScreen
                newEventVC.heroModalAnimationType = .pageIn(direction: .up)
                self.present(newEventVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
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
    
    func bindCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewEventCell
            cell.imageView.image = item.eventImage
            cell.titleLabel.text = item.eventTitle
            cell.subTitleLabel.text = item.eventSubTitle
            cell.imageView.hero.id = item.eventTitle
            return cell
        })
        
        let cellData = [SectionOfCustomData(items: [NewEvent(eventImage: UIImage(named: "event1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
                                                    NewEvent(eventImage: UIImage(named: "img2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2")])]
        
        Observable.just(cellData)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

extension NewEventViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return item.count
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewEventCell
        cell.imageView.image = item[indexPath.row].eventImage!.resize(newWidth: SIZE.width)
        cell.imageView.hero.id = "\(indexPath)"
        cell.titleLabel.text = item[indexPath.row].eventTitle
        cell.subTitleLabel.text = item[indexPath.row].eventSubTitle

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newEventVC = NewEventDetailViewController()
        newEventVC.eventImage = item[indexPath.row].eventImage
        newEventVC.id = "\(indexPath)"
        newEventVC.modalPresentationStyle = .fullScreen
        newEventVC.heroModalAnimationType = .fade
        self.present(newEventVC, animated: true, completion: nil)
    }
}

import RxDataSources

struct SectionOfCustomData {
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    
    typealias Item = NewEvent
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}






