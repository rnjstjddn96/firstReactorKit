//
//  TableViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/03.
//

import Foundation
import ReactorKit
import RxCocoa
import RxGesture

class TableViewController: UIViewController, UITableViewDelegate {
 
    let tableView = UITableView()
    
//    let items = BehaviorSubject(value: [EventData(eventImage: UIImage(named: "img1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
//                                        EventData(eventImage: UIImage(named: "img2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
//                                        EventData(eventImage: UIImage(named: "img3")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
//                                        EventData(eventImage: UIImage(named: "img4")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
//                                        EventData(eventImage: UIImage(named: "img5")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
//                                        EventData(eventImage: UIImage(named: "img6")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")])
//    let disposeBag = DisposeBag()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .white
//        addTableView()
//        initDataSource()
//        configure()
//        cellClick()
//    }
//
//    private func initDataSource() {
//        self.items
//            .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { row, element, cell in
//                cell.evnetImageView.image = element.eventImage
//                cell.titleLabel.text = element.eventTitle
//                cell.subTitleLabel.text = element.eventSubTitle
//                cell.imageTap.subscribe(onNext: {_ in
//                    print("imageTap : \(row)")
//                }).disposed(by: self.disposeBag)
//        }.disposed(by: disposeBag)
//    }
//
//    func configure() {
//        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
//
//        tableView.rx
//            .setDelegate(self)
//            .disposed(by: disposeBag)
//    }
//
//    func cellClick() {
//        tableView.rx.itemSelected
//            .subscribe(onNext: { index in
//                print("row : \(index.row)")
//            })
//            .disposed(by: disposeBag)
//
//        tableView.rx.modelSelected(EventData.self)
//            .subscribe(onNext: { event in
//                print("modelSelected : \(event.eventTitle ?? "" )")
//                print("modelSelected : \(event.eventSubTitle ?? "")")
//            })
//            .disposed(by: disposeBag)
//    }
//
//    func addTableView() {
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints {
//            $0.top.equalTo(self.view.safeAreaLayoutGuide)
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
//            $0.left.right.equalToSuperview()
//        }
//        tableView.rowHeight = 10.0.asPercent(with: .HEIGHT)
//    }
//
    
    
}



