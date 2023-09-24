import SwiftUI

struct TagProfileView : View{
    @State var tags: [Tag]
    var body: some View{
        HStack() {
            ForEach(tags, id: \.self.id) { tag in
                HStack {
                    Text(tag.name)
                        .padding(.all, 12.0)
                    
                    Button(action: {
                        print(tag.name+" нужно удалить")
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Color.red)
                            .padding(.trailing, 10.0)
                    }
                    
                }
                .background(Color.green)
                .padding(.bottom, 5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct TagProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TagProfileView(tags: [Tag(id: "1", name: "tag1", important: true),Tag(id: "2", name: "tag2", important: true),Tag(id: "3", name: "tag1", important: true)])
    }
}
