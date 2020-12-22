

//
//  ProfileViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/25/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class Container: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class MusicViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class PodcastViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class YourLibraryViewController: BaseViewController {
    
    var musicBarButtonItem: UIBarButtonItem!
    var podCastBarButtonItem: UIBarButtonItem!
    
    let container = Container()
    
    let viewControllers: [UIViewController] = [YourHomeViewController(), YourHomeViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
    }

    // MARK: - Helper Method
    
    func setupNavBar() {
        navigationItem.leftBarButtonItems = [musicBarButtonItem, podCastBarButtonItem]
        let image = UIImage()
        self.navigationController?.navigationBar.shadowImage = image
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupViews() {
        guard let containerView = container.view else { return }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide).offset(Dimension.shared.smallMargin)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(Dimension.shared.smallMargin)
            }
            make.left.bottom.right.equalToSuperview()
        }
        musicTapped()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        musicBarButtonItem = makeBarButtonItem(text: "Music", selector: #selector(musicTapped))
        podCastBarButtonItem = makeBarButtonItem(text: "Podcasts", selector: #selector(podcastTapped))

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func makeBarButtonItem(text: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: selector, for: .primaryActionTriggered)
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle).withTraits(traits: [.traitBold]),
            NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedText = NSMutableAttributedString(string: text, attributes: attributes)
        
        button.setAttributedTitle(attributedText, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 16)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        return barButtonItem
    }

    
    @objc func musicTapped() {
        if container.children.first == viewControllers[0] { return }
        
        container.add(viewControllers[0])
                
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) {success in
            self.viewControllers[1].remove()
        }
        
        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 1.0
            self.podCastBarButtonItem.customView?.alpha = 0.5
        }
    }
    
    @objc func podcastTapped() {
        if container.children.first == viewControllers[1] { return }
        
        container.add(viewControllers[1])
        
        animateTransition(fromVC: viewControllers[0], toVC: viewControllers[1]) {success in
            self.viewControllers[0].remove()
        }

        UIView.animate(withDuration: 0.5) {
            self.musicBarButtonItem.customView?.alpha = 0.5
            self.podCastBarButtonItem.customView?.alpha = 1.0
        }
    }
    
    func animateTransition(fromVC: UIViewController, toVC: UIViewController, completion: @escaping ((Bool) -> Void)) {
        guard
            let fromView = fromVC.view,
            let fromIndex = getIndex(forViewController: fromVC),
            let toView = toVC.view,
            let toIndex = getIndex(forViewController: toVC)
            else {
                return
        }

        let frame = fromVC.view.frame
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        UIView.animate(withDuration: 0.5, animations: {
            fromView.frame = fromFrameEnd
            toView.frame = frame
        }, completion: {success in
            completion(success)
        })
    }
    
    func getIndex(forViewController vc: UIViewController) -> Int? {
        for (index, thisVC) in viewControllers.enumerated() {
            if thisVC == vc { return index }
        }
        return nil
    }
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
