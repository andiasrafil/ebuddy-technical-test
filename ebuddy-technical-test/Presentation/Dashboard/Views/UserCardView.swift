//
//  UserCardView.swift
//  ebuddy-technical-test
//
//  Created by Andi Asrafil on 05/12/24.
//

import SwiftUI

struct UserCardView: View {
    var user: UserJSON
    var onSuccessSelectImage: (Image) async -> Bool
    var body: some View {
        HStack(spacing: 0) {
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 8) {
            topBarSection
            AnyView(imageSection)
            bottomSection
        }
        
        .background(Color.background)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.text, lineWidth: 2)
        )
        .padding(16)
    }
    
    var topBarSection: some View {
        HStack {
            name
            status
            Spacer()
            verified
            instagram
            
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
    }
    
    var imageSection: any View {
        if let imageUrl = user.image, !imageUrl.isEmpty {
            ZStack(alignment: .topLeading) {
                image(imageUrl: imageUrl)
                overlayContent
                
            }
            .padding(.horizontal, 8)
        } else {
            EmptyView()
        }
    }
    
    var bottomSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            rating
            price
        }
        .padding(16)
    }
    
    var overlayContent: some View {
        VStack(alignment: .leading) {
            availableToday
            Spacer()
            gameAndVoice
        }
    }
    
    var gameAndVoice: some View {
        HStack(spacing: 0) {
            games
            Spacer()
            voice
        }
        .padding(.horizontal, 8)
    }
    
    var games: some View {
        HStack(spacing: 0) {
            Image("ml-game")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(.circle)
            Image("ml-game")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                )
                .offset(x: -10)
                .overlay {
                    ZStack {
                        Color.black.opacity(0.6)
                            .clipShape(Circle())
                        Text("+3")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                    .offset(x: -10)
                }
            
        }
    }
    
    var name: some View {
        Text("Zynx")
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(.text)
    }
    
    var status: some View {
        Circle()
            .frame(width: 18, height: 18)
            .foregroundStyle(.green)
    }
    
    var verified: some View {
        Image("verified")
            .resizable()
            .frame(width: 40, height: 40)
    }
    
    var instagram: some View {
        Image("instagram")
            .resizable()
            .frame(width: 40, height: 40)
    }
    
    var voice: some View {
        Circle()
            .foregroundStyle(
                LinearGradient(colors: [.init(red: 1.0, green: 0.796078431372549, blue: 0.6274509803921569), .init(red: 0.8666666666666667, green: 0.3411764705882353, blue: 0.5372549019607843), .init(red: 0.6078431372549019, green: 0.3568627450980392, blue: 0.9019607843137255)], startPoint: .topTrailing, endPoint: .bottomLeading)
            )
            .overlay(
                Image("voice")
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            )
            .frame(width: 60, height: 60)
    }
    
    var availableToday: some View {
        HStack(spacing: 6) {
            Image("lighting")
                .resizable()
                .frame(width: 20, height: 30)
            Text("Available today!")
                .font(.system(size: 25))
                .foregroundColor(Color.white)
        }
        .frame(height: 60, alignment: .leading)
        .padding(.horizontal, 24)
        .background(.ultraThinMaterial.opacity(0.7))
        .cornerRadius(100)
        .padding(.top, 24)
        .padding(.leading, 16)
    }
    
    var rating: some View {
        HStack {
            Image("star")
                .resizable()
                .frame(width: 32, height: 32)
            Text("4.9")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.text)
            Spacer()
        }
    }
    
    var price: some View {
        HStack {
            Image("mana")
                .resizable()
                .frame(width: 32, height: 32)
            Group {
                Text("110")
                    .font(.system(size: 24, weight: .bold))
                + Text(".00/1Hr")
                    .font(.system(size: 16, weight: .regular))
            }
            .foregroundStyle(.text)
        }
        .padding(.top, 8)
    }
    
    func image(imageUrl: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)!) {
            $0.image?.resizable()
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .padding(.bottom, 24)
    }
}
