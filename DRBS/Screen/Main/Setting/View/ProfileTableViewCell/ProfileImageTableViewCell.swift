

import UIKit

import Then
import SnapKit
import AVFoundation

protocol ProfileImageCellDelegate: AnyObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func didTapProfileImage(in cell: ProfileImageTableViewCell)
    func openCamera(in cell: ProfileImageTableViewCell)
    func openPhotoLibrary(in cell: ProfileImageTableViewCell)
    func showAlertGoToSetting(in cell: ProfileImageTableViewCell)
}


class ProfileImageTableViewCell: UITableViewCell {
    
    weak var delegate: ProfileImageCellDelegate?
    
    static let id = "ProfileImageCell"
    
    // MARK: - Properties
    
    lazy var profileImageView = UIImageView().then {
        $0.image = UIImage(named: "profile_image_placeholder")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 75
        $0.layer.masksToBounds = true
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
    }
    
    lazy var menuButton = UIButton().then {
        $0.showsMenuAsPrimaryAction = true
        $0.backgroundColor = .clear

        let photoLibraryAction = UIAction(title: "사진 보관함", image: UIImage(systemName: "photo"), handler: { _ in
            self.delegate?.openPhotoLibrary(in: self)
        })

        let capturePhotoAction = UIAction(title: "사진 찍기", image: UIImage(systemName: "camera"), handler: { _ in
            self.openCamera()
        })

        let menu = UIMenu(title: "", children: [photoLibraryAction, capturePhotoAction])
        $0.menu = menu
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method & Action
    
    private func setupCell() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(menuButton)

        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.width.height.equalTo(150)
        }
        
        menuButton.snp.makeConstraints {
            $0.edges.equalTo(profileImageView)
        }
    }


    func setImage(_ image: UIImage) {
        profileImageView.image = image
    }
    
    func configure(with model: ProfileImageModel) {
        if let image = model.image {
            self.setImage(image)
        }
    }

    @objc private func openCamera() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
            guard let self = self else { return }
            if isAuthorized {
                DispatchQueue.main.async {
                    self.delegate?.openCamera(in: self)
                }
            } else {
                self.delegate?.showAlertGoToSetting(in: self)
            }
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }

        self.profileImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - override
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
