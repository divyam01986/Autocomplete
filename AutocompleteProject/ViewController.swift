
import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var autoCompleteView: AutocompleteView = {
        return AutocompleteView(cellType: AutocompleteCell.self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        layoutViews()
    }
    
    private func layoutViews() {
        view.addSubview(autoCompleteView)
        autoCompleteView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }

}
