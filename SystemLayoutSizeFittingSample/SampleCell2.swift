//
//  SampleCell2.swift
//  SystemLayoutSizeFittingSample
//
//  Created by Makoto Aoyama on 2020/06/30.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import UIKit
import SwiftUI

class SampleCell2: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!

    private static var layoutCell: SampleCell2 = {
        UINib(nibName: "SampleCell2", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! SampleCell2
    }()

    static func fittingSize(from model: String, with containerWidth: CGFloat) -> CGSize {
        layoutCell.label.text = model
        layoutCell.frame.size = CGSize(width: containerWidth, height: .greatestFiniteMagnitude)
        layoutCell.setNeedsLayout()
        layoutCell.layoutIfNeeded()
//        return layoutCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return layoutCell.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
    }
}

struct SampleCell2_Previews: PreviewProvider {
    static var model = "Lorem ipsum"

    static var previews: some View {
        let cell = UINib(nibName: "SampleCell2", bundle: nil)
            .instantiate(withOwner: nil, options: nil)[0] as! SampleCell2
        cell.label.text = model
        let view = Wrap(uiView: cell)
        return view
            .previewLayout(
                .fixed(
                    width: 320,
                    height: SampleCell2.fittingSize(from: model, with: 320).height
                )
            )
    }
}
