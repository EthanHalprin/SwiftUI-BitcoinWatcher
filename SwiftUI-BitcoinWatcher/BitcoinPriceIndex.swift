//
//  BitcoinQuote.swift
//  BitcoinWatch
//
//  Created by Ethan on 08/10/2021.
//

import Foundation

//   let BitcoinQuote = try? newJSONDecoder().decode(BitcoinQuote.self, from: jsonData)


// MARK: - BitcoinQuote
struct BitcoinQuote: Codable {
    let time: [String: String]
    let disclaimer, chartName: String
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Eur

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Eur: Codable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}

/*

Sample Fetch
 
{
  "time" :
    {
      "updated":"Oct 8, 2021 06:09:00 UTC",
      "updatedISO":"2021-10-08T06:09:00+00:00",
      "updateduk":"Oct 8, 2021 at 07:09 BST"
    },
    "disclaimer":"This data....",
    "chartName":"Bitcoin",
    "bpi": {
              "USD": {
                        "code":"USD",
                        "symbol":"&#36;",
                        "rate":"54,121.3900",
                        "description":"United States Dollar",
                        "rate_float":54121.39
              },
              "GBP":
                    {
                        "code":"GBP",
                        "symbol":"&pound;",
                        "rate":"39,803.8469",
                        "description":"British Pound Sterling",
                        "rate_float":39803.8469
                    },
            "EUR":{
                        "code":"EUR",
                        "symbol":"&euro;",
                        "rate":"46,890.3934",
                        "description":"Euro",
                        "rate_float":46890.3934
                }
    }
}
 */
