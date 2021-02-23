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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistTable.dataSource = self
        artistTable.isHidden = true

    }
    
    func constructURL(artistName: String) -> String{
        //https://itunes.apple.com/search?term=jack+johnson
        let api: String = "https://itunes.apple.com/"
        let endpoint: String = "search?term=\(artistName)"
        let url = (api + endpoint)
        
        return url
    }
    
    @IBAction func SearchArtist(_ sender: Any) {
     
            getArtistData()
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
            print(self?.artistDetails)
        DispatchQueue.main.async {
        self?.artistTable.reloadData()
        }
        } catch {
        print(error)
        }

        }.resume()
        }
}

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArtistTableViewCell
       // let knownArtist = artistDetails
         let allNames = artistDetails.compactMap({$0.results[indexPath.row].artistName})
        let allTrackNames = artistDetails.compactMap({$0.results[indexPath.row].trackName})
        let allReleaseDates = artistDetails.compactMap({$0.results[indexPath.row].releaseDate})
        let allPrimeGenres = artistDetails.compactMap({$0.results[indexPath.row].primaryGenreName})
        let allTrackPrice = artistDetails.compactMap({$0.results[indexPath.row].trackPrice})
        let stringOfAllTrackPrice = allTrackPrice.map{
            String($0)
        }
        let artist: String = "Artist"
    
//        let table = self.artistDetails[0].results[0]
        cell.artistNameLabel?.text = "artist name: " + allNames.joined()
        cell.trackNameLabel?.text = allTrackNames.joined()
        cell.relseaseDateLabel?.text = allReleaseDates.joined()
        cell.primaryGenreLabel?.text = allPrimeGenres.joined()
       // cell.trackPriceLabel?.text = "\(allTrackPrice)"
        cell.trackPriceLabel.text = stringOfAllTrackPrice.joined()
      
            return cell
        
    }
    
    
}
