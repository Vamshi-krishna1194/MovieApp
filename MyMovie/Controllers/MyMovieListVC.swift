//
//  MyMovieListVC.swift
//  MyMovie
//
//  Created by vamshi krishna on 23/06/23.
//

import UIKit
import Kingfisher

class MyMovieListVC: UIViewController {
    
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    var viewModel = MovieListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        movieListCollectionView.register(UINib(nibName: "MovieListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        if let layout = movieListCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
                layout.minimumLineSpacing = 10
                layout.minimumInteritemSpacing = 10
                layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                let size = CGSize(width:(movieListCollectionView!.bounds.width-30)/2, height: (movieListCollectionView!.bounds.width-30)/2)
                layout.itemSize = size
        }
        
        viewModel.getMoviesData(collectionView: movieListCollectionView)


        // Do any additional setup after loading the view.
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
extension MyMovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
//        cell.cellView.applyGradient()
        let movieName = viewModel.movies?.results?[indexPath.row].title
        let imageURL = viewModel.movies?.results?[indexPath.row].poster_path ?? ""
        let url = URL(string: AppConstants.imagesBaseUrl+imageURL)
        let processor = DownsamplingImageProcessor(size: cell.movieImageView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.movieImageView.kf.indicatorType = .activity
        cell.movieImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: ""),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
        cell.movieNameLabel.text = movieName
//        cell.addShadow()
        return cell
    }
    
    
    
    
}
