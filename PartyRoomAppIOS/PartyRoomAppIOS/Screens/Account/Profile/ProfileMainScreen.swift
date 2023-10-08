import SwiftUI

struct ProfileMainScreen: View {
    @ObservedObject var viewModel =  ProfileViewModel()
    @EnvironmentObject var user: ApplicationUser
    @State private var isExpanded = false

    @State var isLogin: Bool
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    if viewModel.isCurrentProfile{
                        navigationBar
                            .padding(.bottom,50)
                    }
                                    
                        header

                    Divider()
                    if let tags = viewModel.profile?.tags{
                        VStack(alignment: .leading){
                            Text("Предпочтения")
                                .font(.largeTitle)
                            
                            TagCloudView(tags:tags.filter { tag in
                                return tag.isLike
                            },isCurrentProfile: viewModel.isCurrentProfile,isGood: true)
                            Text("Антипатия")
                                .font(.largeTitle)
                            TagCloudView(tags:tags.filter { tag in
                                return !tag.isLike
                            },isCurrentProfile: viewModel.isCurrentProfile,isGood: false)
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
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .clipShape(Circle())
                        
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                    
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom,30)
            }
            if let profile = viewModel.profile{
                VStack(alignment: .leading){
                    HStack{
                        Text(profile.firtsName)
                            .font(Font.system(size: 18).weight(.semibold))
                            .foregroundColor(Color.black)
                        
                        Text(profile.lastName)
                            .font(Font.system(size: 18).weight(.semibold))
                            .foregroundColor(Color.black)
                    }
                    
                    Text("@"+profile.userName)
                        .font(Font.system(size: 16))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 7)
                    Text("О себе")
                        .font(Font.system(size: 16))
                        .fontWeight(.medium)
                    
                    if isExpanded {
                        Text(profile.details.about)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.light)
                    } else {
                        Text(profile.details.about)
                            .multilineTextAlignment(.leading)
                            .fontWeight(.light)
                            .lineLimit(2)
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
                        .font(AppFonts.headlineFont)
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
                    .font(AppFonts.headlineFont)
                    .fontWeight(.bold)
            } else {
                Text("Антипатия")
                    .font(AppFonts.headlineFont)
                    .fontWeight(.bold)
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
        viewModel.isLogin = true
        
        return ProfileMainScreen(viewModel: viewModel,isLogin: isLogin)
    }
}
