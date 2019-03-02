import UIKit

class ClothingInformationViewController: UIViewController, UINavigationControllerDelegate{
    public static var initialPickerSetup: Bool = false;
    public static var brandNameCollection : [String] = []
    public static var clothingColorCollection: [String] = []
    public static var clothingSizeCollection: [String] = []
    public static var clothingStyleCollection: [String] = []
    @IBOutlet weak var brandNamePicker: UIPickerView!
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var stylePicker: UIPickerView!
    @IBOutlet weak var newColorTextField: UITextField!
    @IBOutlet weak var newBrandTextField: UITextField!
    @IBOutlet weak var newSizeTextField: UITextField!
    @IBOutlet weak var newStyleTextField: UITextField!
    @IBOutlet weak var descriptionTextBox: UITextField!
    @IBOutlet weak var newColorLabel: UILabel!
    @IBOutlet weak var newBrandLabel: UILabel!
    @IBOutlet weak var newSizeLabel: UILabel!
    @IBOutlet weak var newStyleLabel: UILabel!
    @IBOutlet weak var takePicture: UIButton!
    @IBOutlet weak var pickPicture: UIButton!
    @IBOutlet weak var savePicture: UIButton!
    @IBOutlet weak var selectedImage: UIImageView!
    
    var selectedColor: String = ""
    var selectedBrand: String = ""
    var selectedSize: String = ""
    var selectedStyle: String = ""
    var tempSelectedColor: String = ""
    var tempSelectedBrand: String = ""
    var tempSelectedSize: String = ""
    var tempSelectedStyle: String = ""
    var clothesDescription: String = "hi"
    var newSizeInputed: Bool = false
    var newStyleInputed: Bool = false
    var newColorInputed: Bool = false
    var newBrandInputed: Bool = false
    var personalImageUsed: Bool = false
    var defaultClothesImage: UIImage = UIImage(named:"clothesHanger.jpeg")!
    var submittedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        brandNamePicker.delegate = self
        brandNamePicker.dataSource = self
        colorPicker.delegate = self
        colorPicker.dataSource = self
        sizePicker.dataSource = self
        sizePicker.delegate = self
        stylePicker.delegate = self
        stylePicker.dataSource = self
        temporaryPickerSetup();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toClothingContainer"{
            print("setting up clothingContainer page")
            
            if let destinationVC = segue.destination as? ClothingSelectionViewController{
                destinationVC.addToContainer(detail_: self.clothesDescription, picture_: self.clothesImageDecider(), style_: self.selectedStyle)
                if newStyleInputed == true {
                    print("new style to add to main closet: \(self.selectedStyle)")
                }
            }
        }
    }
    
    @IBAction func openCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func photoPicker(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func saveImage(_ sender: Any) {
        let imageData = UIImagePNGRepresentation(selectedImage.image!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        
        let savedImageAlert = UIAlertController(title: "Image Saved", message: "Your Image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        savedImageAlert.addAction(okAction)
        self.present(savedImageAlert, animated: true, completion: nil)
    }

    
    func clothesImageDecider()-> UIImage{
        if self.personalImageUsed == true {
            print("using personal image")
            return self.submittedImage!
        }else{
            print("using default image")
            return defaultClothesImage
        }
        
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        var informationSubmited = false;
        
        if informationSubmited == false{
            if newColorTextField.text != "" {
                self.selectedColor = newColorTextField.text!
                print("selected color: \(self.selectedColor)")
                ClothingInformationViewController.clothingColorCollection.append(self.selectedColor);
            }else{
                self.selectedColor = self.tempSelectedColor
                print("selected color: \(self.selectedColor)")

            }
            if newBrandTextField.text != "" {
                self.selectedBrand = newBrandTextField.text!
                print("selected brand: \(self.selectedBrand)")
                ClothingInformationViewController.brandNameCollection.append(self.selectedBrand);
            }else{
                self.selectedBrand = self.tempSelectedBrand
                print("selected brand: \(self.selectedBrand)")
            }
            if newSizeTextField.text != "" {
                self.selectedSize = newSizeTextField.text!
                print("selected size: \(self.selectedSize)")
                ClothingInformationViewController.clothingSizeCollection.append(self.selectedSize);
            }else{
                self.selectedSize = self.tempSelectedSize
                print("selected size: \(self.selectedSize)")
            }
            if newStyleTextField.text != "" {
                self.selectedStyle = self.newStyleTextField.text!
                self.newStyleInputed = true;
                print("selected style: \(self.selectedStyle)")
                ClothingInformationViewController.clothingStyleCollection.append(self.selectedStyle)
            }else{
                self.selectedStyle = self.tempSelectedStyle
                print("selected style: \(self.selectedStyle)")
            }
            if self.descriptionTextBox.text != "" {
                self.clothesDescription = self.descriptionTextBox.text!
            }
            informationSubmited = true;
        }
        
        if informationSubmited == true  {
            performSegue(withIdentifier: "toClothingContainer", sender: nil);
            //prepare segue, send information to other class, populate the array.. 
        }
    }//sets selected fields to variables and send information to correct array of clothes
    
    
    // TEMPORARY functions to setup temp data -----------
    
    private func temporaryPickerSetup(){
        if ClothingInformationViewController.initialPickerSetup == false {
            ClothingInformationViewController.brandNameCollection.append("Add New Brand")
            ClothingInformationViewController.brandNameCollection.append("Polo")
            ClothingInformationViewController.brandNameCollection.append("Ripple Junction")
            ClothingInformationViewController.brandNameCollection.append("Cat and Jack")
            ClothingInformationViewController.clothingColorCollection.append("Add New Color")
            ClothingInformationViewController.clothingColorCollection.append("Red")
            ClothingInformationViewController.clothingColorCollection.append("Grey")
            ClothingInformationViewController.clothingStyleCollection.append("Add New Style")
            ClothingInformationViewController.clothingStyleCollection.append("Any")
            ClothingInformationViewController.clothingStyleCollection.append("NightTime")
            ClothingInformationViewController.clothingStyleCollection.append("Business")
            ClothingInformationViewController.clothingStyleCollection.append("Casual")
            ClothingInformationViewController.clothingSizeCollection.append("Add New Size")
            ClothingInformationViewController.clothingSizeCollection.append("S")
            ClothingInformationViewController.clothingSizeCollection.append("M")
            ClothingInformationViewController.clothingSizeCollection.append("L")
            ClothingInformationViewController.clothingSizeCollection.append("XL")
            ClothingInformationViewController.clothingSizeCollection.append("XXL")
            ClothingInformationViewController.initialPickerSetup = true;
            print("Initial Picker Setup: \(ClothingInformationViewController.initialPickerSetup)")
            
        }
        
    }
     // end of TEMPORARY functions to setup temp data------------
}

extension UIViewController{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
}

extension ClothingInformationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var pickerSize: Int = 0
        if pickerView == brandNamePicker{
            pickerSize = ClothingInformationViewController.brandNameCollection.count
        }else if pickerView == colorPicker{
            pickerSize = ClothingInformationViewController.clothingColorCollection.count
        }else if pickerView == sizePicker{
            pickerSize = ClothingInformationViewController.clothingSizeCollection.count
        }else if pickerView == stylePicker{
            pickerSize = ClothingInformationViewController.clothingStyleCollection.count
        }
        return pickerSize
    }
}

extension ClothingInformationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var currentTitle: String = ""
        if pickerView == sizePicker {
            currentTitle = ClothingInformationViewController.clothingSizeCollection[row]
            
        }else if pickerView == colorPicker{
            currentTitle = ClothingInformationViewController.clothingColorCollection[row]
            
        } else if pickerView == brandNamePicker{
            currentTitle = ClothingInformationViewController.brandNameCollection[row]
            
        } else if pickerView == stylePicker{
            currentTitle = ClothingInformationViewController.clothingStyleCollection[row]
        }
        return currentTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sizePicker {
            if ClothingInformationViewController.clothingSizeCollection.count != 0 && row != 0{
                self.newSizeTextField.isHidden = true
                self.newSizeLabel.isHidden = true
                self.tempSelectedSize = ClothingInformationViewController.clothingSizeCollection[row]
                print("size selected: \(self.tempSelectedSize)")
            }else if ClothingInformationViewController.clothingSizeCollection.count != 0 && row == 0{
                print("user entering new  size")
                self.newSizeTextField.isHidden = false
                self.newSizeLabel.isHidden = false
            }else{
                print("clothing size array is empty")
            }
            
        }else if pickerView == colorPicker{
            if ClothingInformationViewController.clothingColorCollection.count != 0 && row != 0{
                self.newColorTextField.isHidden = true
                self.newColorLabel.isHidden = true
                self.tempSelectedColor = ClothingInformationViewController.clothingColorCollection[row]
                print("color selected: \(self.tempSelectedColor)")
            }else if ClothingInformationViewController.clothingColorCollection.count != 0 && row == 0{
                print("user entering new color")
                self.newColorTextField.isHidden = false
                self.newColorLabel.isHidden = false
            }else{
                print("clothing color array is empty")
            }
        } else if pickerView == brandNamePicker{
            if ClothingInformationViewController.brandNameCollection.count != 0 && row != 0{
                self.newBrandTextField.isHidden = true;
                self.newBrandLabel.isHidden = true;
                self.tempSelectedBrand = ClothingInformationViewController.brandNameCollection[row]
                print("brand name selected: \(self.tempSelectedBrand)")
            }else if ClothingInformationViewController.brandNameCollection.count != 0 && row == 0{
                print("user entering new brand")
                self.newBrandTextField.isHidden = false;
                self.newBrandLabel.isHidden = false;
            }else{
                print("clothing brand array is empty")
            }
        } else if pickerView == stylePicker{
            if ClothingInformationViewController.clothingStyleCollection.count != 0 && row != 0{
                self.newStyleTextField.isHidden = true;
                self.newStyleLabel.isHidden = true;
                self.tempSelectedStyle = ClothingInformationViewController.clothingStyleCollection[row]
                print("style selected: \(self.tempSelectedStyle)")
            }else if ClothingInformationViewController.clothingStyleCollection.count != 0 && row == 0{
                print("user entering new style")
                self.newStyleTextField.isHidden = false;
                self.newStyleLabel.isHidden = false;
            }else{
                print("clothing style array is empty")
            }
        }
    }
}

extension ClothingInformationViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("setting image as clothes image")
        if let selectedClothesImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImage.contentMode = .scaleToFill
            selectedImage.image = selectedClothesImage
            
            self.submittedImage = selectedClothesImage.copy() as? UIImage
            self.personalImageUsed = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

