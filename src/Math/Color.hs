module Math.Color(PixelRGBF(..), module Math.Color) where

import Codec.Picture.Types(PixelRGBF(..))
import GHC.Float

type Color = PixelRGBF
red, green, blue :: Color -> Float
red (PixelRGBF r g b) = r
green (PixelRGBF r g b) = g
blue (PixelRGBF r g b) = b
{-# INLINE red #-}
{-# INLINE green #-}
{-# INLINE blue #-}

scaleColor :: Double -> Color -> Color
scaleColor k (PixelRGBF r g b) = PixelRGBF (k'*r) (k'*g) (k'*b)
    where
        k' = double2Float k
{-# INLINE scaleColor #-}

mix :: [Color] -> Color
mix colors = PixelRGBF r' g' b'
    where
        r' = min 1 (sum (fmap red colors))
        g' = min 1 (sum (fmap green colors))
        b' = min 1 (sum (fmap blue colors))