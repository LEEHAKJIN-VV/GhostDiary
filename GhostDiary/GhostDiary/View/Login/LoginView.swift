//
//  LoginView.swift
//  GhostDiary
//
//  Created by 이학진 on 2022/12/14.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn
import AuthenticationServices

struct LoginView: View {
    @EnvironmentObject var authStores: AuthStore
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.window) var window: UIWindow?
    @State private var appleLoginCoordinator: AppleAuthCoordinator?
    
    @Binding var isLogin: Bool
    @Binding var isLoading: Bool
    
    @State var isSingUp: Bool = false
    @State private var isEmailLogin: Bool = false
    
    
    var socialLoginButton: some View {
        VStack {
            Button {
                handleSignInButton()
            } label: {
                HStack {
                    Spacer()
                    Image("googleButton")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Text("Google로 계속하기")
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth - 75, height: 44)
                .border(.gray)
            }
            
            Button {
                appleLogin()
            } label: {
                HStack(alignment: .center) {
                    Spacer()
                    Image("appleLoginButton")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 44)
                    Text("Apple로 계속하기")
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                }
                .frame(width: UIScreen.screenWidth - 75, height: 44)
                .border(.gray)
            }
        }
        .background(.white)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("나를 찾아주는 100개의 질문에 답을 해보세요.")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                socialLoginButton
                
                Divider()
                    .padding(.vertical)
                
                HStack {
                    NavigationLink(destination: EmailLoginView(isLogin: $isLogin, isLoading: $isLoading)) {
                        Text("이메일로 로그인")
                    }
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("이메일로 회원가입")
                    }
                }
                
                .foregroundColor(.black)
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $isEmailLogin) {
            EmailLoginView(isLogin: $isLogin, isLoading: $isLoading)
        }
        .navigationDestination(isPresented: $isSingUp) {
            SignUpView()
        }

        .onAppear {
            authStores.startListeners()
        }
        .onDisappear {
            authStores.disConnectListeners()
        }
    }
    
    func handleSignInButton() {
        authStores.googleSignIn()
    }
    
    func appleLogin() {
        appleLoginCoordinator = AppleAuthCoordinator(window: window)
        appleLoginCoordinator?.startAppleLogin()
    }
}

struct LoginButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: UIScreen.main.bounds.width)
            .foregroundColor(.white)
            .background(Color("Color3"))
            .cornerRadius(40)
    }
}

//TODO: - LoadingView 파일 위치 이동
struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("Color1")))
                .scaleEffect(3)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isLogin: Bool = false
    @State static var isLoading: Bool = false
    static var previews: some View {
        LoginView(isLogin: $isLogin, isLoading: $isLoading)
            .environmentObject(AuthStore())
    }
}
