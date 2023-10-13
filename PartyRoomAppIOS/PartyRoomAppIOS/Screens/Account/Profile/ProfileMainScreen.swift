import SwiftUI

struct ProfileMainScreen: View {
    @ObservedObject var viewModel =  ProfileViewModel()
    @EnvironmentObject var user: ApplicationUser
    @State private var isExpanded = false
    @State var isLogin: Bool
    var body: some View {
        NavigationView {
            ScrollView{
                Spacer()
                VStack{
                    if viewModel.isCurrentProfile{
                        navigationBar
                            .padding(.bottom,30)
                    }
                    header
                    Divider()
                    if let tags = viewModel.profile?.tags{
                        VStack(alignment: .leading){
                            Text("Предпочтения")
                                .font(.largeTitle)
                                .foregroundColor(Color.white)
                            TagCloudView(tags:$viewModel.goodTag,isCurrentProfile: viewModel.isCurrentProfile,isGood: true)
                            Divider()
                            Text("Антипатия")
                                .font(.largeTitle)
                                .foregroundColor(Color.white)
                            TagCloudView(tags:$viewModel.beadTag,isCurrentProfile: viewModel.isCurrentProfile,isGood: false)
                            
                        }
                        .padding(7)
                    }
                    Spacer()
                }
                .onAppear(perform: {
                    if viewModel.isCurrentProfile {
                        viewModel.loadCurrentProfile()
                    } else {
                        viewModel.loadProfile()
                    }
                })
                
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.25, green: 0.17, blue: 0.01).opacity(0.8), Color(red: 0.04, green: 0.08, blue: 0.22).opacity(0.9)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea()
                        
            )
            
        }
    }
    
    
    var navigationBar : some View{
        HStack{
            Button(action: {
                TokenManager.shared.clearTokens()
                user.loginStatus = ""
                isLogin = false
            }) {
                HStack {
                    Image(systemName: "arrow.left.circle.fill")
                    Text("Выйти")
                }
                .padding(7)
            }
            .frame(width: 100)
            .foregroundColor(.white)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            NavigationLink(destination: ProfileEditScreen(viewModel: viewModel.toProfileEditViewModel()))  {
                Image(systemName: "pencil")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            NavigationLink(destination: NotificationsScreen()) {
                Image(systemName: "bell.fill")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        
        .padding(.horizontal ,22)
    }
    
    var header:some View{
        HStack(alignment:.center){
            
            if let imagePath = viewModel.profile?.details.imagePath{
                AsyncImage(url: URL(string: imagePath))
                { image in
                    image
                        .resizable()
                        .frame(width: 120, height: 120)
                        .background(Color.gray)
                        .clipShape(Circle())
                    
                        .overlay(Circle().stroke(Color.orange, lineWidth: 3))
                    
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom,30)
            }
            if let profile = viewModel.profile{
                VStack(alignment: .leading){
                    HStack{
                        Text(profile.firtsName)
                            .font(Font.system(size: 22).weight(.semibold))
                            .foregroundColor(Color.white)
                        
                        Text(profile.lastName)
                            .font(Font.system(size: 22).weight(.semibold))
                            .foregroundColor(Color.white)
                    }
                    
                    Text("@"+profile.userName)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 7)
                    Text("О себе")
                        .font(Font.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                    
                    if isExpanded {
                        Text(profile.details.about)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.light)
                            .foregroundColor(Color.white)
                    } else {
                        Text(profile.details.about)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.light)
                            .lineLimit(2)
                            .foregroundColor(Color.white)
                    }
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Text(isExpanded ? "Свернуть" : "Развернуть")
                            .font(.system(size: 14))
                            .foregroundColor(.blue)
                    }
                }
                
            }
            
            
            Spacer()
        }
        .padding(6)
    }
    
    var about : some View{
        VStack {
            VStack(alignment: .leading){
                HStack {
                    Text("О Себе")
                        .font(.body)
                        .fontWeight(.bold)
                    Spacer()
                }
                if let about = viewModel.profile?.details.about{
                    Text(about)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .frame(maxWidth: .infinity)
    }
}
struct TagCollectionView : View{
    @State var tags: [Tag]
    var isGood: Bool
    @State var isCurrnetProfile:Bool
    var body: some View{
        VStack(alignment: .leading) {
            if isGood {
                Text("Предпочтения")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            } else {
                Text("Антипатия")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(tags) {tag in
                        HStack {
                            Text(tag.name)
                                .padding(.horizontal, 12.0)
                                .padding(.vertical, 8.0)
                                .lineLimit(1)
                            if isCurrnetProfile {
                                Button(action: {
                                    ProfileViewModel().deleteTag(id: tag.id)
                                    if let index = tags.firstIndex(where: { $0.id == tag.id
                                    }) {
                                        
                                        tags.remove(at: index)
                                    }
                                    
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(isGood ? Color.red : Color.black)
                                        .padding(.trailing, 10.0)
                                }
                            }
                        }
                        .cornerRadius(25)
                        .background(isGood ? Color.green : Color.red)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct TestView_Previews: PreviewProvider {
    @State static var isLogin: Bool = true
    static var previews: some View {
        let sampleProfile = ProfileModel(
            id: "1",
            firtsName: "Иван",
            lastName: "Иванов",
            userName: "Username",
            email: "user@example.com",
            phoneNumber: "1234567890",
            details: Details(about: "Привет! Я здесь, чтобы делиться и учиться. Люблю путешествия, науку и искусство. Давайте общаться и развиваться вместе! 🌍📚🎨 #СоциальнаяСеть #Личность", imagePath: "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"),
            tags: [Tag(id: "1", name: "tag1", important: true, isLike: false), Tag(id: "2", name: "Спорт", important: true, isLike: true), Tag(id: "3", name: "Искусство", important: true, isLike: false), Tag(id: "4", name: "1dqwd2у1", important: true, isLike: true),
                   Tag(id: "5", name: "12у1", important: true, isLike: true),
                   Tag(id: "6", name: "12уdwqdwq1", important: true, isLike: true),
                   Tag(id: "7", name: "12у1", important: true, isLike: true)]
        )
        
        let viewModel = ProfileViewModel(isLogin: true, isCurrentProfile: true)
        viewModel.profile = sampleProfile
        viewModel.beadTag = sampleProfile.tags
        viewModel.goodTag = sampleProfile.tags
        viewModel.isLogin = true
        
        return ProfileMainScreen(viewModel: viewModel,isLogin: isLogin)
    }
}
