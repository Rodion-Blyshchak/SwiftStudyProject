//
//  AddCarViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 27.12.2025.
//

import UIKit

protocol AddCarViewDelegate {
	func didAddNewCar(car: CarModel)
}

class AddCarViewController: UIViewController {
	private enum ConstantsSize {
		static let spacing: CGFloat = 10
		static let cornerRadius: CGFloat = 8
		static let heightAnchor: CGFloat = 40
		static let font: CGFloat = 18
		static let mainIndent: CGFloat = 16
		static let negativeMainIndent: CGFloat = -16
		static let mainTopIndent: CGFloat = 20
	}
	
	private enum KeyStorageManager {
		static let brandKey: String = "Brand"
		static let modelKey: String = "Model"
		static let accelerationKey: String = "Acceleration"
		static let weightKey: String = "Weight"
	}

	//MARK: - Properties
	var delegate: AddCarViewDelegate?
	private lazy var notificationManager = NotificationManager()
	private let defaults = UserDefaults.standard
	
	private lazy var scrollView = UIScrollView()
	private lazy var contentView = UIView()
	private lazy var cancelButton = UIButton()
	private lazy var addCardButton = UIButton()

	private lazy var topStrip: UIView = {
		let strip = UIView()
		strip.translatesAutoresizingMaskIntoConstraints = false
		strip.backgroundColor = .appBlack
		strip.layer.cornerRadius = ConstantsSize.cornerRadius
		strip.widthAnchor.constraint(equalToConstant: 120).isActive = true
		strip.heightAnchor.constraint(equalToConstant: 4).isActive = true
		return strip
	}()
	
	private lazy var headerStackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.alignment = .top
		stack.distribution = .equalSpacing
		stack.spacing = ConstantsSize.spacing
		return stack
	}()
	
	private lazy var imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.heightAnchor.constraint(equalToConstant: 200).isActive = true
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = ConstantsSize.cornerRadius
		image.layer.borderWidth = 1.0
		image.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		return image
	}()
	
	private lazy var addPhotoButton: UIButton = {
		let addButton = UIButton()
		let buttonImage = UIImage(named: "Photo")
		addButton.setImage(buttonImage, for: .normal)
		addButton.heightAnchor.constraint(equalToConstant: ConstantsSize.heightAnchor).isActive = true
		addButton.layer.cornerRadius = ConstantsSize.cornerRadius
		addButton.backgroundColor = .appBlue
		addButton.addTarget(self, action: #selector(didTapAddPhoto), for: .touchUpInside)
		return addButton
	}()
	
	private lazy var brandTextField = UITextField()
	private lazy var modelTextField = UITextField()
	private lazy var accelerationTextField = UITextField()
	private lazy var weightTextField = UITextField()
	
	private lazy var descriptionTextField: UITextView = {
		let description = UITextView()
		description.translatesAutoresizingMaskIntoConstraints = false
		description.backgroundColor = .appLight
		description.text = "Description"
		description.textColor = .placeholderText
		description.layer.cornerRadius = ConstantsSize.cornerRadius
		description.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
		description.font = .systemFont(ofSize: ConstantsSize.font)
		description.delegate = self
		description.returnKeyType = .done
		description.heightAnchor.constraint(equalToConstant: 200).isActive = true
		return description
	}()
	
	private lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = ConstantsSize.spacing
		return stack
	}()
	
	//MARK: - ViewDidLoad
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		let tapOutsideKeyboard = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
		view.addGestureRecognizer(tapOutsideKeyboard)
		
		setupScrollView()
		setupContentView()
		setupHeaderButton()
		setupTextField()
		setupHeaderStackView()
		setupStackView()
	}
	
	@objc private func closeScreen() {
		self.dismiss(animated: true)
	}
	
	//MARK: - Func scrollToActiveField
	private func scrollToActiveField() {
		guard let activeView = stackView.arrangedSubviews.first(where: { $0.isFirstResponder}) else { return }
		let coordinates = stackView.convert(activeView.frame, to: scrollView)
		let visibleHeight = (scrollView.frame.height - scrollView.contentInset.bottom) - ConstantsSize.mainIndent
		let offset = CGPoint(x: 0, y: coordinates.maxY - visibleHeight)
		scrollView.setContentOffset(offset, animated: true)
	}
	
	//MARK: - Func didTapAddPhoto
	@objc private func didTapAddPhoto() {
		let picker = UIImagePickerController()
		picker.delegate = self
		let alert = UIAlertController(title: "Додати фото", message: "обери метод", preferredStyle: .actionSheet)
		
		let cancelAction = UIAlertAction(title: "Скасувати", style: .cancel)
		cancelAction.setValue(UIColor.appRed, forKey: "titleTextColor")
		
		alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
			if UIImagePickerController.isSourceTypeAvailable(.camera) {
				picker.sourceType = .camera
				self.present(picker, animated: true)
			} else {
				let	aletError = UIAlertController(title: "Камера не доступна", message: "щось", preferredStyle: .alert)
				aletError.addAction(cancelAction)
				self.present(aletError, animated: true)
			}
		}))
		
		alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
			picker.sourceType = .photoLibrary
			self.present(picker, animated: true)
		}))
		
		alert.addAction(cancelAction)
		
		picker.allowsEditing = true
		present(alert, animated: true)
	}
	
	//MARK: - Func didAddTapNewCard
	@objc private func didAddTapNewCard() {
		let description = (descriptionTextField.textColor == .lightGray) ? "" : (descriptionTextField.text ?? "")
		
		let newCardModel = CarModel(
			id: UUID().uuidString,
			image: imageView.image ?? UIImage(named: "Neon orange glasses on silhouette profile")!,
			name: modelTextField.text ?? "",
			team: brandTextField.text ?? "",
			description: description,
			maxSpeed: 0,
			acceleration: Float(accelerationTextField.text ?? "") ?? 0.0,
			weight: Int(weightTextField.text ?? "") ?? 0
		)
		
		let keys = [
			KeyStorageManager.brandKey,
			KeyStorageManager.modelKey,
			KeyStorageManager.accelerationKey,
			KeyStorageManager.weightKey
		]
		keys.forEach { defaults.removeObject(forKey: $0) }
		
		delegate?.didAddNewCar(car: newCardModel)
		closeScreen()
	}
	
	//MARK: - Func storageManager
	private func saveStorageManager(vaule: String?, key: String) {
		defaults.set(vaule, forKey: key)
	}
	
	private func loadStorageManager(key: String) -> String? {
		return defaults.string(forKey: key)
	}
	
	//MARK: - Setup func
	private func setupHeaderButton() {
		[cancelButton, addCardButton].forEach{button in
			button.heightAnchor.constraint(equalToConstant: ConstantsSize.heightAnchor).isActive = true
			button.widthAnchor.constraint(equalToConstant: 90).isActive = true
			button.layer.cornerRadius = ConstantsSize.cornerRadius
			button.setTitleColor(.white, for: .normal)
		}
		
		cancelButton.backgroundColor = .appGreyDark
		cancelButton.setTitle("Cancel", for: .normal)
		cancelButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
		
		addCardButton.backgroundColor = .appBlue
		addCardButton.setTitle("Add", for: .normal)
		addCardButton.addTarget(self, action: #selector(didAddTapNewCard), for: .touchUpInside)
	}
	
	private func setupTextField() {
		[brandTextField, modelTextField, accelerationTextField, weightTextField].forEach{textField in
			textField.translatesAutoresizingMaskIntoConstraints = false
			textField.backgroundColor = .appLight
			textField.textColor = .appBlack
			textField.layer.cornerRadius = ConstantsSize.cornerRadius
			let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: ConstantsSize.mainIndent, height: 0))
			textField.leftView = paddingView
			textField.leftViewMode = .always
			textField.heightAnchor.constraint(equalToConstant: ConstantsSize.heightAnchor).isActive = true
			textField.delegate = self
			textField.returnKeyType = .next
			textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		}
		
		brandTextField.placeholder = "Brand"
		modelTextField.placeholder = "Model"
		accelerationTextField.placeholder = "0-100 km/h"
		weightTextField.placeholder = "Weight"
		
		brandTextField.text = loadStorageManager(key: KeyStorageManager.brandKey)
		modelTextField.text = loadStorageManager(key: KeyStorageManager.modelKey)
		accelerationTextField.text = loadStorageManager(key: KeyStorageManager.accelerationKey)
		weightTextField.text = loadStorageManager(key: KeyStorageManager.weightKey)
	}
	
	@objc private func textFieldDidChange(_ textField: UITextField) {
		let mapping: [UITextField: String] = [
			brandTextField: KeyStorageManager.brandKey,
			modelTextField: KeyStorageManager.modelKey,
			accelerationTextField: KeyStorageManager.accelerationKey,
			weightTextField: KeyStorageManager.weightKey
		]
		
		if let key = mapping[textField] {
			saveStorageManager(vaule: textField.text ?? "", key: key)
		}
	}
	
	//MARK: - StacksView
	private func setupScrollView() {
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		notificationManager.delegate = self
		
		view.addSubview(scrollView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func setupContentView() {
		contentView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.addSubview(contentView)
		
		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
		])
	}
	
	private func setupHeaderStackView() {
		headerStackView.addArrangedSubview(cancelButton)
		headerStackView.addArrangedSubview(topStrip)
		headerStackView.addArrangedSubview(addCardButton)
		
		contentView.addSubview(headerStackView)
		
		NSLayoutConstraint.activate([
			headerStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: ConstantsSize.mainTopIndent),
			headerStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: ConstantsSize.mainIndent),
			headerStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: ConstantsSize.negativeMainIndent)
		])
	}
	
	private func setupStackView() {
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(addPhotoButton)
		stackView.addArrangedSubview(brandTextField)
		stackView.addArrangedSubview(modelTextField)
		stackView.addArrangedSubview(accelerationTextField)
		stackView.addArrangedSubview(weightTextField)
		stackView.addArrangedSubview(descriptionTextField)
		
		contentView.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: ConstantsSize.mainTopIndent),
			stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: ConstantsSize.mainIndent),
			stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: ConstantsSize.negativeMainIndent),
			stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
		])
	}
}

//MARK: - Extension
// TextField
extension AddCarViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		let textFields: [UITextField] = [brandTextField, modelTextField, accelerationTextField, weightTextField]
		
		if let curentIndex = textFields.firstIndex(of: textField) {
			if curentIndex < textFields.count - 1 {
				textFields[curentIndex + 1].becomeFirstResponder()
			} else {
				descriptionTextField.becomeFirstResponder()
			}
		}
		return true
	}
}

// Для зміни кольору тексу та ховання клавіатури при натиску на ентер
extension AddCarViewController: UITextViewDelegate {
	func textViewDidChange(_ textView: UITextView) {
		if textView.textColor == .placeholderText {
			textView.text = nil
			textView.textColor = .appBlack
		}
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if text == "\n" {
			textView.resignFirstResponder()
			return false
		}
		return true
	}
}

// ImagePicker
extension AddCarViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[.originalImage] as? UIImage {
			self.imageView.image = image
		}
		picker.dismiss(animated: true)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
}

extension AddCarViewController: UINavigationControllerDelegate {}

extension AddCarViewController: NotificationManagerDelegate {
	func keyboardToggle(height: CGFloat, isOn: Bool) {
		scrollView.contentInset.bottom = height
		scrollView.verticalScrollIndicatorInsets.bottom = height
		
		scrollToActiveField()
	}
}
