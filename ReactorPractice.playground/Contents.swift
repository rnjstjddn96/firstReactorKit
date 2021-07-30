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

var disposeBag = DisposeBag()
let observables: [String] = ["A", "B", "C", "D", "E", "F", "G"]

/*
 Observable의 변형
 */

//MARK: buffer
/*
 timeSpan: 버퍼에 저장되는 시간간격
 count: 버퍼에 저장되는 최대 이벤트 갯수
 */

let inteval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

//inteval
//    .buffer(timeSpan: .seconds(3), count: 3, scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//MARK: map vs flatMap
inteval                                                                         //Observable<Int>
//    map은 이벤트를 바꾼다. E Type이벤트를 R Type이벤트로 바꾼다
//    .map { numstr -> Observable<String> in                                    //Observable<Observable<String>>
//        return Observable<String>.create { observer in
//            observer.on(.next(String(numstr) + "a"))
//            observer.on(.next(String(numstr) + "b"))
//            return Disposables.create()
//        }
//    }
    //flatMap은 각 element를 Observable Sequence를 생성하고 이 Sequence들을 하나의 Sequence로 합친다
    .flatMap { numstr -> Observable<String> in
        return Observable<String>.create { observer in
            observer.on(.next(String(numstr) + "a"))
            observer.on(.next(String(numstr) + "b"))

            return Disposables.create()
        }
    }
    .subscribe(onNext: { _ in
//        print($0)
    })
    .disposed(by: disposeBag)

/*
 - map -
 
 ------1---2---3---4------------------- Original Sequence: Observable<T>
 
 --------------------------------------
 ---------.map { String($0) }---------- T: Int --> String
 --------------------------------------
 
 -----"1"-"2"-"3"-"4"------------------ 최종 Sequence
 
 
 
 
 - flatMap -
 ------1---2---3----------------------- Original Sequence: Observable<T>
 
 --------------------------------------
 -------flatMap { String($0) } --------
 --------------------------------------
 
 -----"1"-----------"4"---------------- Element 1으로 생성한 Sequence
 ---------"2"--------------"5"--------- Element 2으로 생성한 Sequence
 -------------"3"---------------------- Element 3으로 생성한 Sequence
 
 -----"1"-"2"-"3"---"4"----"5"--------- 최종 Sequence
 */


//MARK: flatMap
struct App {
    var memory: BehaviorSubject<Int> = .init(value: 100)
}

let mpay = App(memory: .init(value: 100))
let inch = App(memory: .init(value: 900))

var appSubject: PublishSubject<App> = .init()
//appSubject
//    .flatMap { app in
//        app.memory
//    }
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
    
//appSubject.on(.next(mpay))
//appSubject.on(.next(inch))
//
//mpay.memory.on(.next(200))

//각각의 스트림이 살아있고, 각 스트림에서 발생한 이벤트 또한 구독가능한 상태

/*
 - flatMapLatest -
 ------1---2---3----------------------- Original Sequence: Observable<T>
 
 --------------------------------------
 -------flatMap { String($0) } --------
 --------------------------------------
 
 -----"1"---------------------------- Element 1으로 생성한 Sequence
 ---------"2"---"4"------"5"--------- Element 2으로 생성한 Sequence
 --------------------"3"------"6"---- Element 3으로 생성한 Sequence
 
 -----"1"-"2"---"4"--"3"------"6"--------- 최종 Sequence
 */

//MARK: flatMapLatest
appSubject
    .flatMapLatest { app in
        app.memory
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

appSubject.on(.next(mpay))
mpay.memory.on(.next(350))
appSubject.on(.next(inch))

//가장 최근 스트림의 이벤트값만 구독하므로 출력 X
mpay.memory.on(.next(330))

inch.memory.on(.next(500))


/*
 Observable의 합성
 */
let boys = Observable.from(["1","2","3"])
let girls = Observable.from(["A","B"])

//MARK: combineLastest

/*
 ---1----2----3----
 -----A----B-------
 
 ----1A-2A-2B-3B-----
 */

//    Observable.combineLatest(boys, girls) { boy, girl in
//        return boy + girl
//    }
//    .subscribe (onNext:{ event in
//        print(event)
//    })
//    .disposed(by: disposeBag)




//MARK: withLatestFrom
//let button = PublishSubject<Void>()
//let text = PublishSubject<String>()
//
///*
// button     ---------tap------tap-----
// text       -----a-------b--c---------
//
//            ----------a--------c------
// */
//
//button
//    .withLatestFrom(text)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)
//
//text.onNext("a")
//button.onNext(())
//
//text.onNext("b")
//text.onNext("c")
//button.onNext(())

//MARK: merge
let sec1 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .skip(1)
    .map { "A: \($0)" }
let sec2 = Observable<Int>.interval(.seconds(2), scheduler: MainScheduler.instance)
    .skip(1)
    .map { "B: \($0)" }
/*
 sec1       --1--2--3--4--5--6--7--8--
 sec2       -----1-----2-----3-----4--
 
            --1--21-3--42-5--63-7--84-
 */

//Observable.merge(sec1, sec2)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//MARK: switchLatest
let aSub = PublishSubject<String>()
let bSub = PublishSubject<String>()

let switchTest = BehaviorSubject<Observable<String>>(value: aSub)

//switchTest
//    .switchLatest()
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


aSub.on(.next("A1"))
aSub.on(.next("A2"))
bSub.on(.next("B1"))    // X

switchTest.on(.next(bSub))

aSub.on(.next("A3"))    // X
bSub.on(.next("B2"))


//MARK: zip
/*
 발행 순서에 따라 합성하여 반환
 스트림이 각 2개 3개인 경우 2개의 합성된 이벤트만 반환한다.
 */

/*
 ------A---------B-------------C-
 ----------a---------b-----------
 
 ----------Aa---------Bb-----------
 */
//Observable.zip(boys.delay(.seconds(1), scheduler: MainScheduler.instance),
//               girls)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

//MARK: concat
/*
 스트림이 들어온 순서를 보장
 선행된 스트림이 완료된 이후 다음 스트림을 실행한다.
 */

/*
 -------a---b---c----------------
 ---d----e---f-------------------
 
 -------a---b---c----d--e--f-----
 */
//Observable.concat(boys, girls)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

/*
 기타 Operators
 */

//scan
//debounce vs delay vs throttle
//MARK: delay: 모든 입력을 주어진 timestamp 이후 모두 처리

//MARK: debounce: 입력 -> 대기 -> 일정 시간 후 입력

//MARK: throttle:

