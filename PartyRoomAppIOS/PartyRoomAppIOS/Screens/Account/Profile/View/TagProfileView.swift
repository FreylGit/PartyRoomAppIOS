import SwiftUI

struct TagProfileView : View {
    @State var tags: [Tag]
    var isGood: Bool

    var body: some View {
        VStack(alignment: .leading) {
            if isGood {
                Text("Предпочтения")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(tags, id: \.self.id) { tag in
                        TagView(tag: tag)
                            .cornerRadius(10)
                            .padding(.trailing, 17.0)
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

struct TagView: View {
    var tag: Tag
    
    var body: some View {
        HStack {
            Text(tag.name)
                .padding(.horizontal, 12.0)
                .padding(.vertical, 8.0)
                .lineLimit(1)
            Button(action: {
                print(tag.name + " нужно удалить")
            }) {
                Image(systemName: "trash")
                    .foregroundColor(Color.red)
                    .padding(.trailing, 10.0)
            }
        }
        .cornerRadius(25)
        .background(Color.green)
    }
}



struct TagProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TagProfileView(tags: [Tag(id: "1", name: "tagdwqdqwd1", important: true),Tag(id: "2", name: "tag2", important: true),Tag(id: "3", name: "tag1", important: true),Tag(id: "5", name: "tag1", important: true)],isGood: true)
    }
}
