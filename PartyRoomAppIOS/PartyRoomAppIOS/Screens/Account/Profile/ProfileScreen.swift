import SwiftUI
import Alamofire
struct ProfileScreen: View {
    @ObservedObject var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isLogin {
            NavigationView {
                ScrollView {
                    VStack {
                        if let firstName = viewModel.profile?.firtsName, let lastName = viewModel.profile?.lastName, let imageUrl = viewModel.profile?.details.imagePath, let username = viewModel.profile?.userName {
                            HeaderProfileView(firstName: firstName, lastName: lastName, imageUrl: imageUrl, username: username, isLogin: $viewModel.isLogin, isCurrnetProfile: viewModel.isCurrentProfile)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color.gray)
                        }
                        if let about = viewModel.profile?.details.about {
                            BodyProfileView(about: about)
                                .padding()
                                .shadow(radius: 5)
                        }
                        if let tags = viewModel.profile?.tags {
                            TagProfileView(tags: tags.filter { tag in
                                return tag.isLike
                            }, isGood: true, isCurrnetProfile: viewModel.isCurrentProfile)
                            .padding()
                            .shadow(radius: 5)
                            TagProfileView(tags: tags.filter { tag in
                                return !tag.isLike
                            }, isGood: false, isCurrnetProfile: viewModel.isCurrentProfile)
                            .padding()
                            .shadow(radius: 5)
                        }
                    }
                }
                .onAppear(perform: {
                    if viewModel.isCurrentProfile {
                        viewModel.loadCurrentProfile()
                    } else {
                        viewModel.loadProfile()
                    }
                })
            }
        } else {
            LoginScreen()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProfile = ProfileModel(
            id: "1",
            firtsName: "Иван",
            lastName: "Иванов",
            userName: "Username",
            email: "user@example.com",
            phoneNumber: "1234567890",
            details: Details(about: "Описание о себе", imagePath: "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"),
            tags: [Tag(id: "1", name: "tag1", important: true, isLike: false), Tag(id: "2", name: "Спорт", important: true, isLike: true), Tag(id: "3", name: "Искусство", important: true, isLike: false), Tag(id: "4", name: "12у1", important: true, isLike: true)]
        )

        let viewModel = ProfileViewModel(isLogin: true, isCurrentProfile: true)
        viewModel.profile = sampleProfile
        viewModel.isLogin = true

        return ProfileScreen(viewModel: viewModel)
    }
}
