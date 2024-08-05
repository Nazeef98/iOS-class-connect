import SwiftUI
import MapKit

struct UserDetail: View {
    var profile: Profile
    
    var body: some View {
        VStack {
            Map(initialPosition: .region(region))
                .frame(height: 200)
                .cornerRadius(15)
                .padding()
                .overlay {
                    Rectangle().stroke(Color.white, lineWidth: 5)
                        .padding()
                }
            
            HStack {
                Image("User")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Color.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .offset(y: -90)
                    .padding(.bottom, -60)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.name ?? "N/A")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Group {
                    HStack{
                        Label(profile.phone ?? "N/A", systemImage: "phone.fill")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Label("Accommodation", systemImage: profile.accommodation ?? false ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .font(.subheadline)
                            .foregroundColor(profile.accommodation ?? false ? .green : .red)
                    }
                    Label(profile.email ?? "N/A", systemImage: "envelope.fill")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Label(profile.address ?? "N/A", systemImage: "house.fill")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Label(profile.city ?? "N/A", systemImage: "building.2.fill")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Label(profile.state ?? "N/A", systemImage: "map.fill")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Label(profile.zip ?? "N/A", systemImage: "mailbox.fill")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Spacer()
                        Label(profile.country ?? "N/A", systemImage: "globe")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
            
            Spacer()
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .blue.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}


#Preview {
    UserDetail(profile: Profile(
        createdAt: 123,
        updatedAt: 123,
        id: "123",
        name: "Nazeef Ahmad",
        phone: "9898989898",
        email: "nazeef@gmail.com",
        address: "Bestech business tower",
        city: "Mohali",
        state: "Punjab",
        zip: "143516",
        country: "India",
        accommodation: true,
        courseCode: "ACPT",
        user: "123"
    ))
}
