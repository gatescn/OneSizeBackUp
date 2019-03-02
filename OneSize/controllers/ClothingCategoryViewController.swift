import UIKit

class ClothingCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // --> segue to table:   toClothingTypePage
    
    public var clothingCategory: [clothingTypeDefine] = []
    private var activeCategory: clothingTypeDefine?
    
    //updates:
    //Categories not a user created thing, predefined... Hide not Delete
    //unwind segue for backbutton on Navigation
    //one file to do Rest calls
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.clothingCategory.append(clothingTypeDefine.init(type: "Shirts"))
        self.clothingCategory.append(clothingTypeDefine.init(type: "Pants"))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toClothingTypePage" {
            print("setting up page")
            ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing = self.activeCategory;
        }
    }

    @IBAction func myClosetButton(_ sender: Any) {
        performSegue(withIdentifier: "myClosetCategory", sender: nil)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return clothingCategory.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "clothingCategory")
        cell.textLabel?.text = clothingCategory[indexPath.row].typeName
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCellEditingStyle.delete){
            clothingCategory.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected: \(self.clothingCategory[indexPath.row].typeName)")  //works correctly..
        
        self.activeCategory = self.clothingCategory[indexPath.row]
        
        performSegue(withIdentifier: "toClothingTypePage", sender: nil)
        
    }
}



// clothing information containers------------------------------------------

class clothingDetail{
    
    private var clothingPicture: UIImage?
    private var clothingDetail: String?
    private var clothingStyle: String?
    
    init(detail: String ,image: UIImage, clothingStyle_: String) {
        self.clothingDetail = detail;
        self.clothingPicture = image;
        self.clothingStyle = clothingStyle_;
    }
    
    func getClothingInfo()-> (String, String, UIImage){
        return (self.clothingStyle!, self.clothingDetail!, self.clothingPicture!);
    }
    
}
//research ways of converting textual data(base 64 encoded string)to an image
//https://stackoverflow.com/questions/28709964/how-do-i-create-an-image-from-a-base64-encoded-string-in-swift
//translate image to base 64
//https://stackoverflow.com/questions/11251340/convert-between-uiimage-and-base64-string

//pass base64 string, when user takes image
//take picture of image, accessing camera inside application



class clothingTypeDefine{
    var typeName: String
    var clothingTypeContainer: [clothingDetail]
    
    init(type: String) {
        self.typeName = type
        self.clothingTypeContainer = []
    }
    
    public func addToType(clothing_: clothingDetail){
        self.clothingTypeContainer.append(clothing_)
        print("added clothing to \(self.typeName)");
    }
}
