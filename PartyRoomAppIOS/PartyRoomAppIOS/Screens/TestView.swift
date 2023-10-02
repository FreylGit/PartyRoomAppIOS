import SwiftUI

struct TestView: View {
    var data1: [TestData] = [
        TestData(id: "1", name: "Name 1"),
        TestData(id: "2", name: "Name2222"),
        TestData(id: "3", name: "Name33333333"),
    ]
    var data2: [TestData] = [

        TestData(id: "4", name: "Name444"),
        TestData(id: "5", name: "Name55"),
    ]
    var body: some View {
        ScrollView {
            Grid{
                CastomGridLine(list: data1)
                CastomGridLine(list: data2)
            }
        }
    }
    
}

struct CastomGridLine:View{
    let list: [TestData]
    var body: some View{
        GridRow {
            ForEach(list){ item in
                TView(id: item.id, name: item.name)
            }
        }
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct TView: View {
    var id: String
    var name: String
    
    var body: some View {
        HStack{
            Text(name)
                .lineLimit(1)
                .layoutPriority(1) // Позволяет тексту занимать максимально доступное место
            
            Spacer() // Этот Spacer занимает всё доступное место между текстом и кнопкой
            
            Button(action: {
                print(name + " нужно удалить")
            }) {
                Image(systemName: "trash")
                    .foregroundColor(Color.red)
                    .padding(.trailing, 10.0)
            }
        }
        .padding()
        .background(Color.green)
        .cornerRadius(10)
    }
}







struct TestData: Identifiable {
    var id: String
    var name: String
    
    var nameCount: Int {
        return name.count
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
