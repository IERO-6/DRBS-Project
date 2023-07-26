

import UIKit

import Then
import SnapKit

class AddressTableViewCell: UITableViewCell {
    
    static let id = "AddressCell"
    
    // MARK: - Properties

    private lazy var addressLabel = UILabel().then {
        $0.textColor = .systemGray3
        $0.numberOfLines = 0
    }

    private let rightButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .lightGray
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(addressLabel)
        contentView.addSubview(rightButton)
        contentView.addSubview(separatorView)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    // MARK: - Configure
    
    private func setupLayout() {
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(20)
            $0.centerY.equalTo(contentView)
        }

        rightButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-20)
            $0.centerY.equalTo(contentView)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(20)
            $0.trailing.equalTo(contentView).offset(-20)
            $0.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(with model: AddressModel) {
        if let address = model.address, !address.isEmpty {
            addressLabel.text = format(address: address)
        } else {
            addressLabel.text = "주소를 설정해주세요"
        }
    }

    private func format(address: String) -> String {
        // 주소 포맷팅 로직
        let components = address.components(separatedBy: ", ")
        guard components.count == 4 else { return address } // 주소 형식이 맞지 않는 경우, 원본 그대로 반환
        let formattedAddress = "\(components[1]), \(components[0])\n\(components[2]), \(components[3])"
        return formattedAddress
    }



}
