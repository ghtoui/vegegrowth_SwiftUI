//
//  TakePicView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/10.
//

import SwiftUI

struct TakePicView: View {
    let vegeItem: VegeItem
    @State var inputText: String = ""
    @State var isOpenRegisterDIalog: Bool = false
    @State var isCameraOpen: Bool = false
    @State var takePictureImage: UIImage?
    
    var body: some View {
        let isVisibleRegisterButton: Bool = true
        NavigationView {
            VStack(spacing: 30) {
                ZStack {
                    Rectangle()
                        .scaledToFit()
                        .padding(32)
                        .foregroundColor(.gray.opacity(0.4))
                    
                    if takePictureImage == nil {
                        Text(L10n.pictureNoneText)
                    } else {
                        Image(uiImage: takePictureImage!)
                    }
                }
                
                TakePicButton(
                    onTakePictureClick: { isCameraOpen = true }
                )
                
                if isVisibleRegisterButton {
                    RegisterDataButton(
                        onRegisterClick: { }
                    )
                }
            }
            .customDialog(isOpen: isOpenRegisterDIalog) {
                RegisterAlertDialog(
                    inputText: $inputText,
                    onAddButtonClick: { },
                    onCanselButtonClick: { },
                    isNotNoneText: true
                )
            }
            .navigationBarTitle(vegeItem.name, displayMode: .inline)
            .navigationBarItems(trailing: Button(
                action: { isOpenRegisterDIalog = !isOpenRegisterDIalog }, label: {
                    Text(L10n.navigateManageScreenText)
                }))
            .fullScreenCover(isPresented: $isCameraOpen) {
                        CameraView(image: $takePictureImage).ignoresSafeArea()
                    }
        }
    }
}

struct TakePicButton: View {
    let onTakePictureClick: () -> Void
    
    var body: some View {
        Button(
            action: { onTakePictureClick() }, label: {
                HStack {
                    Image(asset: Asset.Images.photoCamera)
                    Text(L10n.takePhotoButtonText)
                }
            })
            .frame(width: 130, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue))
    }
}

struct RegisterDataButton: View {
    let onRegisterClick: () -> Void
    
    var body: some View {
        Button(
            action: { onRegisterClick() }, label: {
                HStack {
                    Image(asset: Asset.Images.registerData)
                    Text(L10n.registerDataButtonText)
                }
            })
            .frame(width: 130, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.blue))
    }
}

struct RegisterAlertDialog: View {
    @Binding var inputText: String
    let onAddButtonClick: () -> Void
    let onCanselButtonClick: () -> Void
    let isNotNoneText: Bool
    
    var body: some View {
        VStack {
            Text(L10n.registerDialogTitile)
                .lineLimit(2)
                .font(.title)
                .minimumScaleFactor(0.5)
            TextField(L10n.noneText, text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(height: 30)
            
            HStack {
                Button(L10n.canselText, role: .cancel) { onCanselButtonClick() }
                    .frame(width: 100, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                    )
                    .padding(.trailing, 4)
                Button(L10n.addText, role: .none) { onAddButtonClick() }
                    .padding()
                    .frame(width: 100, height: 30)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1)
                            .foregroundColor(isNotNoneText ? .black : .gray)
                    )
                    .disabled(!isNotNoneText)
            }
            .padding(.top, 40)
        }
        .padding(24)
    }
}

struct TakePicView_Previews: PreviewProvider {
    static var previews: some View {
        let vegeList: [VegeItem] = VegeItemList().getVegeList()
        TakePicView(
            vegeItem: vegeList[0]
        )
    }
}
