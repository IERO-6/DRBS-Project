
import UIKit

import Then
import SnapKit

class MyPageVC: UIViewController {
    
    // MARK: - Properties
    
    private let myPageTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    
    
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNav()
    }
    
    
    
    
    
    // MARK: - Method & Configure
    
    func configureNav() {
        navigationItem.title = "마이페이지"
        //navigationItem.leftBarButtonItem
        
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = UIColor(red: 0.43, green: 0.19, blue: 0.92, alpha: 1.00)
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
            
        }
        
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }




}
