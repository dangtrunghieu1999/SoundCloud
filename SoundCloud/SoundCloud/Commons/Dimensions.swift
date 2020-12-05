//
//  Dimensions.swift
//  SoundCloud
//
//  Created by Dang Trung Hieu on 9/23/20.
//  Copyright © 2020 Dang Trung Hieu. All rights reserved.
//

import UIKit

let dimension = Dimension.shared

class Dimension {
    
    class var shared: Dimension {
        struct Static {
            static var instance = Dimension()
        }
        return Static.instance
    }
    
    var widthScreen: CGFloat = 1.0
    var heightScreen: CGFloat = 1.0
    var widthScale: CGFloat = 1.0
    var heightScale: CGFloat = 1.0
    
    // MARK: - Initialize
    private init() {
        self.widthScreen = UIScreen.main.bounds.width
        self.heightScreen = UIScreen.main.bounds.height
    }
    
    // MARK: - Spacing
    var smallMargin: CGFloat {
        return 5 * self.widthScale
    }
    
    var mediumMargin: CGFloat {
        return 10 * self.widthScale
    }
    
    var normalMargin: CGFloat {
        return 16 * self.widthScale
    }
    
    var largeMargin: CGFloat {
        return 20 * self.widthScale
    }

    var largeMargin_25: CGFloat {
        return 25 * self.widthScale
    }
   
    var largeMargin_50: CGFloat {
        return 50 * self.widthScale
    }
    
    var largeMargin_75: CGFloat {
        return 75 * self.widthScale
    }
    
    var largeMargin_90: CGFloat {
        return 90 * self.widthScale
    }
   
    var largeMargin_120: CGFloat {
        return 120 * self.widthScale
    }
    
    var largeMargin_150: CGFloat {
        return 150 * self.widthScale
    }
    
    // MARK: - Button
    var largeHeightButton: CGFloat {
        return 54 * self.widthScale
    }
    
    var defaultHeightButton: CGFloat {
        return 42 * self.widthScale
    }
    
    var smalltHeightButton: CGFloat {
        return 32 * self.widthScale
    }
    
    var largeWidthButton: CGFloat {
        return 291 * self.widthScale
    }
    
    var smallWidthButton: CGFloat {
        return 120 * self.widthScale
    }
    
    var supperSmallWidthButton: CGFloat {
        return 100 * self.widthScale
    }
    
    var mediumWidthButton: CGFloat {
        return 195 * self.widthScale
    }
    
    //MARK: - Alpha
    
    var smallAlpha: CGFloat {
        return 0.25
    }
    
    var mediumAlpha: CGFloat {
        return 0.5
    }
    
    var largeAlpha: CGFloat {
        return 0.75
    }
    
    // MARK: - Line height
    
    var smallLineHeight: CGFloat {
        return 1 * widthScale
    }
    
    var mediumLineHeight: CGFloat {
        return 2 * widthScale
    }
    
    var normalLineHeight: CGFloat {
        return 3 * widthScale
    }
    
    var largeLineHeight: CGFloat {
        return 4 * widthScale
    }
    
    // MARK: - TextField
    
    var defaultHeightTextField: CGFloat {
        return 40 * heightScale
    }
    
}

