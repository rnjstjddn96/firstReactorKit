//
//  NewEventDetailViewController.swift
//  FirstReactorKit
//
//  Created by imform-mm-2103 on 2021/08/19.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Hero

class NewEventDetailViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img7")
        return imageView
    }()
    
    var backImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "darkOnLight")
        return imageView
    }()
    
    var eventImage: UIImage?
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        addHero()
    }
    
    func addHero() {
        self.hero.isEnabled = true
        imageView.hero.id = id ?? ""
        imageView.image = (eventImage ?? UIImage(named: "img6"))?.resize(newWidth: SIZE.width)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func addView() {
        view.addSubview(imageView)
        view.addSubview(imageView2)
        view.addSubview(backImage)
    
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40.0.asPercent(with: .HEIGHT))
        }
        
        imageView2.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        backImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-50)
            $0.width.height.equalTo(30)
        }
        
        backImage.rx.tapGesture()
            .bind{ _ in
                self.hero.dismissViewController()
            }
            .disposed(by: disposeBag)
        
    }

}
