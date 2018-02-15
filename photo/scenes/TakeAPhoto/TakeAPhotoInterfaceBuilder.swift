
import UIKit

protocol TakeAPhotoViewProvider: class {
    func configureView()
    func buildTakeAPhotoButton()->UIButton
    func buildChangeCameraButton()->UIButton
    func buildPreviewView()->UIView
    
    func setupAutolayout()
}

class TakeAPhotoInterfaceBuilder: TakeAPhotoViewProvider {
    
    init(of controller: TakeAPhotoViewHandler) {
        self.controller = controller as! (UIViewController & TakeAPhotoViewHandler)
    }
    
    private unowned let controller: UIViewController & TakeAPhotoViewHandler
    private var view: UIView {
        return controller.view
    }
    
    func configureView() {
        self.view.backgroundColor = .white
    }
    
    func buildTakeAPhotoButton()->UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        view.addSubview(button)
        button.didMoveToSuperview()
        button.roundCorners()
        return button
    }
    
    func buildChangeCameraButton()->UIButton {
        let button = UIButton()
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.didMoveToSuperview()
        
        return button
    }
    
    func buildPreviewView()->UIView {
        let preview = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.backgroundColor = .red
        view.addSubview(preview)
        preview.didMoveToSuperview()
        preview.addShadow()
        return preview
    }
    
    func setupAutolayout() {
        let views: [String: UIView] = [
            "view": controller.view,
            "takeAPhotoButton": controller.takeAPhotoButton!,
            "changeCameraButton": controller.changeCameraButton!,
            "preview": controller.previewView!,
            "backButton": controller.backButton!,
            "aButton": controller.aButton!,
            "cButton": controller.cButton!
        ]
        var constraints: [NSLayoutConstraint] = []
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-10-[changeCameraButton(20)]", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-10-[changeCameraButton(==backButton)]-[backButton]-10-|", options: .alignAllCenterY, metrics: nil, views: views))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "[backButton(20)]-10-|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[changeCameraButton]", options: [], metrics: nil, views: views))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-10-[changeCameraButton(20)]-5-[backButton(20)]-10-|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[backButton]", options: [], metrics: nil, views: views))
        //Auto Layout defaults to horizontal orientation
//        constraints.append(NSLayoutConstraint(item: controller.previewView!, attribute: .height, relatedBy: .equal, toItem: controller.view, attribute: .height, multiplier: 0.7, constant: 0))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-10-[preview]-10-|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[changeCameraButton]-[preview]", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[backButton]-[preview]", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[preview]-[takeAPhotoButton]", options: [], metrics: nil, views: views))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[changeCameraButton]-3-[preview]-3-[takeAPhotoButton(==40)]-10-|", options: .alignAllCenterX, metrics: nil, views: views))
//        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[backButton]-3-[preview]-3-[takeAPhotoButton(==40)]-10-|", options: .alignAllCenterX, metrics: nil, views: views))
         constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[takeAPhotoButton]-10-|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-20-[aButton(==takeAPhotoButton)]-[takeAPhotoButton]-[cButton(==aButton)]-20-|", options: .alignAllCenterY, metrics: nil, views: views))
        
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
}
