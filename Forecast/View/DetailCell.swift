//
//  DetailCell.swift
//  Forecast
//
//  Created by Mansa Pratap Singh on 04/06/21.
//

import SwiftUI

struct DetailCell: View {
    
    // MARK: - Properties
    let title: String
    let detail: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.body).fontWeight(.light)
            Text(detail).bold()
        }
        Divider()
    }
}
