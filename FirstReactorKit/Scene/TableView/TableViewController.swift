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
    
    let items = BehaviorSubject(value: [EventData(eventImage: UIImage(named: "img1")!, eventTitle: "eventTitle 1", eventSubTitle: "eventSubTitle 1"),
                                        EventData(eventImage: UIImage(named: "img2")!, eventTitle: "eventTitle 2", eventSubTitle: "eventSubTitle 2"),
                                        EventData(eventImage: UIImage(named: "img3")!, eventTitle: "eventTitle 3", eventSubTitle: "eventSubTitle 3"),
                                        EventData(eventImage: UIImage(named: "img4")!, eventTitle: "eventTitle 4", eventSubTitle: "eventSubTitle 4"),
                                        EventData(eventImage: UIImage(named: "img5")!, eventTitle: "eventTitle 5", eventSubTitle: "eventSubTitle 5"),
                                        EventData(eventImage: UIImage(named: "img6")!, eventTitle: "eventTitle 6", eventSubTitle: "eventSubTitle 6")])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addTableView()
        initDataSource()
        configure()
        cellClick()
    }
    
    private func initDataSource() {
        self.items
            .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { row, element, cell in
                cell.evnetImageView.image = element.eventImage
                cell.titleLabel.text = element.eventTitle
                cell.subTitleLabel.text = element.eventSubTitle
                cell.imageTap.subscribe(onNext: {_ in
                    print("imageTap : \(row)")
                }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }
    
    func configure() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func cellClick() {
        tableView.rx.itemSelected
            .subscribe(onNext: { index in
                print("row : \(index.row)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(EventData.self)
            .subscribe(onNext: { event in
                print("modelSelected : \(event.eventTitle ?? "" )")
                print("modelSelected : \(event.eventSubTitle ?? "")")
            })
            .disposed(by: disposeBag)
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        tableView.rowHeight = 10.0.asPercent(with: .HEIGHT)
    }
    
    
    
}


class TableViewCell: UITableViewCell {
    
    static let identifier = "TableViewCell"
    
    let evnetImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()
    
    let subTitleLabel: UILabel = {
        let subTitleLabel = UILabel()
        subTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return subTitleLabel
    }()
    
    var imageTap: Observable<ControlEvent<UITapGestureRecognizer>.Element> {
        return evnetImageView.rx.tapGesture().when(.recognized)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        autoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubview(evnetImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    private func autoLayout() {
        evnetImageView.snp.makeConstraints {
            $0.top.leading.height.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(evnetImageView.snp.right).offset(10)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalTo(evnetImageView.snp.right).offset(10)
            
        }
    }
}
