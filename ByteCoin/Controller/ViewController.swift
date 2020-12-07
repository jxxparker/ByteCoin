import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let coinManager = CoinManager() //connecting viewcontroller with CoinManager from models
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self //datasource for the picker
        currencyPicker.delegate = self
    }
}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate  {
    //The data source provides the picker view with the number of components, and the number of rows in each component, for displaying the picker view data. it means it can get data such as number and row.
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { //Called by the picker view when it needs the number of components.
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
       
    }
}

