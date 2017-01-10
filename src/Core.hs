module Core(
    RenderSettings(..),
    module Scene.Base,
    module Scene.Object.Plane,
    module Scene.Material.Diffuse,
    module Scene.Object.SimpleSphere,
    module Math.Color,
    module Math.Ray,
    module Scene.Material.Skylike
    ) where
    
import Scene.Base(Trace, traceRay, Scene, Material)
--import Scene.Object.SimpleSphere(sphere)
import Scene.Object.Plane
import Scene.Object.SimpleSphere
import Scene.Material.Skylike
import Scene.Material.Diffuse
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra
import Scene.Object.Plane
import GHC.Generics (Generic)
import Control.DeepSeq

data RenderSettings  = RenderSettings {
    background :: Color,
    width :: Int,
    height :: Int,
    topLeft :: Vec3,
    topRight :: Vec3,
    bottomRight :: Vec3,
    origin :: Vec3,
    path :: FilePath,
    antialiasing :: Int}