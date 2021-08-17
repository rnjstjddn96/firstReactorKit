//
//  RegisterContainerViewController.swift
//  FirstReactorKit
//
//  Created by 권성우 on 2021/08/14.
//

import Foundation
import ReactorKit
import UIKit
import RxCocoa
import ViewAnimator

protocol RegisterServiceProtocol {
    var eventRelay: PublishRelay<RegisterEvent> { get }
    var currentPhase: BehaviorRelay<RegisterPhase> { get }
    var registerUserDto: RegisterUserDto { get set }
    func makeEvent(_ event: RegisterEvent)
}

enum RegisterEvent {
    enum PhaseDireaction {
        case next
        case previous
    }
    
    case updatePhase(direction: PhaseDireaction)
    case dismiss
    case register(with: RegisterUserDto)
    
    var eventId: Int {
        switch self {
        case .updatePhase: return 0
        case .dismiss: return 1
        case .register: return 2
        }
    }
}

extension RegisterEvent: Equatable {
    static func == (lhs: RegisterEvent, rhs: RegisterEvent) -> Bool {
        lhs.eventId == rhs.eventId
    }
}

class RegisterService: RegisterServiceProtocol {
    var eventRelay = PublishRelay<RegisterEvent>()
    var currentPhase: BehaviorRelay<RegisterPhase> = .init(value: .term)
    var registerUserDto: RegisterUserDto = RegisterUserDto()
    
    func makeEvent(_ event: RegisterEvent) {
        eventRelay.accept(event)
        switch event {
        case .updatePhase(let direction):
            switch direction {
            case .next:
                if let next = currentPhase.value.next {
                    currentPhase.accept(next)
                } else {
                    //다음 phase가 nil일 경우(가입 완료) -> dismiss 이벤트 emit
                    eventRelay.accept(.dismiss)
                }
            case .previous:
                if let previous = currentPhase.value.previous {
                    currentPhase.accept(previous)
                }
            }
        default:
            break
        }
    }
}

class RegisterContainerViewController: BaseViewController<RegisterConatainerReactor> {
    override func viewDidLoad() {

    }
    
    private func changeCurrentViewController(newViewController: UIViewController,
                                             phaseDirection: RegisterEvent.PhaseDireaction) {
        self.presentingViewController?.removeFromParent()
        self.addChild(newViewController)
        self.view.addSubview(newViewController.view)
        
        let animations = AnimationType.from(direction: phaseDirection == .next ? .right : .left,
                                            offset: SIZE.width)
        UIView.animate(views: [newViewController.view],
                       animations: [animations])
        
        newViewController.view.snp.makeConstraints { create in
            create.top.equalToSuperview()
            create.left.right.bottom.equalToSuperview()
        }
        
        newViewController.didMove(toParent: self)
    }
}

extension RegisterContainerViewController: View {
    func bind(reactor: RegisterConatainerReactor) {
        reactor.state
            .map { $0.destination }
            .distinctUntilChanged()
            .bind { [weak self] destination in
                guard let self = self else { return }
                if let _destination = destination {
                    self.changeCurrentViewController(newViewController: _destination,
                                                     phaseDirection: reactor.currentState.phaseDirection)
                } else {
                    self.dismiss(type: .DISMISS)
                }
            }
            .disposed(by: disposeBag)
    }
}
