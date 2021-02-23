//
//  SearchViewController.swift
//  FindThatArtist
//
//  Created by Field Employee on 2/20/21.
//

import UIKit

class SearchViewController: UIViewController {

    var artistDetails : [Artist] = []
    @IBOutlet weak var searchArtist: UITextField!
    
    @IBOutlet weak var artistTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistTable.dataSource = self

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       // let knownArtist = artistDetails
         let allNames = artistDetails.compactMap({$0.results[indexPath.row].artistName})
//        let table = self.artistDetails[0].results[0]
        cell.textLabel?.text = allNames.joined()
        //        cell.textLabel?.text = table.trackName
//        cell.textLabel?.text = table.releaseDate
//        cell.textLabel?.text = table.primaryGenreName
//        let trackPrice:String = "\(table.trackPrice)"
//        cell.textLabel?.text = trackPrice
            return cell
        
    }
    
    
}
