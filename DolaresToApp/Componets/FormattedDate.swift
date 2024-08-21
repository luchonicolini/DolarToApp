//
//  FormattedDate.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import Foundation

func formattedDate(from dateString: String?) -> String? {
    guard let dateString = dateString else { return nil }
    
    // Define los formateadores de fecha
    let dateFormatterGet: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    let dateFormatterPrint: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        formatter.locale = Locale.current
        return formatter
    }()
    
    // Intenta convertir la fecha
    guard let date = dateFormatterGet.date(from: dateString) else {
        print("Error: no se pudo convertir la cadena de fecha.")
        return nil
    }
    
    return dateFormatterPrint.string(from: date)
}
