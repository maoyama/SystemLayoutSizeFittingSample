//
//  SampleCell.swift
//  SystemLayoutSizeFittingSample
//
//  Created by Makoto Aoyama on 2020/06/25.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import UIKit
import SwiftUI

class SampleCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

    private static var layoutCell: SampleCell = {
        UINib(nibName: "SampleCell", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! SampleCell
    }()

    static func fittingSize(from model: String, with containerWidth: CGFloat) -> CGSize {
        layoutCell.label.text = model
        layoutCell.frame.size = CGSize(width: containerWidth, height: .greatestFiniteMagnitude)
        layoutCell.setNeedsLayout()
        layoutCell.layoutIfNeeded()
        return layoutCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

struct SampleCell_Previews: PreviewProvider {
    static var model = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    static var previews: some View {
        let cell = UINib(nibName: "SampleCell", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! SampleCell
        cell.label.text = model
        let view = Wrap(uiView: cell)
        return view
            .previewLayout(
                .fixed(
                    width: 320,
                    height: SampleCell.fittingSize(from: model, with: 320).height
                )
            )
    }
}

struct Wrap<T: UIView>: UIViewRepresentable {
    var uiView: T
    func makeUIView(context: Context) -> T { uiView }
    func updateUIView(_ view: T, context: Context) {}
}
