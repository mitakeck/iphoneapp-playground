//
//  SessionRx.swift
//  Github
//
//  Created by mitake on 2017/04/20.
//  Copyright © 2017 mitake. All rights reserved.
//

import APIKit
import RxSwift

extension Session {
    func rx_sendRequest<T: Request>(request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = self.send(request) { result in
                switch result {
                case .success(let res):
                    observer.on(.next(res))
                    observer.on(.completed)
                case .failure(let err):
                    observer.onError(err as! Error)
                }
            }
            return AnonymousDisposable { [weak task] in
                task?.cancel()
            }
        }
    }
}
