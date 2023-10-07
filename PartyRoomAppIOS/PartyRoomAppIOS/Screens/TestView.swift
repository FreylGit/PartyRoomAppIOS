import SwiftUI

struct TestView: View {
    @ObservedObject var viewModel =  ProfileViewModel()
    @EnvironmentObject var user: ApplicationUser
    @State var isLogin: Bool
    var body: some View {
      
            NavigationView {
                VStack{
                    if viewModel.isCurrentProfile{
                        navigationBar
                    }
                    
                    header
                    about
                    if let tags = viewModel.profile?.tags{
                        TagCollectionView(tags:tags.filter { tag in
                            return tag.isLike
                        }, isGood: true, isCurrnetProfile: viewModel.isCurrentProfile)
                        
                        TagCollectionView(tags:tags.filter { tag in
                            return !tag.isLike
                        }, isGood: false, isCurrnetProfile: viewModel.isCurrentProfile)
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
    
    var navigationBar : some View{
        HStack{
            Button(action: {
                TokenManager.shared.clearTokens()
                user.loginStatus = ""
                isLogin = false
            }){
                Image(systemName: "arrow.left.circle.fill")
                    .padding(10)
                    .frame(width: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            Spacer()
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
        VStack{
            if let imagePath = viewModel.profile?.details.imagePath{
                AsyncImage(url: URL(string: imagePath))
                { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.gray)
                        .clipShape(Circle())
                    
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                } placeholder: {
                    ProgressView()
                }
            }
            if let profile = viewModel.profile{
                Text(profile.firtsName)
                    .font(Font.system(size: 18).weight(.semibold))
                    .foregroundColor(Color.black)
                
                Text(profile.lastName)
                    .font(Font.system(size: 18).weight(.semibold))
                    .foregroundColor(Color.black)
                
                Text("@"+profile.userName)
                    .font(Font.system(size: 16))
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 10)
            }
            if  viewModel.isCurrentProfile {
                NavigationLink(destination: ProfileEditScreen(viewModel: viewModel.toProfileEditViewModel())) {
                    HStack {
                        Text("Редактировать")
                        Image(systemName: "pencil")
                    }
                    .padding(.all, 8)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 10)
            }
            
        }
    }
    
    var about : some View{
        VStack(alignment: .leading) {
            
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
                                   tagItemCollection(tag: tag,isCurrnetProfile: true)
                                   
                               }
                           }
                       }
                   }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
    
    struct tagItemCollection : View{
        var tag: Tag
        var isCurrnetProfile = true
        var body: some View{
            HStack {
                Text(tag.name)
                    .padding(.horizontal, 12.0)
                    .padding(.vertical, 8.0)
                    .lineLimit(1)
                if isCurrnetProfile {
                    Button(action: {
                        print(tag.name + " нужно удалить")
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color.red)
                            .padding(.trailing, 10.0)
                    }
                }
            }
            .cornerRadius(25)
            .background(Color.green)
        }
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
            details: Details(about: "Описание о себе", imagePath: "http://localhost:5069/api/Image/omvsqnfg.fom.jpg"),
            tags: [Tag(id: "1", name: "tag1", important: true, isLike: false), Tag(id: "2", name: "Спорт", important: true, isLike: true), Tag(id: "3", name: "Искусство", important: true, isLike: false), Tag(id: "4", name: "12у1", important: true, isLike: true)]
        )

        let viewModel = ProfileViewModel(isLogin: true, isCurrentProfile: true)
        viewModel.profile = sampleProfile
        viewModel.isLogin = true
        
        return TestView(viewModel: viewModel,isLogin: isLogin)
    }
}
