//
//  View+PreviewDevice.swift
//  PreviewDevice
//
//  Created by Anton Paliakou on 8/26/21.
//

import SwiftUI

public extension View {
    func previewDevice(device: Device) -> some View {
        previewDevice(PreviewDevice(rawValue: device.rawValue))
            .previewDisplayName(device.rawValue)
    }

    func previewDevices(devices: [Device]) -> some View {
        ForEach(devices, id: \.self) { device in
            previewDevice(device: device)
        }
    }
}

public extension View {
    func previewDevice(device: Device, colorScheme: ColorScheme) -> some View {
        previewDevice(device: device)
            .preferredColorScheme(colorScheme)
    }

    func previewDevice(device: Device, colorSchemes: [ColorScheme]) -> some View {
        ForEach(0..<colorSchemes.count, id: \.self) { index in
            previewDevice(device: device)
                .preferredColorScheme(colorSchemes[index])
        }
    }
}

@available(iOS 15.0, OSX 12.0, macCatalyst 15.0, tvOS 15.0, watchOS 8.0, *)
public extension View {
    func previewDevice(device: Device, orientation: InterfaceOrientation) -> some View {
        previewDevice(device: device)
            .previewInterfaceOrientation(orientation)
    }

    func previewDevice(device: Device, orientations: [InterfaceOrientation]) -> some View {
        ForEach(0..<orientations.count, id: \.self) { index in
            previewDevice(device: device)
                .previewInterfaceOrientation(orientations[index])
        }
    }

    func previewDevice(device: Device, orientation: InterfaceOrientation, colorSchemes: [ColorScheme]) -> some View {
        ForEach(0..<colorSchemes.count, id: \.self) { index in
            previewDevice(device: device)
                .previewInterfaceOrientation(orientation)
                .preferredColorScheme(colorSchemes[index])
        }
    }
}
