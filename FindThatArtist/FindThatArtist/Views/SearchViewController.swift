//
//  SearchViewController.swift
//  FindThatArtist
//
//  Created by Field Employee on 2/20/21.
//

import UIKit

protocol GetTextFieldValueDelegate:class{
    func searchArtistTextFieldValue(_ name: String)
    
}

class SearchViewController: UIViewController {

    
    
    weak var delegate: GetTextFieldValueDelegate?
//    let network = GetArtistDataController()
    @IBOutlet weak var searchArtist: UITextField?
    
    @IBOutlet weak var artistTable: UITableView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var activitySpin: UIActivityIndicatorView!
    
    @IBOutlet weak var newSearchButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistTable.dataSource = self
        artistTable.isHidden = true
        activitySpin.isHidden = true
        newSearchButton.isHidden = true


    }
    
    
    
    @IBAction func newSearch(_ sender: Any) {
        newSearchButton.isHidden = true
        searchButton.isHidden = false
        searchArtist?.isHidden = false
       // network.artistDetails.removeAll()
        
    }
    @IBAction func SearchArtist(_ sender: Any) {
     
        let network = GetArtistDataController()
        searchArtist?.isHidden = true
        searchButton.isHidden = true
        activitySpin.isHidden = false
        network.viewDidLoad()
        
       self.dismiss(animated: true, completion: nil)
        network.getArtistData()
        showData()
        }
    func passDelegate(){
        guard let theArtist = searchArtist?.text else {return}
        print("the value of the artist:  " + theArtist)
        self.delegate?.searchArtistTextFieldValue(theArtist)
    }

    
    func showData(){
        
        activitySpin.isHidden = true
        artistTable.isHidden = false
        newSearchButton.isHidden = false
    }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArtistTableViewCell
//        let allNames = network.artistDetails.compactMap({$0.results[indexPath.row].artistName})
//        let allTrackNames = network.artistDetails.compactMap({$0.results[indexPath.row].trackName})
//        let allReleaseDates = network.artistDetails.compactMap({$0.results[indexPath.row].releaseDate})
//        let allPrimeGenres = network.artistDetails.compactMap({$0.results[indexPath.row].primaryGenreName})
//        let allTrackPrice = network.artistDetails.compactMap({$0.results[indexPath.row].trackPrice})
       // let stringOfAllTrackPrice = allTrackPrice.map{
          //  String($0)
        
        cell.artistNameLabel?.text = "Artist:" //+ allNames.joined()
//        cell.trackNameLabel?.text = "Track: " + allTrackNames.joined()
//        cell.relseaseDateLabel?.text = "Release Date: " + allReleaseDates.joined()
//        cell.primaryGenreLabel?.text = "Genre: " + allPrimeGenres.joined()
//        cell.trackPriceLabel.text = "Track Price: " + stringOfAllTrackPrice.joined()
//
      
    
            return cell
    }
        
}
    
    

