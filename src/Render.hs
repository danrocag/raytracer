module Render(render) where
    
import Core
import Codec.Picture
import Codec.Picture.Types
import Control.Monad
import Control.Monad.IO.Class
import Control.Monad.Par.IO
import Control.Monad.Par.Class

import Numeric.LinearAlgebra

calc_ray :: RenderSettings -> Int -> Int -> Ray
calc_ray settings x y =
    let
        scale_x = fromIntegral x / (fromIntegral (width settings) - 1)
        scale_y = fromIntegral y / (fromIntegral (height settings) - 1)
        v_x = scale scale_x (topRight settings - topLeft settings)
        v_y = scale scale_y (bottomRight settings - topRight settings)
        point = topLeft settings + v_x + v_y
        dir = point - origin settings
    in (Ray point dir)

render :: RenderSettings -> Scene -> IO DynamicImage
render settings scene = do
    mut_img <- createMutableImage (width settings) (height settings) (background settings)
    let pixels = [(x,y) | x <- [1..width settings], y <- [1..height settings]]
    forM_ pixels $ \(x,y) -> do
        let ray = calc_ray settings x y
        writePixel mut_img (x-1) (y-1) (traceRay (background settings) scene Nothing ray)
    img <- unsafeFreezeImage mut_img
    return $! ImageRGBF img

