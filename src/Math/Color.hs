module Math.Color(PixelRGBF(..), module Math.Color) where

import Codec.Picture.Types(PixelRGBF(..))
import GHC.Float

import Data.Foldable
            
type Color = PixelRGBF
getRed, getGreen, getBlue :: Color -> Float
getRed (PixelRGBF r g b) = r
getGreen (PixelRGBF r g b) = g
getBlue (PixelRGBF r g b) = b
{-# INLINE getRed #-}
{-# INLINE getGreen #-}
{-# INLINE getBlue #-}

scaleColor :: Double -> Color -> Color
scaleColor k (PixelRGBF r g b) = PixelRGBF (k'*r) (k'*g) (k'*b)
    where
        k' = double2Float k
{-# INLINE scaleColor #-}

mix :: (Functor f, Foldable f) => f Color -> Color
mix colors = PixelRGBF r' g' b'
    where
        r' = min 1 (sum (fmap getRed colors))
        g' = min 1 (sum (fmap getGreen colors))
        b' = min 1 (sum (fmap getBlue colors))

weigh :: (Functor f, Foldable f) => f (Double,Color) -> Color
weigh = mix . fmap (\(w,c) -> scaleColor w c)

multiply :: Color -> Color -> Color
multiply c1 c2 = PixelRGBF r' g' b'
    where
        r' = getRed c1 * getRed c2
        g' = getGreen c1 * getGreen c2
        b' = getBlue c1 * getBlue c2
{-# INLINE multiply #-}

red, green, blue, white, black :: Color
red = PixelRGBF 1 0 0
green = PixelRGBF 0 1 0
blue = PixelRGBF 0 0 1
white = PixelRGBF 1 1 1
black = PixelRGBF 0 0 0