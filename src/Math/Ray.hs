module Math.Ray where
    
import Numeric.LinearAlgebra

import Codec.Picture

type Vec3 = Vector Double

data CRay = CRay
    {-# UNPACK #-} !Vec3
    {-# UNPACK #-} !Vec3
    {-# UNPACK #-} !PixelRGBF
    deriving Show

data Ray = Ray
    {-# UNPACK #-} !Vec3
    {-# UNPACK #-} !Vec3
    deriving Show

parametric :: Ray -> (Double -> Vec3)
parametric (Ray p v) k = p + scale k v
{-# INLINE parametric #-}