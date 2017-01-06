module Core(
    RenderSettings(..),
    module Scene.Base,
    module Scene.Object.SimpleSphere,
    module Scene.Illumination.Sky,
    module Scene.Object.Floor,
    module Math.Color,
    module Math.Ray
    ) where
    
import Scene.Base(Tracer, traceRay, Scene)
import Scene.Object.SimpleSphere(sphere)
import Scene.Illumination.Sky(sky)
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra
import Scene.Object.Floor

data RenderSettings  = RenderSettings {
    background :: Color,
    width :: Int,
    height :: Int,
    topLeft :: Vec3,
    topRight :: Vec3,
    bottomRight :: Vec3,
    origin :: Vec3,
    path :: FilePath}