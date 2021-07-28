import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class MyViewController: UIViewController, View {
    //Observable Stream 생명주기 관리를 위한 disposeBag 선언
    var disposeBag = DisposeBag()
    
    /*View와 View에 주입할 Reactor를 Bind
        1. View의 Action과 Reactor의 Action을 binding
        2. Reactor의 State값 이벤트 구독 및 처리
    */
    func bind(reactor: MyReactor) {
        
    }
}

class MyReactor: Reactor {
    //Action에 대한 정의
    enum Action {
        
    }
    
    //변화에 대한 정의
    enum Mutation {
        
    }
    
    //상태값들의 집합
    struct State {
        
    }

    //상태값들의 초기값
    var initialState = State()
    
    
    //Action에 따른 mutation을 Observable Stream 형태로 리턴
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    //mutation의 변화를 state값에 반영 및 State 이벤트 발생
    func reduce(state: State, mutation: Mutation) -> State {
        
    }
}
