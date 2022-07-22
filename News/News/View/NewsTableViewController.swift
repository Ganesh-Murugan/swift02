//
//  ViewController.swift
//  News
//
//  Created by zoho on 13/07/22.
//

import UIKit
UITableViewController
class NewsTableViewController: UIViewController {
    let apiHandler = ApiHandler()
    var articles = [Article]()
//    let defaults = UserDefaults.standard
//    var vc = ArticleViewController()
//    let loader = LoaderViewController()
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        newstableViewSetup()
        getArticles()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.newsToArticleSegueIdentifier{
            let viewController = segue.destination as! ArticleViewController
            guard let indexPath = sender as? Int else {
                return
            }
            viewController.article = articles[indexPath]
        }
    }
    private func newstableViewSetup() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    private func getArticles(){
        let alert = self.startLoading("loading..")
        self.present(alert, animated: true)
        apiHandler.fetchArticles { [weak self] articles in
            self?.articles = articles
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
                self?.stopLoader(alert)
            }
        }
    }
}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        articles.isEmpty ? 10 :
            articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.newsTableViewCellIdentifier, for: indexPath) as! NewsTableViewCell
//        articles.isEmpty ? cell.setupLoaderCells() :
            cell.setupCell(self.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: Constants.StoryBoards.main, bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.articleTableViewController)
//        navigationController?.pushViewController(vc, animated: true)
        performSegue(withIdentifier: Constants.Identifiers.newsToArticleSegueIdentifier, sender: indexPath.row)
    }
    
}

