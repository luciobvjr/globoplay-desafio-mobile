//
//  Untitled.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUI

struct CustomSegmentedPickerView: View {
    @Binding var selectedMediaType: MediaType
    
    var body: some View {
        HStack {
            Group {
                segmentedPickerButton(mediaType: .movie)
                
                segmentedPickerButton(mediaType: .tv)
            }
            .frame(height: 80)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func segmentedPickerButton(mediaType: MediaType) -> some View {
        let isSelected = selectedMediaType == mediaType
        
        Button {
            selectedMediaType = mediaType
        } label: {
            VStack {
                Text(mediaType.displayName)
                
                Rectangle()
                    .frame(height: 2)
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(isSelected ? Color.white : Color.gray)
        }
    }
}
