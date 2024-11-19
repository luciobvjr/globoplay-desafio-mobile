//
//  Untitled.swift
//  globoplay-iOS
//
//  Created by Lucio Bueno Vieira Junior on 19/11/24.
//

import SwiftUI

enum MediaDetailsOption {
    case watchToo, details, none
    
    var id: Self { self }
    
    var displayName: String {
        switch self {
        case .watchToo:
            return "Assita Também"
        case .details:
            return "Detalhes"
        default:
            return ""
        }
    }
}

struct CustomSegmentedPickerView: View {
    @Binding var selectedMediaType: MediaType
    @Binding var selectedMediaDetailsOption: MediaDetailsOption
    
    var body: some View {
        HStack {
            Group {
                if selectedMediaType != .none {
                    segmentedPickerButton(mediaType: .movie)
                    segmentedPickerButton(mediaType: .tv)
                }
                
                if selectedMediaDetailsOption != .none {
                    segmentedPickerButton(mediaDetailsOption: .watchToo)
                    segmentedPickerButton(mediaDetailsOption: .details)
                }
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
    
    @ViewBuilder
    private func segmentedPickerButton(mediaDetailsOption: MediaDetailsOption) -> some View {
        let isSelected = selectedMediaDetailsOption == mediaDetailsOption
        
        Button {
            selectedMediaDetailsOption = mediaDetailsOption
        } label: {
            VStack {
                Text(mediaDetailsOption.displayName)
                
                Rectangle()
                    .frame(height: 2)
                    .opacity(isSelected ? 1 : 0)
            }
            .foregroundStyle(isSelected ? Color.white : Color.gray)
        }
    }
}
