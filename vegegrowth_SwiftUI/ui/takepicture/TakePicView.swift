//
//  TakePicView.swift
//  vegegrowth_SwiftUI
//
//  Created by toui on 2023/10/10.
//

import SwiftUI

struct TakePicView<ViewModel: TakePictureViewModelType>: View {
    let vegeItem: VegeItem
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                if viewModel.takePictureImage == nil {
                    Rectangle()
                        .scaledToFit()
                        .padding(32)
                        .foregroundColor(.gray.opacity(0.4))
                    Text(L10n.pictureNoneText)
                } else {
                    Image(uiImage: viewModel.takePictureImage!)
                        .resizable()
                        .scaledToFit()
                        .padding(50)
                }
            }
            
            TakePicButton(
                onTakePictureClick: { viewModel.isCameraOpen = true }
            )
            
            if viewModel.isVisibleRegisterButton {
                RegisterDataButton(
                    onRegisterClick: { }
                )
            }
        }
        .customDialog(isOpen: viewModel.isOpenRegisterDialog) {
            RegisterAlertDialog(
                inputText: $viewModel.inputText,
                onAddButtonClick: { },
                onCanselButtonClick: { viewModel.changeRegisterDialog() },
                isRegisterable: viewModel.isRegisterable,
                isFirstOpenDialog: viewModel.isFirstOpenRegisterDialog
            )
        }
        .navigationBarTitle(vegeItem.name, displayMode: .inline)
        .navigationBarItems(trailing: Button(
            action: { viewModel.changeRegisterDialog() }, label: {
                Text(L10n.navigateManageScreenText)
            }))
        .fullScreenCover(isPresented: $viewModel.isCameraOpen) {
            CameraView(image: $viewModel.takePictureImage).ignoresSafeArea()
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
    let isRegisterable: Bool
    let isFirstOpenDialog: Bool
    
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
                Image(asset: Asset.Images.errorCircle)
                Text(L10n.registerDialogErrorText)
            }
            .foregroundColor(isRegisterable || isFirstOpenDialog ? .clear : .red)
            
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
                            .foregroundColor(isRegisterable ? .black : .gray)
                    )
                    .disabled(!isRegisterable)
            }
            .padding(.top, 0)
        }
        .padding(24)
    }
}

struct TakePicView_Previews: PreviewProvider {
    @State var inputText: String = ""
    
    static var previews: some View {
        let vegeList: [VegeItem] = VegeItemList().getVegeList()
        NavigationView {
            TakePicView(
                vegeItem: vegeList[0],
                viewModel: TakePictureViewModel()
            )
        }
    }
}
