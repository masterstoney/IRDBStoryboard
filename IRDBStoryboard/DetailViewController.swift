//
//  DetailViewController.swift
//  IRDBStoryboard
//
//  Created by Tendaishe Gwini on 20/03/2019.
//  Copyright © 2019 Tendaishe Gwini. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    
    //MARK: Properties
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    
    @IBOutlet weak var yearLabel: UILabel!
    
    
    @IBOutlet weak var formatLabel: UILabel!
    

    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var studioLabel: UILabel!
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var movie: IRDBEntry?
    
    //MARK: Methods
    
    func setupView() {
        
        movieImageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        movieImageView.layer.borderWidth = 3.0
        
        if let movie = movie {
            self.navigationItem.title = movie.name
            movieTitleLabel.text = movie.name
            yearLabel.text = movie.yearStart
            formatLabel.text = movie.format
            if let episodes = movie.episodes {
                episodeLabel.text = "\(episodes)"
            }
            studioLabel.text = movie.network
            let attributedText = NSMutableAttributedString(string: movie.description! + "\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
            attributedText.append(NSAttributedString(string: movie.summary!, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]))
            descriptionTextView.attributedText = attributedText
            fetchImage(url: URL(string: movie.imageURL!)!) { (image, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
    
            }
        }
        
        
        
        
        
    }
    
    
    private func fetchImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        var image: UIImage?
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { (fileURL, response, error) in
            
            if error != nil {
                completion(image,error)
                return
            }
            
            if let fileURL = fileURL {
                do {
                    let data = try Data(contentsOf: fileURL)
                    image = UIImage(data: data)
                } catch {
                    completion(image,error)
                    return
                }
            }
            completion(image,error)
        }
        task.resume()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
