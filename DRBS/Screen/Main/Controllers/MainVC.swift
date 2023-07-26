
import UIKit
import SideMenu
import SnapKit
import Then

class MainVC: UIViewController {
    //MARK: - Properties
    //UICollectionView 타입에 즉시 실행 함수 클로저 선언
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNav()
        configureCV()
    }
    
    
    
    //MARK: - Helpers
    func configureNav() {
        navigationItem.title = "DRBS"
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            $0.backgroundColor = UIColor(red: 0.43, green: 0.19, blue: 0.92, alpha: 1.00)
            navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = $0
            navigationController?.navigationBar.compactAppearance = $0
            navigationController?.navigationBar.scrollEdgeAppearance = $0
        }
    }
    
    //delegate 설정
    func configureCV() {
        view.addSubview(mainCollectionView)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // 컬렉션 뷰 항목 크기 설정
        if let layout = mainCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.bounds.width, height: 200)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.delegate = self
        
        mainCollectionView.register(MainCell1.self, forCellWithReuseIdentifier: "Cell1")
        mainCollectionView.register(MainCell2.self, forCellWithReuseIdentifier: "Cell2")
        mainCollectionView.register(MainCell3.self, forCellWithReuseIdentifier: "Cell3")
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
// 해당 셀을 등록해준다
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as! MainCell1
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! MainCell2
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell3", for: indexPath) as! MainCell3
            return cell
        default:
            fatalError("Invalid cell index")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MainCell1
        cell?.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if self.mainCollectionView.allowsMultipleSelection == true {
            let cell = collectionView.cellForItem(at: indexPath) as? MainCell1
            cell?.isSelected.toggle()
            return false
        }
        return true
    }
}

extension MainVC: UICollectionViewDelegate {
    
}
