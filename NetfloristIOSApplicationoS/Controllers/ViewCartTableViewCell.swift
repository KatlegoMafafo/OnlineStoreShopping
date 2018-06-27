import UIKit

class ViewCartTableViewCell: UITableViewCell {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodprice: UILabel!
    @IBOutlet weak var imageViewA: UIImageView!
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBAction func stepper(_ sender: UIStepper) {
        lblQuantity.text = String(Int(sender.value))
        //var price = Float(prodprice.text!) * Float(lblQuantity.text!)
        var price = Float(prodprice.text!) ?? 0
        var quan = Int(lblQuantity.text!) ?? 0
    
        var prodPrice = price * Float(quan)
    
        //prodprice.text! = String(prodsPrice);
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
} // end of code
