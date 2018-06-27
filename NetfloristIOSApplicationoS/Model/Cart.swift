import Foundation
import CoreLocation

struct Cart: Decodable {
    let id:String
    let name:String
    let description:String
    let price:String
    let img_url:String
    let quantity:String
    let customer:String
    let ordernumber:String
    
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        
        //guard let CategoryID = json["categoryID"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let id = json["id"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let name = json["name"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let description = json["description"] as? String else {throw SerializationError.missing("temp is missing")}
        
        guard let price = json["price"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let img_url = json["img_url"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let quantity = json["quantity"] as? String else {throw SerializationError.missing("temp is missing")}
        
        guard let customer = json["customer"] as? String else {throw SerializationError.missing("temp is missing")}
        
        guard let ordernumber = json["ordernumber"] as? String else {throw SerializationError.missing("temp is missing")}
        
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.img_url = img_url
        self.quantity = quantity
        self.customer = customer
        //self.CategoryID = CategoryID
        self.ordernumber = ordernumber
    }
    
    
    static let basePath = "http://kholofelochoeu.000webhostapp.com/FetchCart.php"
    
    static func forecast (completion: @escaping ([Cart]?) -> ()) {
        
       
        let defaults = UserDefaults.standard
        var email = defaults.string(forKey: "Email")

        var b = ""
        b = (email?.replacingOccurrences(of: "Optional(", with:""))!

        //let url = basePath
        //var request = URLRequest(url: URL(string: basePath)!)
        var productArray:[Cart] = []

        //guard let url = URL(string: basePath) else { print("URL is invalid"); return }
        var dataString = "";

        dataString = dataString + "&email=\(b)"

        print(dataString)
        let dataD = dataString.data(using: .utf8)


        let url = NSURL(string: basePath)

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        

        URLSession.shared.uploadTask(with: request, from: dataD)
        {
            (data, response,err) in
            
        
            guard let data = data else{return}
            do
            {
                let product = try JSONDecoder().decode([Cart].self, from: data )
                print(product)
                //print(product.count)
                //var array = [Product]() //alternatively (does the same): var array = Array<Country>()
                
                for i in 0 ... product.count - 1
                {
                    //print (product[i].ProductName)
                    productArray.append(product[i])
                    
                    
                }
                
            }
            catch let jsonErr
            {
                print(jsonErr)
            }
            

            completion(productArray)
        }.resume()
    }
} // end of code

