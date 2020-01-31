import UIKit
import RxSwift
import RxSemaphore

let disposeBag = DisposeBag()
let o1 = PublishSubject<Int>()
let o2 = PublishSubject<Int>()

Observable.semaphore([o1, o2])
    .subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: disposeBag)

o1.onNext(1)
o2.onNext(2)
o2.onNext(3)
o1.onNext(4)
o2.onCompleted()
o1.onCompleted()

