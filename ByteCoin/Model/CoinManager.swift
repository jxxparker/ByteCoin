import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "411361F2-48DB-4783-A0BD-189B55991969"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        //Use String concatenation to add the selected currency at the end of the baseURL along with the API key.
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        //Use optional binding to unwrap the URL that's created from the urlString
        if let url = URL(string: urlString) {
            //Create a new URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            //create a new data task for the urlsession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                //Format the data we got back as a string to be able to print it.
                if let safeData = data {
                    let bitcoinPrice = self.parseJSON(safeData)
                }
            }
            //start task to fetch data from bitcoin averages servers.
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        //create a jsondecoder
        let decoder = JSONDecoder() //jsondecoder is swift built in json decoder(obvoius as it soudns)
        do {
           //decode the data using the codedata structure
            let decodedData = try decoder.decode(CoinData.self, from: data) //decode: Decodes an instance of the indicated type.
            //get the last property from the decoded Data.
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch { //if above fails
            //catch and print any errors.
            print(error)
            return nil
        }
    }
}
