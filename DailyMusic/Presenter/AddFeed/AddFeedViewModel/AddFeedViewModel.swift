//
//  AddFeedViewModel.swift
//  DailyMusic
//
//  Created by 왕정빈 on 2024/04/16.
//

import UIKit
import RxCocoa
import RxSwift

final class AddFeedViewModel {

    let feedUseCase: FeedUseCase
    
    init(feedUseCase: FeedUseCase) {
        self.feedUseCase = feedUseCase
    }
    
    struct Input {
        let captionText: Observable<String>
        let musicImage: Observable<UIImage>
        let uploadButtonDidTap: Observable<Void>
    }
    
    struct Output {
        let uploadCompleted: Driver<Void>
        let uploadFailed: Driver<Error>
        let isUploading: Driver<Bool>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let uploadCompleted = PublishRelay<Void>()
        let uploadFailed = PublishRelay<Error>()
        let isUploading = BehaviorRelay<Bool>(value: false)
        
        input.uploadButtonDidTap
            .withLatestFrom(Observable.combineLatest(input.captionText,
                                                     input.musicImage))
            .flatMapLatest { [weak self] caption, image in
                guard let self = self else {
                    return Single<Void>.error(NSError(domain: "AddFeedViewModel", code: -1, userInfo: [NSLocalizedDescriptionKey: "Self is nil"]))
                }
                isUploading.accept(true)
                
                let feed = Feed(caption: caption, imageURL: nil, timestamp: nil)
                return self.feedUseCase.uploadFeed(feed: feed, image: image)
            }
            .subscribe { event in
                isUploading.accept(false)
                switch event {
                case .next:
                    uploadCompleted.accept(())
                case .error(let error):
                    uploadFailed.accept(error)
                default:
                    break
                }
            }
            .disposed(by: disposeBag)

        
        return Output(uploadCompleted: uploadCompleted.asDriver(onErrorJustReturn: ()),
                      uploadFailed: uploadFailed.asDriver(onErrorJustReturn: NSError(domain: "Feed Upload Error", code: -1)),
                      isUploading: isUploading.asDriver(onErrorJustReturn: false)
        )
    }
}
