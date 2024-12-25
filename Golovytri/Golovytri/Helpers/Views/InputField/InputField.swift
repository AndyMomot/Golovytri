import SwiftUI

struct InputField: View {
    var title: String
    var titleColor: Color = .darkBlue
    var textColor: Color = .darkBlue
    var placeholder: String?
    @Binding var text: String
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundStyle(titleColor)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            HStack {
                TextField(text: $text) {
                    if let placeholder {
                        Text(placeholder)
                            .foregroundStyle(textColor.opacity(0.5))
                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                    }
                }
                .focused($isInputActive)
                .foregroundStyle(textColor)
                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
                .padding(.leading, 16)
                .padding(.vertical, 18)
                
                Button {
                    withAnimation {
                        isInputActive.toggle()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(textColor)
                        .padding()
                }
                .hidden(!isInputActive)
            }
            .background(.white)
            .cornerRadius(8, corners: .allCorners)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.darkBlue, lineWidth: 1)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        InputField(title: "Nazwa towaru", text: .constant(""))
            .padding(.horizontal)
    }
}
