//
//  ViewController.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import UIKit

class ArticleListingVC: BaseVC {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    let articleViewModel = ArticleDIContainer().articleListingViewModel()
    var articleList: [Article]?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setLayout()
        bind(to: articleViewModel)
        articleViewModel.getPopularArticleList()
    }
    
    // MARK: - Functions
    func setLayout() {
        tableView.register(UINib(nibName: "ArticleListTVC", bundle: nil), forCellReuseIdentifier: "ArticleListTVC")
        tableView.register(UINib(nibName: "NoVideoCell", bundle: nil), forCellReuseIdentifier: "NoVideoCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

// MARK: - API Binding
extension ArticleListingVC{
    private func bind(to viewModel: ArticleListingViewModel) {
        viewModel.responseData.observe = { [weak self] response in
            self?.updatedResponse(response: response)
        }
        viewModel.errorMessage.observe =  { [weak self] error in
            self?.showAlert(withTitle: "Alert", message: error?.description ?? "no data found")
            print(error as Any)
        }
    }
    private func updatedResponse(response: ArticleListResponse){
        print(response)
        articleList = response.results
        tableView.reloadData()
    }
}

// MARK: - TableViewDelegates
extension ArticleListingVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (articleList?.count ?? 0) == 0 {
            return 1
        }else{
            return articleList?.count ?? 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (articleList?.count ?? 0) == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoVideoCell", for: indexPath) as! NoVideoCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListTVC", for: indexPath) as! ArticleListTVC
            let article = articleList?[indexPath.row]
            cell.setData(article: article)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (articleList?.count ?? 0) != 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let articleDetailVC = storyboard.instantiateViewController(withIdentifier: "ArticleDetailVC") as? ArticleDetailVC {
                articleDetailVC.article = articleList?[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
                self.navigationController?.pushViewController(articleDetailVC, animated: true)
            }
        }
    }
    
}
