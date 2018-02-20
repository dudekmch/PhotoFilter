import Foundation
import UIKit


protocol AddFilterViewProvider {
    func configureView()
    func buildCollectionView() -> UICollectionView
    func buildFiltersContainerView() -> UIView
    func buildFiltersHandler()
    func setupAutolayout()
}

class AddFilterInterfaceBuilder: AddFilterViewProvider {

    init(of controller: AddFilterViewHandler & FiltersHandler) {
        self.controller = controller as! (UIViewController & AddFilterViewHandler & FiltersHandler)
    }

    private let controller: UIViewController & AddFilterViewHandler & FiltersHandler

    private var view: UIView {
        return controller.view
    }

    func buildCollectionView() -> UICollectionView {

        let cg = CGRect(x: 0, y: 0, width:  UIScreen.main.bounds.width, height: 300)
        let layaut = UICollectionViewLayout()
        let collectionView = UICollectionView.init(frame: cg, collectionViewLayout: layaut)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
          collectionView.addShadow()
        view.addSubview(collectionView)
//       collectionView.didMoveToSuperview()
      
        return collectionView
    }

    func buildFiltersContainerView() -> UIView {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        containerView.backgroundColor = .blue
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        return containerView
    }

    func buildFiltersHandler() {

        let filtersVC = FiltersCollectionViewController()
        filtersVC.delgate = controller

        controller.addChildViewController(filtersVC)
        filtersVC.didMove(toParentViewController: controller)

        if let filtersView = filtersVC.collectionView, let containter = controller.filtersContainerView {
            filtersView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 190)
            filtersView.translatesAutoresizingMaskIntoConstraints = false
            filtersView.backgroundColor = .green
            containter.addSubview(filtersView)
        }
    }

    func configureView() {
        self.view.backgroundColor = .orange
    }

    func setupAutolayout() {

        if let photosCollectionView = controller.photosCollectionView, let filtersContainerView = controller.filtersContainerView, let filtersCollectionView = controller.filtersCollectionView {

            let views: [String: UIView] = [
                "view": controller.view,
                "photoCollectionView": photosCollectionView,
                "filtersContainerView": filtersContainerView,
                "filterCollectionView": filtersCollectionView
            ]
            var constraints: [NSLayoutConstraint] = []

            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-5-[photoCollectionView]-5-|", options: [], metrics: nil, views: views))
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[photoCollectionView]", options: [], metrics: nil, views: views))
            
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-5-[filtersContainerView]-5-|", options: [], metrics: nil, views: views))
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[photoCollectionView]-5-[filtersContainerView(100)]-5-|", options: [], metrics: nil, views: views))
            
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "|-0-[filterCollectionView]-0-|", options: [], metrics: nil, views: views))
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[filterCollectionView]-5-|", options: [], metrics: nil, views: views))
            
            NSLayoutConstraint.activate(constraints)
        }
    }

}
