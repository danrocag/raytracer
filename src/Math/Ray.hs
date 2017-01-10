module Math.Ray where
    
import Numeric.LinearAlgebra

import Codec.Picture

type Vec3 = Vector Double
vec3 :: Double -> Double -> Double -> Vec3
vec3 x y z= vector $! [x,y,z]


data Ray = Ray
    {-# UNPACK #-} !Vec3
    {-# UNPACK #-} !Vec3
    deriving Show

parametric :: Ray -> (Double -> Vec3)
parametric (Ray p v) k = p + scale k v
{-# INLINE parametric #-}