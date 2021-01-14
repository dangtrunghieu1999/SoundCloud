//
//  BaseViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit
import JGProgressHUD

enum BarButtonItemType {
    case left
    case right
}

typealias Target = (target: Any?, selector: Selector)

struct BarButtonItemModel {
    var image: UIImage?
    var title: String?
    var target: Target
    
    init(_ image: UIImage?, _ target: Target) {
        self.image = image
        self.target = target
    }
    
    init(_ image: UIImage? = nil, _ title: String? = nil, _ target: Target) {
        self.image = image
        self.title = title
        self.target = target
    }
}

class BaseViewController: UIViewController {
    
    fileprivate var direction = Direction.none
    fileprivate var finalState = StatePlaySong.none
    fileprivate var currentTranslation: CGFloat?
    
    lazy var viewPlaySong: ViewPlaySong = {
        let viewConfig = ViewPlaySong()
        viewConfig.layer.masksToBounds = false
        viewConfig.layer.shadowColor = UIColor.black.cgColor
        viewConfig.layer.shadowOpacity = 0.3
        viewConfig.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewConfig.layer.shadowRadius = 3
        viewConfig.isUserInteractionEnabled = true
        return viewConfig
    }()
    
    lazy var detailViewPlaySong: DetailViewPlaySong = {
        let viewConfig = DetailViewPlaySong()
        viewConfig.isUserInteractionEnabled = true
        return viewConfig
    }()

    
    private (set) lazy var tapGestureOnSuperView = UITapGestureRecognizer(target: self,
                                                                          action: #selector(touchInBaseView))
    
    private lazy var hub: JGProgressHUD = {
        let hub = JGProgressHUD(style: .dark)
        return hub
    }()
    
    lazy var searchBar: PaddingTextField = {
        let searchBar = PaddingTextField()
        searchBar.setDefaultBackgroundColor()
        searchBar.layer.cornerRadius = 5
        searchBar.layer.masksToBounds = true
        searchBar.attributedPlaceholder = NSAttributedString(string:TextManager.search,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.font = UIFont.systemFont(ofSize: FontSize.h2.rawValue)
        searchBar.textColor = .white
        searchBar.returnKeyType = .search
        searchBar.leftImage = ImageManager.search
        var rect = navigationController?.navigationBar.frame ?? CGRect.zero
        rect.size.height = 30
        searchBar.frame = rect
        searchBar.clearButtonMode = .whileEditing
        searchBar.delegate = self
        searchBar.addTarget(self, action: #selector(touchInSearchBar), for: .editingDidBegin)
        searchBar.addTarget(self, action: #selector(searchBarValueChange(_:)), for: .editingChanged)
        return searchBar
    }()

    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUIComponents()
        view.backgroundColor = UIColor.mainBackground
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        addTapOnSuperViewDismissKeyboard()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - UI Actions
    
    @objc func touchUpInBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpInLeftBarButtonItem() {}
    
    @objc func touchUpInRightBarButtonItem() {}
    
    @objc func keyboardWillShow(_ notification: NSNotification) {}
    
    @objc func keyboardWillHide(_ notification: NSNotification) {}
    
    @objc func searchBarValueChange(_ textField: UITextField) {}
    
    @objc func touchInSearchBar() {}
    
    @objc func touchInBaseView() {
        view.endEditing(true)
    }

    // MARK: - Public Method
    
    func showLoading() {
        view.endEditing(true)
        hub.show(in: view)
    }
    
    func hideLoading() {
        hub.dismiss()
    }
    
    func addTapOnSuperViewDismissKeyboard() {
        tapGestureOnSuperView.cancelsTouchesInView = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureOnSuperView)
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    
    // MARK: - Setup UI
    
    func setupUIComponents() {
//        self.setupTabbar()
        self.addBackButtonIfNeeded()
    }
    
    private func setupTabbar() {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            tabBarController?.tabBar.isHidden = true
        } else {
            tabBarController?.tabBar.isHidden = false
        }
    }
    
    func addBackButtonIfNeeded() {
        let numberOfVC = navigationController?.viewControllers.count ?? 0
        guard numberOfVC > 1 else { return }
        let target: Target = (target: self, #selector(touchUpInBackButton))
        let barbuttonItemModel = BarButtonItemModel(ImageManager.back, target)
        navigationItem.leftBarButtonItem = buildBarButton(from: barbuttonItemModel)
    }
    
    func buildBarButton(from itemModel: BarButtonItemModel) -> UIBarButtonItem {
        let target = itemModel.target
        let customButton = UIButton(type: .custom)
        customButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        if itemModel.image != nil {
            let image = itemModel.image?.withRenderingMode(.alwaysTemplate)
            customButton.setImage(image, for: .normal)
            customButton.tintColor = UIColor.white
        } else if itemModel.title != nil {
            customButton.setTitle(itemModel.title!, for: .normal)
            customButton.setTitleColor(UIColor.white, for: .normal)
        }
        
        customButton.addTarget(target.target, action: target.selector, for: .touchUpInside)
        return UIBarButtonItem(customView: customButton)
    }
    
    func addBarItems(with itemModels: [BarButtonItemModel], type: BarButtonItemType = .right) {
        var barButtonItems: [UIBarButtonItem] = []
        itemModels.forEach {
            barButtonItems.append(buildBarButton(from: $0))
        }
        if type == .right {
            navigationItem.rightBarButtonItems = barButtonItems
        } else {
            navigationItem.leftBarButtonItems = barButtonItems
        }
    }
    
    func setDefaultNavigationBar(leftBarImage: UIImage? = nil, rightBarItem: UIImage? = nil) {
        if leftBarImage != nil {
            let leftBarItemTarget: Target = (target: self, selector: #selector(touchUpInLeftBarButtonItem))
            let leftBarButtonModel = BarButtonItemModel(leftBarImage, leftBarItemTarget)
            addBarItems(with: [leftBarButtonModel], type: .left)
        }
        
        if rightBarItem != nil {
            let rightBarItemTarget: Target = (target: self, selector: #selector(touchUpInRightBarButtonItem))
            let rightBarButtonModel = BarButtonItemModel(rightBarItem, rightBarItemTarget)
            addBarItems(with: [rightBarButtonModel], type: .right)
        }
    }
    
    func setRightNavigationBar(_ image: UIImage? = nil) {
        if image != nil {
            let rightBarItemTarget: Target = (target: self, selector: #selector(touchUpInRightBarButtonItem))
            let rightBarButtonModel = BarButtonItemModel(image, rightBarItemTarget)
            addBarItems(with: [rightBarButtonModel], type: .right)
        }
    }
    
    @objc func viewPlaySongPanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            self.currentTranslation = nil
            let velocity = sender.velocity(in: nil)
            
            if abs(velocity.x) < abs(velocity.y) {
                self.direction = .up
            } else if velocity.x > 0 {
                self.direction = .right
            } else if velocity.x < 0 {
                self.direction = .left
            }
        }
        
        let previousTranslation = self.currentTranslation ?? 0
        
        if self.direction == .up || self.direction == .down {
            self.currentTranslation = sender.translation(in: nil).y
            
            if previousTranslation < self.currentTranslation ?? 0 {
                self.direction = .down
            } else if previousTranslation > self.currentTranslation ?? 0 {
                self.direction = .up
            }
        }
        
        if self.direction == .left || self.direction == .right {
            self.currentTranslation = sender.translation(in: nil).x
            
            if previousTranslation < self.currentTranslation ?? 0 {
                self.direction = .right
            } else if previousTranslation > self.currentTranslation ?? 0 {
                self.direction = .left
            }
        }
        
        switch self.direction {
        case .up:
            self.finalState = .full
            break
        case .down:
            self.finalState = .minimum
            break
        case .left:
            self.finalState = .dissmissLeft
            break
        case .right:
            self.finalState = .dissmissRight
            break
        default:
            break
        }
        
        self.swipeViewPlaySong(translation: self.currentTranslation ?? 0, toState: self.finalState)
        
        if sender.state == .ended {
            self.didEndSwipe(toState: self.finalState, translation: sender.translation(in: nil).x)
        }
    }
    
    @objc func detailViewPlaySongPanGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let velocity = sender.velocity(in: nil)
            
            if velocity.y > 0 {
                self.direction = .down
            } else if velocity.y < 0 {
                self.direction = .up
            }
        }
        
        let previousTranslation = self.currentTranslation ?? 0
        
        if self.direction == .up || self.direction == .down {
            self.currentTranslation = sender.translation(in: nil).y
            
            if previousTranslation < self.currentTranslation ?? 0 {
                self.direction = .down
            } else if previousTranslation > self.currentTranslation ?? 0 {
                self.direction = .up
            }
        }
        
        switch self.direction {
        case .up:
            self.finalState = .full
            break
        case .down:
            self.finalState = .minimum
            break
        default:
            break
        }
        
        self.swipeDetailViewPlaySong(translation: sender.translation(in: nil).y, toState: self.finalState)
        
        if sender.state == .ended {
            self.didEndSwipe(toState: self.finalState, translation: sender.translation(in: nil).x)
        }
    }


}

// MARK: - UITextFieldDelegate

extension BaseViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.endEditing(true)
        return true
    }
}

extension BaseViewController {
    
    func changeTabBar(factor: CGFloat){
        let yTabar = UIScreen.main.bounds.height - Dimension.shared.heightTabar
        let ty = factor * Dimension.shared.heightTabar
        self.tabBarController?.tabBar.frame.origin.y = yTabar + ty
    }
    
    func swipeViewPlaySong(translation: CGFloat, toState: StatePlaySong) {
        if translation > 0 && toState != .dissmissRight {
            return
        }
        
        switch toState {
        case .full:
            self.viewPlaySong.frame.origin = self.positionDuringSwipe(translation: translation)
            self.detailViewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                           y: UIScreen.main.bounds.height - Dimension.shared.heightTabar + translation)
            let factor: CGFloat = translation / (UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height)
            self.changeTabBar(factor: abs(factor))
            
            
            break
        case .minimum:
            self.viewPlaySong.frame.origin = self.positionDuringSwipe(translation: translation)
            self.detailViewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                           y: UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height + translation)
            let factor: CGFloat = translation / (UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height)
            self.changeTabBar(factor: abs(factor))
            
            break
        case .dissmissLeft:
            self.viewPlaySong.frame.origin = CGPoint(x: 0 + translation,
                                                     y: UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height - Dimension.shared.heightViewPlayMusic)
            
            break
        case .dissmissRight:
            self.viewPlaySong.frame.origin = CGPoint(x: 0 + translation,
                                                     y: UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height - Dimension.shared.heightViewPlayMusic)
            
            break
        default:
            break
        }
    }
    
    func swipeDetailViewPlaySong(translation: CGFloat, toState: StatePlaySong) {
        if translation < 0 {
            return
        }
        
        //TODO: Change origin y tabar
        let factor: CGFloat = 1 - translation / (UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height)
        self.changeTabBar(factor: factor)
        
        switch toState {
        case .full:
            self.viewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                     y: -Dimension.shared.heightViewPlayMusic + translation)
            
            self.detailViewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                           y: 0 + translation)
            
            break
        case .minimum:
            self.viewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                     y: -Dimension.shared.heightViewPlayMusic + translation)
            
            self.detailViewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                           y: 0 + translation)
            break
        default:
            
            break
        }
    }
    
     func positionDuringSwipe(translation: CGFloat)->CGPoint {
        let heightViewPlaySong = self.viewPlaySong.frame.height
        let x: CGFloat = 0
        let y = (UIScreen.main.bounds.height - Dimension.shared.heightTabar - heightViewPlaySong) + translation
        
        return CGPoint(x: x, y: y)
    }
    
     func didEndSwipe(toState: StatePlaySong, translation: CGFloat) {
        
        switch toState {
        case .full:
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.viewPlaySong.frame.origin = CGPoint(x: 0, y: -Dimension.shared.heightViewPlayMusic)
                self.detailViewPlaySong.frame.origin = CGPoint(x: 0, y: 0)
                self.tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height + 5 * Dimension.shared.widthScale
                
            }, completion: { (finish) in
                //finish animation
            })
            
            break
        case .minimum:
            let yCoordinateViewPlaySong = UIScreen.main.bounds.height - Dimension.shared.heightTabar - self.viewPlaySong.frame.height
            
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                self.viewPlaySong.frame.origin = CGPoint(x: 0, y: yCoordinateViewPlaySong)
                self.detailViewPlaySong.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - Dimension.shared.heightTabar)
                self.tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height
            }, completion: { (finish) in
                //finish animation
            })
            
            break
        case .dissmissLeft:
            if abs(translation) > UIScreen.main.bounds.width / 2 {
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    self.viewPlaySong.frame.origin = CGPoint(x: -UIScreen.main.bounds.width, y:  UIScreen.main.bounds.height - Dimension.shared.heightTabar - self.viewPlaySong.frame.height)
                }, completion: { (finish) in
                    //finish animation
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - Dimension.shared.heightTabar)
                    MusicPlayer.shared.stop()
                    
                })
            } else {
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height - self.viewPlaySong.frame.height)
                }, completion: { (finish) in
                    //
                })
            }
            
            break
        case .dissmissRight:
            
            if abs(translation) > UIScreen.main.bounds.width / 2 {
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    self.viewPlaySong.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y:  UIScreen.main.bounds.height - Dimension.shared.heightTabar - self.viewPlaySong.frame.height)
                }, completion: { (finish) in
                    //finish animation
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height)
                    
                    //Add notificaton stop playSong when swipe view detail play song
                    MusicPlayer.shared.stop()
                })
            } else {
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - self.tabBarController!.tabBar.frame.height - self.viewPlaySong.frame.height)
                }, completion: { (finish) in
                    //finish animation
                })
            }
            
            break
        default:
            break
        }
    }
}
