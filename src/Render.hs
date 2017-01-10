module Render(render) where
    
import Core
import Codec.Picture
import Codec.Picture.Types
import Control.Monad
import System.Random
import Control.Monad.Random

import Numeric.LinearAlgebra

deltas :: RenderSettings -> (Vec3, Vec3)
deltas settings  =
    let
        scale_x = 1 / (fromIntegral (width settings) - 1)
        scale_y = 1 / (fromIntegral (height settings) - 1)
        dx = scale scale_x (topRight settings - topLeft settings)
        dy = scale scale_y (bottomRight settings - topRight settings)
    in (dx,dy)

calc_ray :: RenderSettings -> Int -> Int -> Ray
calc_ray settings x y =
    let
        (dx,dy) = deltas settings
        point = topLeft settings + scale (fromIntegral x) dx + scale (fromIntegral y) dy
        dir = point - origin settings
    in (Ray point dir)    


render :: RenderSettings -> Scene -> IO DynamicImage
render settings scene = do
    mut_img <- createMutableImage (width settings) (height settings) (background settings)
    let pixels = [(x,y) | x <- [1..width settings], y <- [1..height settings]]
    let (dx,dy) = deltas settings
    forM_ pixels $ \(x,y) -> do
        let (Ray point dir) = calc_ray settings x y
        colors <- forM [1..antialiasing settings] $ \_ -> do
            kx <- randomRIO (-1,1)
            ky <- randomRIO (-1,1)
            gen <- getStdGen
            let ray' = Ray (point) (dir + scale kx dx + scale ky dy)
            let (color, gen') = runRand (traceRay (background settings) scene ray') gen
            setStdGen gen'
            return $! (1/fromIntegral (antialiasing settings),color)
        writePixel mut_img (x-1) (y-1) (weigh colors)
    img <- unsafeFreezeImage mut_img
    return $! ImageRGBF img

