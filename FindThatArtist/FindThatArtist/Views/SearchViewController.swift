//
//  SearchViewController.swift
//  FindThatArtist
//
//  Created by Field Employee on 2/20/21.
//

import UIKit

class ArtistTableViewCell: UITableViewCell{

    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var relseaseDateLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var primaryGenreLabel: UILabel!
    
}

class SearchViewController: UIViewController {

    var artistDetails : [Artist] = []
    @IBOutlet weak var searchArtist: UITextField!
    
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
    
    func constructURL(artistName: String) -> String{
        let api: String = "https://itunes.apple.com/"
        let endpoint: String = "search?term=\(artistName)"
        let url = (api + endpoint)
        
        return url
    }
    
    @IBAction func newSearch(_ sender: Any) {
        newSearchButton.isHidden = true
        searchButton.isHidden = false
        searchArtist.isHidden = false
        artistDetails.removeAll()
        
    }
    @IBAction func SearchArtist(_ sender: Any) {
     
        searchArtist.isHidden = true
        searchButton.isHidden = true
        activitySpin.isHidden = false
        getArtistData()
        showData()
        }
    
    func getArtistData(){
        let theArtist = searchArtist.text!
       
        
        let url = constructURL(artistName: theArtist)
        print(url)
        URLSession.shared.dataTask(with: URL(string: url)!){ [weak self](data, _, error) in

        guard let data = data else{
        return
        }

        do {
        let artistData = try JSONDecoder().decode(Artist.self, from: data)
            self?.artistDetails.append(artistData)
        DispatchQueue.main.async {
        self?.artistTable.reloadData()
        }
        } catch {
        print(error)
        }

        }.resume()
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
         let allNames = artistDetails.compactMap({$0.results[indexPath.row].artistName})
        let allTrackNames = artistDetails.compactMap({$0.results[indexPath.row].trackName})
        let allReleaseDates = artistDetails.compactMap({$0.results[indexPath.row].releaseDate})
        let allPrimeGenres = artistDetails.compactMap({$0.results[indexPath.row].primaryGenreName})
        let allTrackPrice = artistDetails.compactMap({$0.results[indexPath.row].trackPrice})
        let stringOfAllTrackPrice = allTrackPrice.map{
            String($0)
        }
        cell.artistNameLabel?.text = "Artist: " + allNames.joined()
        cell.trackNameLabel?.text = "Track: " + allTrackNames.joined()
        cell.relseaseDateLabel?.text = "Release Date: " + allReleaseDates.joined()
        cell.primaryGenreLabel?.text = "Genre: " + allPrimeGenres.joined()
        cell.trackPriceLabel.text = "Track Price: " + stringOfAllTrackPrice.joined()
      
            return cell
        
    }
    
    
}
