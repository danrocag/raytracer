module Core(
    RenderSettings(..),
    module Illumination.Base,
    module Scene.Base,
    module Scene.SimpleSphere,
    module Math.Color,
    module Math.Ray
    ) where
    
import Illumination.Base
import Scene.Base(Scene, traceRay)
import Scene.SimpleSphere(sphere)
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra

data RenderSettings  = RenderSettings {
    background :: Color,
    width :: Int,
    height :: Int,
    topLeft :: Vec3,
    topRight :: Vec3,
    bottomRight :: Vec3,
    origin :: Vec3,
    path :: FilePath}