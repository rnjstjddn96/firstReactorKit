////
////  EventViewController.swift
////  FirstReactorKit
////
////  Created by imform-mm-2103 on 2021/08/05.
////
//
//import UIKit
//import SnapKit
//
//class EventViewController: StatusBarAnimatableViewController, UIScrollViewDelegate, UINavigationControllerDelegate {
//
//    private var transition: CardTransition?
//
//    var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 90.0.asPercent(with: .WIDTH),
//                                 height: 90.0.asPercent(with: .WIDTH))
//        layout.minimumLineSpacing = 5.0.asPercent(with: .WIDTH)
//        let uiCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        uiCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5.0.asPercent(with: .WIDTH), bottom: 0, right: 5.0.asPercent(with: .WIDTH))
//        uiCollectionView.showsHorizontalScrollIndicator = false
//        uiCollectionView.delaysContentTouches = false
//        uiCollectionView.backgroundColor = .systemPink
//        return uiCollectionView
//    }()
//
//    var eventDatas: [EventData] = [EventData(eventImage: UIImage(named: "event1")!
//                                    .resize(toWidth: UIScreen.main.bounds.size.width * (1/GlobalConstants.cardHighlightedFactor)), eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
//                                   EventData(eventImage: UIImage(named: "event2")!
//                                    .resize(toWidth: UIScreen.main.bounds.size.width * (1/GlobalConstants.cardHighlightedFactor)), eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
//                                   EventData(eventImage: UIImage(named: "img3")!
//                                    .resize(toWidth: UIScreen.main.bounds.size.width * (1/GlobalConstants.cardHighlightedFactor)), eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
//                                   EventData(eventImage: UIImage(named: "img4")!
//                                    .resize(toWidth: UIScreen.main.bounds.size.width * (1/GlobalConstants.cardHighlightedFactor)), eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
//                                   EventData(eventImage: UIImage(named: "img5")!
//                                    .resize(toWidth: UIScreen.main.bounds.size.width * (1/GlobalConstants.cardHighlightedFactor)), eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
//                                   EventData(eventImage: UIImage(named: "img6")!
//                                    .resize(toWidth: UIScreen.main.bounds.size.width * (1/GlobalConstants.cardHighlightedFactor)), eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")]
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .white
//        collectionViewInit()
//        navigationController?.delegate = self
//    }
//
//    func collectionViewInit() {
//        view.addSubview(collectionView)
//
//        collectionView.snp.makeConstraints {
//            $0.centerX.centerY.equalToSuperview()
//            $0.width.equalToSuperview()
//            $0.height.equalTo(90.0.asPercent(with: .WIDTH))
//        }
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.clipsToBounds = false
//        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
//    }
//
//    override var statusBarAnimatableConfig: StatusBarAnimatableConfig {
//        return StatusBarAnimatableConfig(prefersHidden: false, animation: .slide)
//    }
//
//    var currentIdx: CGFloat = 0.0
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//
//        if let cv = scrollView as? UICollectionView {
//            let layout = cv.collectionViewLayout as! UICollectionViewFlowLayout
//            let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
//            var offset = targetContentOffset.pointee
//            let idx = round((offset.x + cv.contentInset.left) / cellWidth)
//
//            if idx > currentIdx {
//                currentIdx += 1
//            } else if idx < currentIdx {
//                if currentIdx != 0 {
//                    currentIdx -= 1
//                }
//            }
//
//            offset = CGPoint(x: currentIdx * cellWidth - cv.contentInset.left, y: 0)
//            targetContentOffset.pointee = offset
//        }
//    }
//
//}
//
//extension EventViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return eventDatas.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let cell = cell as! CollectionViewCell
//        cell.eventData = eventDatas[indexPath.row]
//    }
//}
//
//extension EventViewController {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cardHorizontalOffset: CGFloat = 20
//        let cardHeightByWidthRatio: CGFloat = 1.2
//        let width = collectionView.bounds.size.width - 2 * cardHorizontalOffset
//        let height: CGFloat = width * cardHeightByWidthRatio
//        return CGSize(width: width, height: height)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        // Get tapped cell location
//        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
//
//        // Freeze highlighted state (or else it will bounce back)
//        cell.freezeAnimations()
//
//        // Get current frame on screen
//        let currentCellFrame = cell.layer.presentation()!.frame
//
//        // Convert current frame to screen's coordinates
//        let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)
//
//        // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
//        let cardFrameWithoutTransform = { () -> CGRect in
//            let center = cell.center
//            let size = cell.bounds.size
//            let r = CGRect(
//                x: center.x - size.width / 2,
//                y: center.y - size.height / 3,
//                width: size.width,
//                height: size.height
//            )
//            return cell.superview!.convert(r, to: nil)
//        }()
//
//        let eventData = eventDatas[indexPath.row]
//
//        // Set up card detail view controller
//        let vc = EventDetailViewController()
//        vc.eventData = eventData.highlightedImage()
//        vc.unhighlightedEventData = eventData // Keep the original one to restore when dismiss
//        let params = CardTransition.Params(fromCardFrame: cardPresentationFrameOnScreen,
//                                           fromCardFrameWithoutTransform: cardFrameWithoutTransform,
//                                           fromCell: cell)
//        transition = CardTransition(params: params)
//        vc.transitioningDelegate = transition
//
////         If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
//        vc.modalPresentationCapturesStatusBarAppearance = true
//        vc.modalPresentationStyle = .overCurrentContext
//
//        present(vc, animated: true, completion: { [unowned cell] in
//            // Unfreeze
//            cell.unfreezeAnimations()
//        })
//    }
//}
//
//
