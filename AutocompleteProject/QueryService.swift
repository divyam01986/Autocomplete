import RxSwift
import RxCocoa

final class QueryService {
    let provider: QueryProvider
    
    init(provider: QueryProvider) {
        self.provider = provider
    }
    
    func autocomplete(text: Observable<String>) -> Driver<[String]> {
        let result: Driver<[String]> = text.ifEmpty(default: "")
            .flatMapLatest { [weak self] query -> Observable<[String]> in
                return self?.provider.query(text: query) ?? Observable.just([String]())
            }.asDriver(onErrorJustReturn: [""])
        return result
    }
}
