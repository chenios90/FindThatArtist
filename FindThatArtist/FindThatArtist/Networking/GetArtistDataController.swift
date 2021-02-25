//
//  GetArtistDataController.swift
//  FindThatArtist
//
//  Created by Field Employee on 2/24/21.
//

import UIKit

class GetArtistDataController: UIViewController {

    let svc = SearchViewController()
    
    var artistDetails : [Artist] = []
    var artistNameArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
            controller.delegate = self
        print("hungry hungry hippos")
        present(controller, animated: true, completion: nil)
        print("artist array")
        print(artistNameArray)
        print(controller.passDelegate())
        // Do any additional setup after loading the view.
    }
    

    
    func constructURL(artistName: String) -> String{
        let api: String = "https://itunes.apple.com/"
        let endpoint: String = "search?term=\(artistName)"
        let url = (api + endpoint)
        
        return url
    }
    
    func getArtistData(){
        let theArtist = artistNameArray.joined()
        
        let theArtistTrimmed = theArtist.trimmingCharacters(in: .whitespaces)
        
        let url = constructURL(artistName: theArtistTrimmed)
        URLSession.shared.dataTask(with: URL(string: url)!){ [weak self](data, _, error) in

        guard let data = data else{
        return
        }

        do {
        let artistData = try JSONDecoder().decode(Artist.self, from: data)
            self?.artistDetails.append(artistData)
        DispatchQueue.main.async {
            self?.svc.artistTable.reloadData()
        }
        } catch {
        print(error)
        }

        }.resume()
        }
    
    }
extension GetArtistDataController: GetTextFieldValueDelegate {
    func searchArtistTextFieldValue(_ name: String) {
        artistNameArray.append(name)
        print("test is")
        print(name)
    }
}


