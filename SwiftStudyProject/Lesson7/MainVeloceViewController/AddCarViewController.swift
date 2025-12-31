//
//  AddCarViewController.swift
//  SwiftStudyProject
//
//  Created by Rodion Blyshchak on 27.12.2025.
//

import UIKit

protocol AddCarViewDelegate {
	func didAddNewCar(car: ViewNewCellViewModel)
}

class AddCarViewController: UIViewController {
	var delegate: AddCarViewDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .appWhite
		headerSetupStack()
		setupStack()
	}
	
	//MARK: - Header stack
	private func headerButton(color: UIColor, text: String, addTarget: Selector) -> UIButton {
		let button = UIButton()
		button.heightAnchor.constraint(equalToConstant: 35).isActive = true
		button.widthAnchor.constraint(equalToConstant: 90).isActive = true
		button.layer.cornerRadius = 8
		button.backgroundColor = color
		button.setTitle(text, for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.addTarget(self, action: addTarget, for: .touchUpInside)
		return button
	}
	@objc private func closeScreen() {
		self.dismiss(animated: true)
	}
	
	private lazy var cancelButton = headerButton(color: .appGreyDark, text: "Cancel", addTarget: #selector(closeScreen))
	private lazy var addCardButton = headerButton(color: .appBlue, text: "Add", addTarget: #selector(didAddTapNewCard))
	
	private lazy var topStrip: UIView = {
		let strip = UIView()
		strip.translatesAutoresizingMaskIntoConstraints = false
		strip.backgroundColor = .appBlack
		strip.layer.cornerRadius = 2
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
		stack.spacing = 10
		return stack
	}()
	
	private func headerSetupStack() {
		headerStackView.addArrangedSubview(cancelButton)
		headerStackView.addArrangedSubview(topStrip)
		headerStackView.addArrangedSubview(addCardButton)
		
		view.addSubview(headerStackView)
		
		NSLayoutConstraint.activate([
			headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
			headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
		])
	}
	
	//MARK: - Stack
	private lazy var imageView: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.heightAnchor.constraint(equalToConstant: 200).isActive = true
		image.contentMode = .scaleAspectFill
		image.clipsToBounds = true
		image.layer.cornerRadius = 8
		image.layer.borderWidth = 1.0
		image.layer.borderColor = UIColor(named: "appGreyDark")?.cgColor
		return image
	}()
	
	//MARK: - Func didTapAddPhoto
	@objc private func didTapAddPhoto() {
		let picker = UIImagePickerController()
		picker.delegate = self
		let alert = UIAlertController(title: "Додати фото", message: "обери метод", preferredStyle: .actionSheet)
		
		let cancelAction = UIAlertAction(title: "Скасувати", style: .cancel)
		cancelAction.setValue(UIColor.appRed, forKey: "titleTextColor")
		
		// Ось тут питання як вірно обробити первірку на дозвіл до камери
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
	
	private lazy var addPhotoButton: UIButton = {
		let addButton = UIButton()
		let buttonImage = UIImage(named: "Photo")
		addButton.setImage(buttonImage, for: .normal)
		addButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
		addButton.layer.cornerRadius = 8
		addButton.backgroundColor = .appBlue
		addButton.addTarget(self, action: #selector(didTapAddPhoto), for: .touchUpInside)
		return addButton
	}()
	
	private func createTextField(placeholder: String) -> UITextField {
		let textField = UITextField()
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.backgroundColor = .appLight
		textField.textColor = .appBlack
		textField.layer.cornerRadius = 8
		textField.placeholder = placeholder
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
		textField.leftView = paddingView
		textField.leftViewMode = .always
		textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
		textField.delegate = self
		textField.returnKeyType = .next
		return textField
	}
	
	private lazy var brandTextField = createTextField(placeholder: "Brand")
	private lazy var modelTextField = createTextField(placeholder: "Model")
	private lazy var accelerationTextField = createTextField(placeholder: "0-100 km/h")
	private lazy var weightTextField = createTextField(placeholder: "Weight")
	
	private lazy var descriptionTextField: UITextView = {
		let description = UITextView()
		description.translatesAutoresizingMaskIntoConstraints = false
		description.backgroundColor = .appLight
		description.text = "Description"
		description.textColor = .placeholderText
		description.layer.cornerRadius = 8
		description.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		description.font = .systemFont(ofSize: 18)
		description.delegate = self
		description.returnKeyType = .done
		return description
	}()
	
	private lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.alignment = .fill
		stack.distribution = .fill
		stack.spacing = 10
		return stack
	}()
	
	private func setupStack() {
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(addPhotoButton)
		stackView.addArrangedSubview(brandTextField)
		stackView.addArrangedSubview(modelTextField)
		stackView.addArrangedSubview(accelerationTextField)
		stackView.addArrangedSubview(weightTextField)
		stackView.addArrangedSubview(descriptionTextField)
		
		view.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 20),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
			stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	//MARK: - Func addNewCard
	private func addNewCard() -> [ViewNewCellViewModel] {
		let description = (descriptionTextField.textColor == .lightGray) ? "" : (descriptionTextField.text ?? "")
		
		let newCardModel = ViewNewCellViewModel(
			id: UUID().uuidString,
			brand: brandTextField.text ?? "",
			model: modelTextField.text ?? "",
			acceleration: accelerationTextField.text ?? "",
			weight: weightTextField.text ?? "",
			description: description,
			image: imageView.image ?? UIImage(named: "Neon orange glasses on silhouette profile")!
		)
		
		return [newCardModel]
	}
	
	@objc private func didAddTapNewCard() {
		let newCards = addNewCard()
		
		if let newCard = newCards.first {
			delegate?.didAddNewCar(car: newCard)
		}
		closeScreen()
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

extension AddCarViewController: UINavigationControllerDelegate {
	
}
