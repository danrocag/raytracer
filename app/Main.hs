module Main where

import Core
import Render
import Codec.Picture
import Codec.Picture.Types

settings :: RenderSettings
settings = RenderSettings {
    color = PixelRGBF 1 1 1,
    width = 100,
    height = 100,
    path = "out.png"}

illumination

main :: IO ()
main = do
    img <- render settings () ()
    savePngImage (path settings) img
    
