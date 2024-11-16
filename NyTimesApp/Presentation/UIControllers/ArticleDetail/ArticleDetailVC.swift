//
//  ArticleDetailVC.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import UIKit

class ArticleDetailVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var publishDateLbl: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    // MARK: - Variables
    var article: Article?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        // Do any additional setup after loading the view.
        setLayout()
    }
    
    // MARK: - Setlayout
    func setLayout(){
        // doing this to get the big images other 2 images are small
        if (article?.media?.first?.mediaMetadata?.count ?? 0) > 1 {
            if let url = URL(string: article?.media?.first?.mediaMetadata?[2].url ?? "") {
                mainImageView.loadImage(from: url, placeholder: UIImage(named: "dummy"))
            }
        }
        titleLbl.text = article?.title ?? ""
        descriptionLbl.text = article?.abstract ?? ""
        publishDateLbl.text = article?.published_date ?? ""
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
