module Core(RenderSettings(..), Illumination, Scene, PixelRGBF(..)) where
    
import Illumination.Base
import Scene.Base
import Math.Color

data RenderSettings  = RenderSettings {
    color :: Color,
    width :: Int,
    height :: Int,
    path :: FilePath}