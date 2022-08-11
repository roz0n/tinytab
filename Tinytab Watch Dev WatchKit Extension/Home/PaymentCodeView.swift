//
//  PaymentCodeView.swift
//  Tinytab Watch Dev WatchKit Extension
//
//  Created by Arnaldo Rozon on 8/10/22.
//

import SwiftUI
import EFQRCode

struct PaymentCodeView: View {
  
  let qrCode: UIImage? = {
    if let image = EFQRCode.generate(for: "https://sandbox.square.link/u/VVIYwNG8",
                                     watermark: nil,
                                     iconSize: EFIntSize(size: CGSize(width: 100, height: 100))) {
      return UIImage(cgImage: image)
    } else {
      return nil
    }
  }()
  
  var body: some View {
    GeometryReader { geo in
      VStack {
        if let qrCode = qrCode {
          Image(uiImage: qrCode)
            .resizable()
            .scaledToFit()
        } else {
          Text("QRCode generation failed")
        }
      }
      .padding()
      .frame(width: geo.size.width,
             height: geo.size.height,
             alignment: .center)
    }
  }
}

struct PaymentCodeView_Previews: PreviewProvider {
  static var previews: some View {
    PaymentCodeView()
  }
}
