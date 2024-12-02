//
//  PetDetailView.swift
//  Skrispi_VetHere
//
//  Created by Christian Gunawan on 21/11/24.
//


import SwiftUI
struct PetDetailView: View {
    var pet: PetModel
    
    var body: some View {
            VStack {
                if let imageURL = URL(string: pet.image ?? "") {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
            }
      
                Text(pet.name)
                    .font(.largeTitle).fontWeight(.bold).padding(.bottom)
                VStack{
                    HStack(alignment: .center) {
                        Image(systemName: "scalemass.fill").foregroundColor(Color.black) .font(.system(size: 12))
                        Text("\(pet.weight, specifier: "%.1f") kg") .font(.system(size: 12))
                        Text("•")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        
                        Image(systemName: "pawprint.circle.fill") .font(.system(size: 12))
                        Text("Jenis Peliharaan") .font(.system(size: 12))
                        
                    }
                    HStack{
                        Image(systemName: "calendar") .font(.system(size: 12))
                        Text("\(pet.dob, formatter: dateFormatter)") .font(.system(size: 12))
                        Text("•")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Image(systemName: "cube.transparent.fill") .font(.system(size: 12))
                        Text("Breed") .font(.system(size: 12))
                        Text("•")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Image(systemName: "paintpalette.fill") .font(.system(size: 12))
                        Text("\(pet.color)") .font(.system(size: 12))
                    }
                }.padding(.bottom)
            List{
                    Section {
                        HStack{
                            VStack(alignment:.leading){
                                Text("Name Vaksin - Nama Klinik")
                                Text("dd/mm/yyyy hh:mm")
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                            
                        }
                        
                    } header: {
                        
                        Text("vaksin")
                    }
                
                Section {
                    HStack{
                        VStack(alignment:.leading){
                            Text("Tindakan - Nama Klinik")
                            Text("dd/mm/yyyy hh:mm")
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                        
                    }
                    
                } header: {
                    
                    Text("Rekam Medis")
                }
                
            }
        
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

#Preview {
    PetDetailView(pet: PetModel(id: UUID(), userId: UUID(), petTypeId: UUID(), medicalRecordId: UUID(), breedId: UUID(), image: "https://i.pinimg.com/564x/a5/84/4a/a5844adc64f7d1005f71d4e055b7d465.jpg", name: "Ucok", color: "green", dob: Date.now, createdAt: Date.now, updatedAt: Date.now, weight: 10))
}
