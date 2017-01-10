module Main where

import Data.Monoid

import Core
import Render
import Codec.Picture
import Codec.Picture.Types
import Numeric.LinearAlgebra(vector)

settings :: RenderSettings
settings = RenderSettings {
    background = PixelRGBF 1 1 1,
    width = 800,
    height = 800,
    path = "out.png",
    topLeft = vector [1,1,0],
    topRight = vector [1,-1,0],
    bottomRight = vector [-1, -1,0],
    origin = vector [0,0,-1],
    antialiasing = 10}

scene
    = plane (diffuse (scaleColor 0.5)) (Ray (vec3 (-2) 0 0) (vec3 (-2) 0 0))
    <> sphere 0.9 (vec3 0 0 2) (diffuse (scaleColor 0.5))
    <> plane (skylike white blue) (Ray (vec3 10 0 0) (vec3 1 0 0))

main :: IO ()
main = do
    img <- render settings scene
    savePngImage (path settings) img
    
