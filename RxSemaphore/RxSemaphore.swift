//
//  RxSemaphore.swift
//  Nimble
//
//  Created by 李凌峰 on 2020/1/31.
//

import Foundation
import RxSwift

public enum RxSemaphoreAction<Value> {
    case wait(Value)
    case signal

    public var value: Value? {
        switch self {
        case .wait(let value):
            return value
        case .signal:
            return nil
        }
    }
}

public typealias RxSemaphoreTransform<Element> = (Element) -> RxSemaphoreAction<Element>

extension ObservableType {

    public static func semaphore<C: Swift.Collection>(_ collection: C,
                                                      transform: @escaping RxSemaphoreTransform<Element>)
        -> Observable<RxSemaphoreAction<Element>> where C.Element == Observable<Element> {
            let seed: BehaviorSubject<RxSemaphoreAction<Element>> = BehaviorSubject(value: .signal)
            let sources = collection.map { o in
                return o.materialize()
                    .flatMap({ event -> Observable<RxSemaphoreAction<Element>> in
                        switch event {
                        case .next(let element):
                            return .just(transform(element))
                        case .error(let error):
                            return .error(error)
                        case .completed:
                            return .just(.signal)
                        }
                    })
                    .map { value -> BehaviorSubject<RxSemaphoreAction<Element>> in
                        let subject = BehaviorSubject(value: value)
                        if case .signal = value {
                            subject.onCompleted()
                        }
                        return subject
                }
                .scan(seed) { (previous, next) in
                    previous.onCompleted()
                    return next
                }
                .map {
                    $0.asObservable()
                }
            }
            return Observable.merge(sources)
                .concatMap { o -> Observable<RxSemaphoreAction<Element>> in
                    return o.concat(Observable.just(.signal))
            }
            .distinctUntilChanged { (l, r) -> Bool in
                switch (l, r) {
                case (.signal, .signal):
                    return true
                default:
                    return false
                }
            }
    }

    public static func semaphore<C: Swift.Collection>(_ collection: C)
        -> Observable<RxSemaphoreAction<Element>> where C.Element == Observable<Element> {
            return semaphore(collection) { .wait($0) }
    }

    public static func semaphore<C: Swift.Collection>(_ collection: C)
        -> Observable<Element?> where C.Element == Observable<Element?> {
            let seed: BehaviorSubject<RxSemaphoreAction<Element>> = BehaviorSubject(value: .signal)
            let sources = collection.map { o in
                return o.materialize()
                    .flatMap({ event -> Observable<RxSemaphoreAction<Element>> in
                        switch event {
                        case .next(let maybeElement):
                            if let element = maybeElement {
                                return .just(.wait(element))
                            } else {
                                return .just(.signal)
                            }
                        case .error(let error):
                            return .error(error)
                        case .completed:
                            return .just(.signal)
                        }
                    })
                    .map { value -> BehaviorSubject<RxSemaphoreAction<Element>> in
                        let subject = BehaviorSubject(value: value)
                        if case .signal = value {
                            subject.onCompleted()
                        }
                        return subject
                }
                .scan(seed) { (previous, next) in
                    previous.onCompleted()
                    return next
                }
                .map {
                    $0.asObservable()
                }
            }
            return Observable.merge(sources)
                .concatMap { o -> Observable<RxSemaphoreAction<Element>> in
                    return o.concat(Observable.just(.signal))
            }
            .distinctUntilChanged { (l, r) -> Bool in
                switch (l, r) {
                case (.signal, .signal):
                    return true
                default:
                    return false
                }
            }
            .map {
                $0.value
            }
    }

}
