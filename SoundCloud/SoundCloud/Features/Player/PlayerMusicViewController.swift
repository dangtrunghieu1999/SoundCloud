//
//  PlayerMusicViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/29/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class PlayerMusicViewController: BaseViewController {
    
    // MARK: - Variable for animation
    
    fileprivate var direction = Direction.none
    fileprivate var finalState = StatePlaySong.none
    fileprivate var currentTranslation: CGFloat?
    
    fileprivate lazy var viewPlaySong: ViewPlaySong = {
        let viewConfig = ViewPlaySong()
        viewConfig.layer.masksToBounds = false
        viewConfig.layer.shadowColor = UIColor.black.cgColor
        viewConfig.layer.shadowOpacity = 0.3
        viewConfig.layer.shadowOffset = CGSize(width: 0, height: -2)
        viewConfig.layer.shadowRadius = 3
        viewConfig.isUserInteractionEnabled = true
        return viewConfig
    }()
    
    fileprivate lazy var detailViewPlaySong: DetailViewPlaySong = {
        let viewConfig = DetailViewPlaySong()
        viewConfig.isUserInteractionEnabled = true
        return viewConfig
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViewPlaySong()
    }
    
    // MARK: - UI Action
    
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
    
    // MARK: - Layout
    
    private func layoutViewPlaySong() {
        self.navigationController?.view.addSubview(self.viewPlaySong)
        self.viewPlaySong.frame = CGRect(x: 0,
                                         y: UIScreen.main.bounds.height - 120,
                                         width: UIScreen.main.bounds.width,
                                         height: 64)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPlaySongPanGesture(_:)))
        self.viewPlaySong.addGestureRecognizer(panGesture)
    }

}

extension PlayerMusicViewController {
    
    func changeTabBar(factor: CGFloat){
        let yTabar = UIScreen.main.bounds.height - Dimension.shared.heightTabar
        let ty = factor * Dimension.shared.heightTabar
        self.tabBarController?.tabBar.frame.origin.y = yTabar + ty
    }
    
    fileprivate func swipeViewPlaySong(translation: CGFloat, toState: StatePlaySong) {
        if translation > 0 && toState != .dissmissRight {
            return
        }
        
        switch toState {
        case .full:
            self.viewPlaySong.frame.origin = self.positionDuringSwipe(translation: translation)
            self.detailViewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                           y: UIScreen.main.bounds.height - Dimension.shared.heightTabar + translation)
            let factor: CGFloat = translation / (UIScreen.main.bounds.height - Dimension.shared.heightTabar)
            self.changeTabBar(factor: abs(factor))
            
            
            break
        case .minimum:
            self.viewPlaySong.frame.origin = self.positionDuringSwipe(translation: translation)
            self.detailViewPlaySong.frame.origin = CGPoint(x: 0.0,
                                                           y: UIScreen.main.bounds.height - Dimension.shared.heightTabar + translation)
            let factor: CGFloat = translation / (UIScreen.main.bounds.height - Dimension.shared.heightTabar)
            self.changeTabBar(factor: abs(factor))
            
            break
        case .dissmissLeft:
            self.viewPlaySong.frame.origin = CGPoint(x: 0 + translation,
                                                     y: UIScreen.main.bounds.height - Dimension.shared.heightTabar - Dimension.shared.heightViewPlayMusic)
            
            break
        case .dissmissRight:
            self.viewPlaySong.frame.origin = CGPoint(x: 0 + translation,
                                                     y: UIScreen.main.bounds.height - Dimension.shared.heightTabar - Dimension.shared.heightViewPlayMusic)
            
            break
        default:
            break
        }
    }
    
    fileprivate func swipeDetailViewPlaySong(translation: CGFloat, toState: StatePlaySong) {
        if translation < 0 {
            return
        }
        
        //TODO: Change origin y tabar
        let factor: CGFloat = 1 - translation / (UIScreen.main.bounds.height - Dimension.shared.heightTabar)
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
    
    fileprivate func positionDuringSwipe(translation: CGFloat)->CGPoint {
        let heightViewPlaySong = self.viewPlaySong.frame.height
        let x: CGFloat = 0
        let y = (UIScreen.main.bounds.height - Dimension.shared.heightTabar - heightViewPlaySong) + translation
        
        return CGPoint(x: x, y: y)
    }
    
    fileprivate func didEndSwipe(toState: StatePlaySong, translation: CGFloat) {
        
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
                self.tabBarController?.tabBar.frame.origin.y = UIScreen.main.bounds.height - Dimension.shared.heightTabar
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
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - Dimension.shared.heightTabar - self.viewPlaySong.frame.height)
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
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - Dimension.shared.heightTabar)
                    
                    //Add notificaton stop playSong when swipe view detail play song
                    MusicPlayer.shared.stop()
                })
            } else {
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5, options: UIView.AnimationOptions.beginFromCurrentState, animations: {
                    self.viewPlaySong.frame.origin = CGPoint(x: 0, y:  UIScreen.main.bounds.height - Dimension.shared.heightTabar - self.viewPlaySong.frame.height)
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
