//
//  AlbumViewController.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 12/22/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

class AlbumViewController: BaseViewController {
    
    // MARK - Variables
    
    var song: [SongTrack] = []
    
    // MARK: - UI ELemenets
    
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
    
    fileprivate lazy var albumCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Dimension.shared.normalMargin
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(SongCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(HeaderViewCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViewPlaySong()
        setupViewDetailPlaySong()
        layoutAlbumCollectionView()
        requestAPIGetPlistSong()
    }
    
    //MARK: Initialize function
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewPlaySong.isHidden = true
        self.detailViewPlaySong.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewPlaySong.isHidden = false
        self.detailViewPlaySong.isHidden = false
    }
    
    // MARK: - API
    
    fileprivate func requestAPIGetPlistSong() {
        let endPoint = SongEndPoint.getPlistSong
        
        APIService.request(endPoint: endPoint, onSuccess: { [weak self](apiResponse) in
            self?.song = apiResponse.toArray([SongTrack.self])
            self?.reloadDataWhenFinishLoadAPI()
        }, onFailure: { (apiError) in
            print("error")
        }) {
            print("error")
        }
    }
    
    private func reloadDataWhenFinishLoadAPI() {
        self.albumCollectionView.reloadData()
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
    
    fileprivate func animationScrollUpPlaySongView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.viewPlaySong.frame.origin = CGPoint(x: 0,
                                                     y: UIScreen.main.bounds.height - Dimension.shared.heightViewPlayMusic - self.tabBarController!.tabBar.frame.height)
            
        }) { (finish) in
            self.albumCollectionView.contentInset = UIEdgeInsets(top: 0,
                                                              left: 0,
                                                              bottom:  Dimension.shared.heightViewPlayMusic, right: 0)
        }
    }
    
    fileprivate func animationScrollDownPlaySongView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.viewPlaySong.layer.transform = CATransform3DIdentity
        }) { (finish) in
            //Do some thing when finish animation
        }
    }
    
    // MARK: - Helper Method
    
    // MARK: - Layout
    
    private func layoutAlbumCollectionView() {
        view.addSubview(albumCollectionView)
        albumCollectionView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func layoutViewPlaySong() {
        self.navigationController?.view.addSubview(self.viewPlaySong)
        self.viewPlaySong.frame = CGRect(x: 0,
                                         y: UIScreen.main.bounds.height - tabBarController!.tabBar.frame.height,
                                         width: UIScreen.main.bounds.width,
                                         height: Dimension.shared.heightViewPlayMusic)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPlaySongPanGesture(_:)))
        self.viewPlaySong.addGestureRecognizer(panGesture)
    }
    
    private func setupViewDetailPlaySong() {
        self.navigationController?.view.addSubview(self.detailViewPlaySong)
        
        self.detailViewPlaySong.frame = CGRect(x: 0,
                                               y: UIScreen.main.bounds.height - Dimension.shared.heightTabar,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(detailViewPlaySongPanGesture(_:)))
        self.detailViewPlaySong.addGestureRecognizer(panGesture)
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let songTrack = song[indexPath.row]
        self.viewPlaySong.setData(song: songTrack)
        MusicPlayer.shared.play(newSong: songTrack) {
            self.detailViewPlaySong.setData()
            self.detailViewPlaySong.setViewPlaySong(viewPlay: viewPlaySong)
        } onError: {
        
        }
        self.animationScrollUpPlaySongView()
    }
}

// MARK: - UICollectionViewDelegate

extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return song.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SongCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.song = song[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HeaderViewCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        return header
    }
    
}

extension AlbumViewController {
    
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
    
    fileprivate func swipeDetailViewPlaySong(translation: CGFloat, toState: StatePlaySong) {
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

