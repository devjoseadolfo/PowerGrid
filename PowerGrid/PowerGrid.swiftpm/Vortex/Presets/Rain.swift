//
// Rain.swift
// Vortex
// https://www.github.com/twostraws/Vortex
// See LICENSE for license information.
//

import SwiftUI

extension VortexSystem {
    /// A built-in rain effect. Relies on a "circle" tag being present.
    public static let rain: VortexSystem = {
        VortexSystem(
            tags: ["circle"],
            position: [0.5, 0 ],
            shape: .box(width: 1.8, height: 0),
            birthRate: 400,
            lifespan: 0.5,
            speed: 4.5,
            speedVariation: 2,
            angle: .degrees(190),
            colors: .random(
                Color(red: 0.8, green: 0.9, blue: 1, opacity: 0.7),
                Color(red: 0.8, green: 0.9, blue: 1, opacity: 0.6),
                Color(red: 0.8, green: 0.9, blue: 1, opacity: 0.5)
            ),
            size: 0.1,
            sizeVariation: 0.05,
            stretchFactor: 12
        )
    }()
    public static let lightRain: VortexSystem = {
        VortexSystem(
            tags: ["circle"],
            position: [0.5, 0 ],
            shape: .box(width: 1.6, height: 0),
            birthRate: 200,
            lifespan: 0.5,
            speed: 3,
            speedVariation: 2,
            angle: .degrees(190),
            colors: .random(
                Color(red: 0.8, green: 0.9, blue: 1, opacity: 0.7),
                Color(red: 0.8, green: 0.8, blue: 1, opacity: 0.6),
                Color(red: 0.8, green: 0.9, blue: 1, opacity: 0.5)
            ),
            size: 0.1,
            sizeVariation: 0.02,
            stretchFactor: 8
        )
    }()
}
