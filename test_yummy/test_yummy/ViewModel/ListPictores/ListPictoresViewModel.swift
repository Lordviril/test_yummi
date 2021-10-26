//
//  ListPictoresViewModel.swift
//  TestSoyYo
//
//  Created by Pedro Alonso Daza B on 6/09/20.
//  Copyright © 2020 Pedro Alonso Daza B. All rights reserved.
//

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
