# Test Yummy

La aplicación es una muestra de las fotos publicadas dia tras dia de la nasa.

## Installation

Use cocoa pods [cocoapods](https://cocoapods.org/) he instala los pods de dependencias .

```bash
pod install
```

## Dependencias Usadas

```javascript
target 'test_yummy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire',                            '4.9.0'
  pod 'lottie-ios',                           '3.1.8'
  pod 'SDWebImage',                           '5.6.1'
  pod 'Firebase/Analytics'
  # Pods for test_yummy

  target 'test_yummyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'test_yummyUITests' do
    # Pods for testing
  end

end
```

- Alamofire: consumo de servicios api rest.
- lottie-ios: consumo he implementación de animaciones .json.
- SDWebImage: descargar imagenes y menejo de cache para su reconsumo posteriormente.
- Firebase/Analytics: para la implemntacion de CD con firebase app Distribution.

## Arquitectura usada
- mvvm: la idea es la implementación de [POP](https://medium.com/globallogic-latinoamerica-mobile/la-programaci%C3%B3n-orientada-a-protocolos-en-swift-3548ed2dc2f1) conjunto con un viewModel con los protocolos
```swift
import Foundation
import UIKit

protocol InformationHealthyLifeViewToViewModel {
    func succesGetListPictores(nasaPictores:[NASAPictore])
    func succesGetPictores(nasaPictore:NASAPictore)
    func showError(error:String)
    //...

}

protocol InformationHealthyLifeViewModelToView:class {
    func getListLastPictores(controller:UIViewController, dateInit: Date)
    func getPictores(controller:UIViewController, datePictores: Date)
}
```
- y por medio de binding s entregar los resuelto en los servicios para las vistas

```swift
// MARK: - ListPictoresViewModel
extension ListPictoresViewController: InformationHealthyLifeViewToViewModel {
    func succesGetListPictores(nasaPictores: [NASAPictore]) {
        self.nasaPictores = nasaPictores
        apodCollectionView.reloadData()

    }

    func succesGetPictores(nasaPictore: NASAPictore) {
        self.nasaPictore = nasaPictore
        performSegue(withIdentifier: Constants.SHOW_DETAIL, sender: nil)

    }

    func showError(error: String) {
        shoeAlertWithMessagge(controller: self, messagge: error)
    }


}
```
- se agrego una arquitectura repository para el manejo de storage
- una clase de trato de data dependiendo de la necesidad del negocio
```swift
import Foundation
import UIKit

public class ApiResponse {

    func getData(url:String, Ok:@escaping((NSData) -> Void), Error:@escaping((NSError) -> Void))
    {

            let apiRest = ApiService()
            let headers = [
                "Content-Type":"application/json"]

            apiRest.getApi(url: url,
                           Headers: headers as NSDictionary,
                           statusCodeCorrect: [200, 201],
                           Ok: {data in

                            Ok(data as NSData)

            }, Error: {error in

                Error(error as NSError)
            })
    }


    func postData(url:String, parameters:NSDictionary, Ok:@escaping((NSData) -> Void), Error:@escaping((NSError) -> Void))
    {

            let apiRest = ApiService()
            let headers = [
                "Content-Type":"application/json"]

            apiRest.postApi(url: url,
                            headers: headers,
                            parameters: parameters,
                            statusCodeCorrect: [200, 201],
                            Ok: {data in
                                Ok(data as NSData)
            }, Error: {error in
                Error(error as NSError)
            })
    }

    func putData(url:String, parameters:NSDictionary, Ok:@escaping((NSData) -> Void), Error:@escaping((NSError) -> Void))
    {


            let apiRest = ApiService()
            let headers = [
                "Content-Type":"application/json"]

            apiRest.putApi(url: url,
                           headers: headers,
                           parameters: parameters,
                           statusCodeCorrect: [200, 201],
                           Ok: {data in
                            Ok(data as NSData)
            }, Error: {error in

                Error(error as NSError)
            })
    }



}

```

- y una etapa de encapsulamiento mas dedicada al negocio
```swift
import Foundation
import Alamofire

public class ApiService {
    func getApi(url:String,
                Headers:NSDictionary,
                statusCodeCorrect:[Int],
                Ok:@escaping ((Data) -> Void),
                Error:((Error) -> Void))
    {

        Alamofire.request(url, method: .get, headers: Headers as? HTTPHeaders).responseJSON { response in

            switch response.result
            {
                case .success:
                    let result = response.data
                    Ok(result!)
                case .failure:
                    let result = response.data
                    Ok(result!)

            }

        }
    }


    func getApiCorrect(url:String,
                Headers:NSDictionary,
                statusCodeCorrect:[Int],
                Ok:@escaping ((Data) -> Void),
                Error:@escaping((Error) -> Void))
    {

        Alamofire.request(url, method: .get, headers: Headers as? HTTPHeaders).responseJSON { response in
            print("::: STATUS CODE \(String(describing: response.response?.statusCode))")


            var isCorrect = false;
            for status in statusCodeCorrect{
                if response.response?.statusCode == status{
                    isCorrect = true;
                    break
                }
            }
            if isCorrect
            {
                let result_ = response.data
                Ok(result_!)
            }else{
                if let errorrr = response.error{
                    Error(errorrr)
                }else{
                    let errorTemp = NSError(domain:"Ha ocurrido un erro", code:302, userInfo:nil)

                    Error(errorTemp)
                }
                //definir errores
            }
        }
    }

    func postApiCorrect(url: String,
                 headers: HTTPHeaders,
                 parameters: NSDictionary?,
                 statusCodeCorrect:[Int],
                 Ok: @escaping((Data) -> Void),
                 Error: @escaping((Error) -> Void))
    {
        Alamofire.request(url, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            print("::: STATUS CODE \(response.response?.statusCode ?? 0)")
             var isCorrect = false;
             for status in statusCodeCorrect{
                 if response.response?.statusCode == status{
                     isCorrect = true;
                     break
                 }
             }
             if isCorrect
             {
                 let result_ = response.data
                 Ok(result_!)
             }else{
                 if let errorrr = response.error{
                     Error(errorrr)
                 }else{
                     let errorTemp = NSError(domain:"Ha ocurrido un erro", code:302, userInfo:nil)

                     Error(errorTemp)
                 }

                 //definir errores
             }
        }
    }

    func deleteApiCorrect(url: String,
                 headers: HTTPHeaders,
                 parameters: NSDictionary?,
                 statusCodeCorrect:[Int],
                 Ok: @escaping((Data) -> Void),
                 Error: @escaping((Error) -> Void))
    {
        Alamofire.request(url, method: .delete, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            print("::: STATUS CODE \(response.response?.statusCode ?? 0)")
             var isCorrect = false;
             for status in statusCodeCorrect{
                 if response.response?.statusCode == status{
                     isCorrect = true;
                     break
                 }
             }
             if isCorrect
             {
                 let result_ = response.data
                 Ok(result_!)
             }else{
                 if let errorrr = response.error{
                     Error(errorrr)
                 }else{
                     let errorTemp = NSError(domain:"Ha ocurrido un erro", code:302, userInfo:nil)

                     Error(errorTemp)
                 }

                 //definir errores
             }
        }
    }


    func postApi(url: String,
                 headers: HTTPHeaders,
                 parameters: NSDictionary?,
                 statusCodeCorrect:[Int],
                 Ok: @escaping((Data) -> Void),
                 Error: ((Error) -> Void))
    {
        Alamofire.request(url, method: .post, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            switch response.result
            {
                case .success:
                    let result = response.data
                    Ok(result!)
                case .failure:
                    let result = response.data

                    Ok(result!)
            }
        }
    }

    func putApi(url: String,
                    headers: HTTPHeaders,
                    parameters: NSDictionary?,
                    statusCodeCorrect:[Int],
                    Ok: @escaping((Data) -> Void),
                    Error: ((Error) -> Void))
       {
           Alamofire.request(url, method: .put, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

               switch response.result
               {
                   case .success:
                       let result = response.data
                       Ok(result!)
                   case .failure:
                       let result = response.data
                       Ok(result!)
               }
           }
       }



}
```
- y por medio del viewModel nos comunicamos con las vista.

```swift
import Foundation
import UIKit

class ListPictoresViewModel {
    var informationHealthyLifeViewToViewModel: InformationHealthyLifeViewToViewModel?
    var apiResponse = ApiResponse()
    init(informationHealthyLifeViewToViewModel: InformationHealthyLifeViewToViewModel) {
        self.informationHealthyLifeViewToViewModel = informationHealthyLifeViewToViewModel
    }

    func getDateFormat(date:Date) -> String {

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"

        return dateFormatterPrint.string(from: date)
    }

    func getLast8Days(date:Date) -> [Date] {
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: date)

        var days = [Date]()

        for _ in 1 ... 8 {
            // get day component:

            days.append(date)


            date = cal.date(byAdding: .day, value: -1, to: date)!
        }

        return days
    }

    func getLastTenDates() -> (textList: [String], dates: [Date] ){
        var days = [Date]()
        var daysText = [String]()
        let cal = NSCalendar.current
        // start with today
        var date = cal.startOfDay(for: Date())
        for _ in 1 ... 10 {
            // get day component:

            days.append(date)
            daysText.append(getDateFormat(date: date))

            date = cal.date(byAdding: .day, value: -8, to: date)!
        }

        return (daysText, days)
    }

    func getPictoreDayOfDay(i: Int, nasaPictores: [NASAPictore], dateInit: Date, ok: @escaping (([NASAPictore]) -> Void)) {
        let dates = getLast8Days(date: dateInit)
        var nasaPictores1 = nasaPictores
        getPictoreOfDate(date: dates[i], ok: {nasaPictore in
            if i < 7 {
                nasaPictores1.append(nasaPictore)
                self.getPictoreDayOfDay(i: i + 1, nasaPictores : nasaPictores1, dateInit: dateInit, ok:  { nasaPictore1 in

                    })
            } else {
                nasaPictores1.append(nasaPictore)

                ok(nasaPictores1)
                SwiftSpinner.hide()
                self.informationHealthyLifeViewToViewModel?.succesGetListPictores(nasaPictores: nasaPictores1)

            }
        }, error: {err in
            SwiftSpinner.hide()
            self.informationHealthyLifeViewToViewModel?.showError(error: "En este momento no podemos completar tu consulta")
        })
    }
    func getPictoreOfDate(date:Date, ok: @escaping ((NASAPictore) -> Void), error: @escaping ((String) -> Void)) {
        let url = getUrlApod().replacingOccurrences(of: "{date}", with: getDateFormat(date: date))

        apiResponse.getData(url: url, Ok: { data in

            do{
                let nasaPictore = try JSONDecoder().decode(NASAPictore.self, from: data as Data)
                ok(nasaPictore)
            } catch let e as NSError {
                error(e.description)

            }
        }, Error: { errorr in
            error(errorr.description)
        })
    }
}

extension ListPictoresViewModel: InformationHealthyLifeViewModelToView {

    func getListLastPictores(controller:UIViewController, dateInit: Date ) {

        let nasaPictores = [NASAPictore]()
        SwiftSpinner.show()
        getPictoreDayOfDay(i: 0, nasaPictores: nasaPictores, dateInit: dateInit, ok: { nasaPictores1 in
            //
        })

    }

    func getPictores(controller:UIViewController, datePictores: Date) {
        SwiftSpinner.show()
        getPictoreOfDate(date: datePictores, ok: {nasaPictore in
            SwiftSpinner.hide()
            self.informationHealthyLifeViewToViewModel?.succesGetPictores(nasaPictore: nasaPictore)
        }, error: {err in
            SwiftSpinner.hide()
            self.informationHealthyLifeViewToViewModel?.showError(error: err.description)
        })
    }
}
```


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
