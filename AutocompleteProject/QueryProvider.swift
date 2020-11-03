import RxSwift
import RxCocoa

final class QueryProvider {
    func  query(text: String) -> Observable<[String]> {
        if text.isEmpty {
            return Observable.just([String]())
        }
        return Observable.just(["India",
                                "Canada",
                                "USA"])
    }
}
