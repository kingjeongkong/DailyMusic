//
//  HomeViewModel.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/16.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    
    let feedUseCase: FeedUseCase
    
    init(feedUseCase: FeedUseCase) {
        self.feedUseCase = feedUseCase
        
        getFeeds()
            .take(1)
            .bind(to: feedsRelay)
            .disposed(by: disposeBag)
    }
    
    struct Input {
        let refreshEvent: Observable<Void>
    }
    
    struct Output {
        let feeds: Driver<[Feed]>
        let errorMessage: Driver<String>
    }
    
    var disposeBag = DisposeBag()
    private let feedsRelay = BehaviorRelay<[Feed]>(value: [])
    private let errorMessageRelay = BehaviorRelay<String>(value: "")
    
    func transform(input: Input) -> Output {
        input.refreshEvent
            .flatMapLatest { [weak self] in
                self?.getFeeds() ?? .empty()
            }
            .subscribe(onNext: { [weak self] feeds in
                self?.feedsRelay.accept(feeds)
            })
            .disposed(by: disposeBag)
        
        return Output(feeds: feedsRelay.asDriver(),
                      errorMessage: errorMessageRelay.asDriver()
        )
    }
}

// MARK: - API 로직
extension HomeViewModel {
    func getFeeds() -> Observable<[Feed]> {
        return feedUseCase.getFeed()
            .retry(3)
            .asObservable()
            .catchAndReturn([])
            .do(onError: { [weak self] error in
                self?.errorMessageRelay.accept("Failed to fetch feeds: \(error.localizedDescription)")
            })
    }
}
