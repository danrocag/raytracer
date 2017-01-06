module Main where

import Data.Monoid

import Core
import Render
import Codec.Picture
import Codec.Picture.Types
import Numeric.LinearAlgebra(vector)

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

scene =
    sky white (Ray (vector [10,0,0]) (vector [-1,0,0]))
    <> sphere green 1 (vector [0,0,5])
    <> sky white (Ray (vector [-2,0,0]) (vector [1,0,0]))

main :: IO ()
main = do
    img <- render settings scene
    savePngImage (path settings) img
    
