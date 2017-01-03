module Main where

import Data.Monoid

import Core
import Render
import Codec.Picture
import Codec.Picture.Types
import Numeric.LinearAlgebra

settings :: RenderSettings
settings = RenderSettings {
    background = PixelRGBF 0 0 0,
    width = 800,
    height = 800,
    path = "out.png",
    topLeft = vector [1,1,0],
    topRight = vector [1,-1,0],
    bottomRight = vector [-1, -1,0],
    origin = vector [0,0,-1]}

illumination :: Illumination
illumination = pointLight (PixelRGBF 1 1 1) (vector [5,0,0])

scene :: Scene
scene = sphere (PixelRGBF 0 1 0) 1 (vector [0,0,3])

main :: IO ()
main = do
    img <- render settings illumination scene
    savePngImage (path settings) img
    
