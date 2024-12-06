//
//  ImageProfileView.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

@MainActor
class ImageModel: ObservableObject {
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
    }
    
    init(onSuccess: @escaping (Image) async -> Bool) {
        self.onSuccess = onSuccess
    }
    
    var onSuccess: (Image) async -> Bool
    
    struct ProfileImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return ProfileImage(image: image)

            }
        }
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    Task {
                        self.imageState = .loading(.init(totalUnitCount: 50))
                        let success = await self.onSuccess(profileImage.image)
                        if success {
                            self.imageState = .success(profileImage.image)
                        }
                    }
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

struct ImageProfileView: View {
    @ObservedObject var viewModel: ImageModel
    var body: some View {
        VStack {
            CircularProfileImage(viewModel: viewModel)
                .overlay(alignment: .bottomTrailing) {
                    switch viewModel.imageState {
                    case .empty:
                        PhotosPicker(selection: $viewModel.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Image(systemName: "pencil.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 12))
                                .foregroundColor(.accentColor)
                        }
                        .buttonStyle(.borderless)
                    default:
                        EmptyView()
                    }
                }
        }
    }
}

struct ProfileImage: View {
    @ObservedObject var viewModel: ImageModel
    
    var body: some View {
        switch viewModel.imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    @ObservedObject var viewModel: ImageModel
    
    var body: some View {
        ProfileImage(viewModel: viewModel)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 50, height: 50)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}


