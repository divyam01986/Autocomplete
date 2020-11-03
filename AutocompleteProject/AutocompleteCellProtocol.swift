import UIKit
import Foundation

protocol AutocompleteCellProtocol: class {
    
    func populate(data: Any)
}

extension AutocompleteCellProtocol where Self: UITableViewCell {}
