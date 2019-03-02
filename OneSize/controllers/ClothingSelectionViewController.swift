import UIKit

class ClothingSelectionViewController: UIViewController {
    
    public static var clothingCategoryCurrentlyBrowsing: clothingTypeDefine?;
    var currentStyleSelection: [String] = [];
    var currentStyleViewing: String = "";
    var styleSearchResultArray: [clothingDetail] = [];
    
    var reuseIdentifier: String = "clothingCell";
    
    @IBOutlet weak var clothingCollection: UICollectionView!
    @IBOutlet weak var stylesToViewPicker: UIPickerView!
    
    override func viewWillAppear(_ animated: Bool) {
            //self.currentStyleSelection = clothingInformation.clothingStyleCollection;
        if ClothingInformationViewController.clothingStyleCollection.count != 0 {
            for i in 1..<ClothingInformationViewController.clothingStyleCollection.count{
                self.currentStyleSelection.append(ClothingInformationViewController.clothingStyleCollection[i]);
            }
        }else{
            print("style array is empty")
        }
        //make the styles available array equal to the styles available.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("clothing section: \(String(describing: ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.typeName))")
        self.currentStyleViewing = "Any"
        print("setting default style section to view which is \(self.currentStyleViewing)")
        
        // Do any additional setup after loading the view.
        clothingCollection.delegate = self;
        clothingCollection.dataSource = self;
        stylesToViewPicker.delegate = self;
        stylesToViewPicker.dataSource = self;
        
        clothingCollection.reloadData();
        stylesToViewPicker.reloadAllComponents();
        
        print("amount of clothing in \(String(describing: ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.typeName)) container: \(String(describing: ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer.count))")
    }
    
    //update clothing container method
    func addToContainer(detail_: String, picture_: UIImage, style_: String){
        print("adding clothing with description: \(detail_) to closet with style: \(style_)")
        ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.addToType(clothing_: clothingDetail.init(detail: detail_, image: picture_, clothingStyle_: style_))
        
    }
    func searchAndCompileStyle(searchFor: String){
        for clothing in (ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer)!{
            if(searchFor == clothing.getClothingInfo().0){
                //if the style matches the search style.. add to search results
                self.styleSearchResultArray.append(clothing);
            }
        }
        clothingCollection.reloadData()
    }
    
    func clearSearchResultsArray(){
        if self.styleSearchResultArray.count != 0 {
            self.styleSearchResultArray.removeAll()
        }
    }

    //will have to change the viewed clothes based on style....
    //possible idea:
    // when user switches style in picker, grab the current style ..
    // do a check of the clothes to view and make sure the clothes match that current style
}

extension ClothingSelectionViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //could show a bigger picture when selected??????????
    }
}

extension ClothingSelectionViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var searchArraySize: Int = 0;
        if(self.currentStyleViewing == "Any"){
            return (ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer.count)!
            
        }else if self.styleSearchResultArray.count != 0{
            searchArraySize = self.styleSearchResultArray.count
        }
        return searchArraySize;
    }
    

    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! ClothingCell
        if ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer.count != 0 {
            //if style is set to Any.. show all clothes..
            
            if(self.currentStyleViewing == "Any"){
                print("Back to Default View")
                cell.clothingName.text = ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer[indexPath.row].getClothingInfo().1
                cell.clothingImage.image = ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer[indexPath.row].getClothingInfo().2
                print("Style: \(String(describing: ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer[indexPath.row].getClothingInfo().0))")
            }else if self.styleSearchResultArray.count != 0 {
                //set cells to specifc search array
                cell.clothingName.text = self.styleSearchResultArray[indexPath.row].getClothingInfo().0
                cell.clothingImage.image = self.styleSearchResultArray[indexPath.row].getClothingInfo().2
                
            }
        }else{
            print("Clothing container is empty, nothing to access...")
        }
        
        return cell;
        //will need to implement some sort of search to check what the picker is set on.. if matches shows clothes under that style section??????
    }
}

extension ClothingSelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.currentStyleSelection[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //if select anything other than any, change items available in collection view....
        self.currentStyleViewing = self.currentStyleSelection[row]
        print("style showing: \(self.currentStyleViewing)")
        if ClothingSelectionViewController.clothingCategoryCurrentlyBrowsing?.clothingTypeContainer.count != 0 && self.currentStyleViewing != "Any" {
            self.clearSearchResultsArray();
            self.searchAndCompileStyle(searchFor: self.currentStyleViewing);
            print("Data reloading")
        }
        if self.currentStyleViewing == "Any"{
            print("Data resetting to Any")
            clothingCollection.reloadData();
        }
    }
}

extension ClothingSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.currentStyleSelection.count
    }
}
