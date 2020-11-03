import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AutocompleteView: UIView {
    private let searchField: UITextField = {
        let field = UITextField()
        field.backgroundColor = UIColor.gray
        return field
    }()
    
    private let tableView = UITableView()
    private var rows = 0
    private let disposeBag = DisposeBag()
    private let queryProvider = QueryService(provider: QueryProvider())
    
    init<T: AutocompleteCellProtocol>(cellType: T.Type) {
        super.init(frame: CGRect.zero)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        tableView.register(AutocompleteCell.self, forCellReuseIdentifier: "AutocompleteCell")
        
        let query = searchField
            .rx
            .text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        let result = queryProvider.autocomplete(text: query)
        
        let hits: Driver<[String]> = result
        hits
            .drive(tableView
                .rx
                .items(cellIdentifier: "AutocompleteCell", cellType: AutocompleteCell.self)) { (_, element, cell) in
            cell.populate(data: element)
        }.disposed(by: disposeBag)
    }
    
    func layout() {
        addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(55)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchField.snp.bottom).offset(24)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
}
