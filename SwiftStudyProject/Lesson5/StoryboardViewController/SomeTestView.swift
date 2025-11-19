//
//  SomeTestView.swift
//  SwiftStudyProject
//
//  Created by Kirill on 18.11.2025.
//
import UIKit

class SomeTestView: UIView {
    @IBOutlet weak var testLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNib()
    }
    
    private func loadNib() {
        let bundle = Bundle(for: SomeTestView.self)
        let className = String(describing: SomeTestView.self)
        let nib = UINib(nibName: className, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Failed to load nib for view \\(className).")
        }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    func setup(text: String) {
        testLabel.text = text
        
    }
}
