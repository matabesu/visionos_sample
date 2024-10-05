//
//  ContentView.swift
//  AppleSamples06
//
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var enlarge = false
    
    var body: some View {
        VStack {
            // Particle entity
            let particleEntity = Entity()
            // Types of particle systems
            let presets: [ParticleEmitterComponent] = [
                .Presets.fireworks,
                .Presets.impact,
                .Presets.sparks,
                .Presets.magic,
                .Presets.rain,
                .Presets.snow
            ]
            // Specify the type of particle system
            let PARTICLE_SYSTEM_TYPE = 3;
            
            
            RealityView { content in
                // Load a local 3D model (usdz format)
                if let scene = try? await Entity(named: "my 3D Object Name", in: realityKitContentBundle) {
                    // Set the scale
                    scene.transform.scale = [1, 1, 1]
                    // Set the rotation
                    let uniformRotate = simd_quatf(angle: .pi / 2, axis: [0, 1, 0])
                    scene.transform.rotation = uniformRotate
                    // Move the 3D object downward
                    scene.position = SIMD3<Float>(0, -0.2, 0)
                    
                    // Set the position of the particle entity
                    particleEntity.transform.translation = SIMD3<Float>(x: 0, y: 0.3, z: 0)
                    // select particle type
                    var particles = presets[PARTICLE_SYSTEM_TYPE]
                    // Set the particle system
                    particleEntity.components[ParticleEmitterComponent.self] = particles
                    // Add as a child to the 3D model
                    scene.addChild(particleEntity)
                    
                    // Add the model to the scene
                    content.add(scene)
                }
            }

        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
