import SwiftUI
struct TagCloudView: View {
    @Binding var tags: [Tag]
    let isCurrentProfile:Bool
    let isGood:Bool
    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack(alignment: .leading) {
                GeometryReader { geometry in
                    self.generateContent(in: geometry)
                }
            }
            .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags) { tag in
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for tag: Tag) -> some View {
        HStack {
            Text("#"+tag.name)
                .padding(.all, 5)
                .font(.body)
            if isCurrentProfile{
                Button(action: {
                    if let index = self.tags.firstIndex(where: { $0.id == tag.id }) {
                        self.tags.remove(at: index)
                    }
                }) {
                    Image(systemName: "xmark.circle")
                        .padding(.trailing, 10.0)
                }
            }
          
        }
  
        .background(tag.isLike ? Color.green : Color.red)
        .foregroundColor(Color.white)
        .cornerRadius(5)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
struct TestTagCloudView: View {
    @State private var tags: [Tag] = [
        Tag(id: "1", name: "Ninetendo", important: false, isLike: false),
        Tag(id: "2", name: "XBox", important: true, isLike: false),
        Tag(id: "3", name: "PlayStation", important: false, isLike: false),
        Tag(id: "4", name: "PlayStation 2", important: true, isLike: false),
        Tag(id: "5", name: "PlayStation 3", important: false, isLike: false),
        Tag(id: "6", name: "PlayStation 4", important: true, isLike: false)
    ]
    var body: some View {
        VStack {
           
            TagCloudView(tags: $tags,isCurrentProfile: true,isGood: true)
        }
    }
}
struct TestTagCloudView_Previews: PreviewProvider {
    static var previews: some View {
        TestTagCloudView()
    }
}