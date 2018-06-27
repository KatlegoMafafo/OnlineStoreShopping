import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageB: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPeric: UILabel!
    @IBOutlet weak var imageA: UIImageView!
    @IBOutlet weak var cartProdName: UILabel!
    @IBOutlet weak var cartProdPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
} // end of code
