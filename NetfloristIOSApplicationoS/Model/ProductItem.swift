import Foundation
import CoreLocation

struct ProductItem: Decodable {
    let ProductID:String
    let ProductName:String
    let Description:String
    let Price:String
    let IMG_URL:String
    let cartid:String
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        
        guard let ProductID = json["ProductID"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let ProductName = json["ProductName"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let Description = json["Description"] as? String else {throw SerializationError.missing("temp is missing")}
        
        guard let Price = json["Price"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let IMG_URL = json["IMG_URL"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let cartid = json["cartid"] as? String else {throw SerializationError.missing("temp is missing")}
        
        self.ProductID = ProductID
        self.ProductName = ProductName
        self.Description = Description
        self.Price = Price
        self.IMG_URL = IMG_URL
        self.cartid = cartid
        //self.CategoryID = CategoryID
    }
    
    
    static let basePath = "http://kholofelochoeu.000webhostapp.com/FetchAllProducts.php"
    
    static func forecast (completion: @escaping ([ProductItem]?) -> ()) {
        
        //let url = basePath
        let request = URLRequest(url: URL(string: basePath)!)
        var productArray:[ProductItem] = []
        
        guard let url = URL(string: basePath) else { print("URL is invalid"); return }
        
        URLSession.shared.dataTask(with: url)
        {
            (data, response,err) in
            
            //print(data)
            guard let data = data else{return}
            do
            {
                let product = try JSONDecoder().decode([ProductItem].self, from: data )
                
                for i in 0 ... product.count - 1
                {
                    //print (product[i].ProductName)
                    productArray.append(product[i])
                    
                    //print(product[i])
                    
                    //self.productName.text = product[i].ProductName;
                    //tableViewProduct.te
                }
                //print(productArray)
                //print(array)
                
                //productName.text = array[1].ProductName;
            }
            catch let jsonErr
            {
                print(jsonErr)
            }
            completion(productArray)
            }.resume()
    }
} // end of code
