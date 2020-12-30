//
//  StationsViewController.swift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/19/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class StationsViewController: BaseViewController {
    
    // MARK: - IB UI
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.backgroundView = nil
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerReusableCell(StationTableViewCell.self)
        return tableView
    }()
    
    fileprivate lazy var bottomView: BaseView = {
        let view = BaseView()
        view.backgroundColor = UIColor.spotifyBrown
        return view
    }()
    
    fileprivate let stationNowPlayingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose a station above to begin", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize.h1.rawValue)
        return button
    }()
    
    fileprivate lazy var nowPlayingAnimationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NowPlayingBars")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Properties
    
    let radioPlayer = RadioPlayer()
    
    weak var nowPlayingViewController: NowPlayingViewController?
    
    // MARK: - Lists
    
    var stations = [RadioStation]() {
        didSet {
            guard stations != oldValue else { return }
            stationsDidUpdate()
        }
    }
    
    var searchedStations = [RadioStation]()
    
    var previousStation: RadioStation?
    
    // MARK: - UI
    
    var searchController: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radioPlayer.delegate = self
        loadStationsFromJSON()
        setupPullToRefresh()
        createNowPlayingAnimation()
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            if kDebugLog { print("audioSession could not be activated") }
        }
        
        setupSearchController()
        setupRemoteCommandCenter()
        setupHandoffUserActivity()
        layoutBottomView()
        layoutNowPlayingAnimationImageView()
        layoutStationNowPlayingButton()
        layoutTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        title = "Music"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    // MARK: - Setup UI Elements
    
    private func layoutBottomView() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(52)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layoutNowPlayingAnimationImageView() {
        bottomView.addSubview(nowPlayingAnimationImageView)
        nowPlayingAnimationImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Dimension.shared.smallMargin)
            make.width.height.equalTo(32)
        }
    }
    
    private func layoutStationNowPlayingButton() {
        bottomView.addSubview(stationNowPlayingButton)
        stationNowPlayingButton.snp.makeConstraints { (make) in
            make.left.equalTo(nowPlayingAnimationImageView.snp.right).offset(Dimension.shared.mediumMargin)
            make.right.equalToSuperview().offset(-Dimension.shared.mediumMargin)
            make.centerY.equalTo(nowPlayingAnimationImageView)
        }
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
            }
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
    }
    
    
    
    func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [.foregroundColor: UIColor.white])
        refreshControl.backgroundColor = .black
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func createNowPlayingAnimation() {
        nowPlayingAnimationImageView.animationImages = AnimationFrames.createFrames()
        nowPlayingAnimationImageView.animationDuration = 0.7
    }
    
    func createNowPlayingBarButton() {
        guard navigationItem.rightBarButtonItem == nil else { return }
        let btn = UIBarButtonItem(title: "", style: .plain, target: self, action:#selector(nowPlayingBarButtonPressed))
        btn.image = UIImage(named: "btn-nowPlaying")
        navigationItem.rightBarButtonItem = btn
    }
    
    // MARK: - Actions
    
    @objc func nowPlayingBarButtonPressed() {
        performSegue(withIdentifier: "NowPlaying", sender: self)
    }
    
    @objc func refresh(sender: AnyObject) {
        loadStationsFromJSON()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl.endRefreshing()
            self.view.setNeedsDisplay()
        }
    }
    
    // MARK: - Load Station Data
    
    func loadStationsFromJSON() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DataManager.getStationDataWithSuccess() { (data) in
            
            defer {
                DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
            }
            
            if kDebugLog { print("Stations JSON Found") }
            
            guard let data = data, let jsonDictionary = try? JSONDecoder().decode([String: [RadioStation]].self, from: data), let stationsArray = jsonDictionary["station"] else {
                if kDebugLog { print("JSON Station Loading Error") }
                return
            }
            
            self.stations = stationsArray
        }
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "NowPlaying", let nowPlayingVC = segue.destination as? NowPlayingViewController else { return }
        
        title = ""
        
        let newStation: Bool
        
        if let indexPath = (sender as? IndexPath) {
            radioPlayer.station = searchController.isActive ? searchedStations[indexPath.row] : stations[indexPath.row]
            newStation = radioPlayer.station != previousStation
            previousStation = radioPlayer.station
        } else {
            newStation = false
        }
        
        nowPlayingViewController = nowPlayingVC
        nowPlayingVC.load(station: radioPlayer.station, track: radioPlayer.track, isNewStation: newStation)
        nowPlayingVC.delegate = self
    }
    
    // MARK: - Private helpers
    
    private func stationsDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            guard let currentStation = self.radioPlayer.station else { return }
            
            // Reset everything if the new stations list doesn't have the current station
            if self.stations.firstIndex(of: currentStation) == nil { self.resetCurrentStation() }
        }
    }
    
    private func resetCurrentStation() {
        radioPlayer.resetRadioPlayer()
        nowPlayingAnimationImageView.stopAnimating()
        stationNowPlayingButton.setTitle("Choose a station above to begin", for: .normal)
        stationNowPlayingButton.isEnabled = false
        navigationItem.rightBarButtonItem = nil
    }
    
    private func updateNowPlayingButton(station: RadioStation?, track: Track?) {
        guard let station = station else { resetCurrentStation(); return }
        
        var playingTitle = station.name + ": "
        
        if track?.title == station.name {
            playingTitle += "Now playing ..."
        } else if let track = track {
            playingTitle += track.title + " - " + track.artist
        }
        
        stationNowPlayingButton.setTitle(playingTitle, for: .normal)
        stationNowPlayingButton.isEnabled = true
        createNowPlayingBarButton()
    }
    
    func startNowPlayingAnimation(_ animate: Bool) {
        animate ? nowPlayingAnimationImageView.startAnimating() : nowPlayingAnimationImageView.stopAnimating()
    }
    
    private func getIndex(of station: RadioStation?) -> Int? {
        guard let station = station, let index = stations.firstIndex(of: station) else { return nil }
        return index
    }
    
    // MARK: - Remote Command Center Controls
    
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { event in
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { event in
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { event in
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { event in
            return .success
        }
    }
    
    func updateLockScreen(with track: Track?) {
        
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        
        if let image = track?.artworkImage {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size, requestHandler: { size -> UIImage in
                return image
            })
        }
        
        if let artist = track?.artist {
            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        }
        
        if let title = track?.title {
            nowPlayingInfo[MPMediaItemPropertyTitle] = title
        }
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}

// MARK: - TableViewDataSource

extension StationsViewController: UITableViewDataSource {
    
    @objc(tableView:heightForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            return searchedStations.count
        } else {
            return stations.isEmpty ? 1 : stations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if stations.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NothingFound", for: indexPath) 
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        } else {
            let cell: StationTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.clear : UIColor.black.withAlphaComponent(0.2)
            
            let station = searchController.isActive ? searchedStations[indexPath.row] : stations[indexPath.row]
            cell.configureStationCell(station: station)
            return cell
        }
    }
}

// MARK: - TableViewDelegate

extension StationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = NowPlayingViewController()
        navigationController?.pushViewController(vc, animated: true)
//        performSegue(withIdentifier: "NowPlaying", sender: indexPath)
    }
}

// MARK: - UISearchControllerDelegate / Setup

extension StationsViewController: UISearchResultsUpdating {
    
    func setupSearchController() {
        guard searchable else { return }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableHeaderView?.backgroundColor = UIColor.clear
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.barTintColor = UIColor.clear
        searchController.searchBar.tintColor = UIColor.white
        
        tableView.setContentOffset(CGPoint(x: 0.0, y: searchController.searchBar.frame.size.height), animated: false)
        if  #available(iOS 13.0, *) {
            searchController.searchBar.barStyle = .black
            searchController.searchBar.searchTextField.keyboardAppearance = .dark
        } else {
            let searchTextField = searchController.searchBar.value(forKey: "_searchField") as? UITextField
            searchTextField?.keyboardAppearance = .dark
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        searchedStations.removeAll(keepingCapacity: false)
        searchedStations = stations.filter { $0.name.range(of: searchText, options: [.caseInsensitive]) != nil }
        self.tableView.reloadData()
    }
}

// MARK: - RadioPlayerDelegate

extension StationsViewController: RadioPlayerDelegate {
    
    func playerStateDidChange(_ playerState: FRadioPlayerState) {
        nowPlayingViewController?.playerStateDidChange(playerState, animate: true)
    }
    
    func playbackStateDidChange(_ playbackState: FRadioPlaybackState) {
        nowPlayingViewController?.playbackStateDidChange(playbackState, animate: true)
        startNowPlayingAnimation(radioPlayer.player.isPlaying)
    }
    
    func trackDidUpdate(_ track: Track?) {
        updateLockScreen(with: track)
        updateNowPlayingButton(station: radioPlayer.station, track: track)
        updateHandoffUserActivity(userActivity, station: radioPlayer.station, track: track)
        nowPlayingViewController?.updateTrackMetadata(with: track)
    }
    
    func trackArtworkDidUpdate(_ track: Track?) {
        updateLockScreen(with: track)
        nowPlayingViewController?.updateTrackArtwork(with: track)
    }
}

// MARK: - Handoff Functionality - GH

extension StationsViewController {
    
    func setupHandoffUserActivity() {
        userActivity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        userActivity?.becomeCurrent()
    }
    
    func updateHandoffUserActivity(_ activity: NSUserActivity?, station: RadioStation?, track: Track?) {
        guard let activity = activity else { return }
        activity.webpageURL = (track?.title == station?.name) ? nil : getHandoffURL(from: track)
        updateUserActivityState(activity)
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)
    }
    
    private func getHandoffURL(from track: Track?) -> URL? {
        guard let track = track else { return nil }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "google.com"
        components.path = "/search"
        components.queryItems = [URLQueryItem]()
        components.queryItems?.append(URLQueryItem(name: "q", value: "\(track.artist) \(track.title)"))
        return components.url
    }
}

// MARK: - NowPlayingViewControllerDelegate

extension StationsViewController: NowPlayingViewControllerDelegate {
    
    func didPressPlayingButton() {
        radioPlayer.player.togglePlaying()
    }
    
    func didPressStopButton() {
        radioPlayer.player.stop()
    }
    
    func didPressNextButton() {
        guard let index = getIndex(of: radioPlayer.station) else { return }
        radioPlayer.station = (index + 1 == stations.count) ? stations[0] : stations[index + 1]
        handleRemoteStationChange()
    }
    
    func didPressPreviousButton() {
        guard let index = getIndex(of: radioPlayer.station) else { return }
        radioPlayer.station = (index == 0) ? stations.last : stations[index - 1]
        handleRemoteStationChange()
    }
    
    func handleRemoteStationChange() {
        if let nowPlayingVC = nowPlayingViewController {
            nowPlayingVC.load(station: radioPlayer.station, track: radioPlayer.track)
            nowPlayingVC.stationDidChange()
        } else if let station = radioPlayer.station {
            radioPlayer.player.radioURL = URL(string: station.streamURL)
        }
    }
}
