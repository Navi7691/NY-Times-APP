//
//  ArticleListTVC.swift
//  NyTimesApp
//
//  Created by Naveed Tahir on 16/11/2024.
//

import UIKit

class ArticleListTVC: UITableViewCell {
    // MARK: - IBOUTLETS
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var aticleTitle: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    func setData(article: Article?){
        self.aticleTitle.text = article?.title ?? ""
        self.articleDescription.text = article?.abstract ?? ""
        self.publishDate.text = article?.published_date ?? ""
        self.authorName.text = article?.byline ?? ""
        articleImageView.roundAllCorners(radius: 30)
        if let url = URL(string: article?.media?.first?.mediaMetadata?.first?.url ?? "") {
            articleImageView.loadImage(from: url, placeholder: UIImage(named: "dummy"))
        }
    }
}
