module Illumination.Base(Illumination, illuminate, pointLight) where
    
import Data.Monoid

import Numeric.LinearAlgebra

import Math.Color
import Math.Ray


newtype Illumination = Illumination {illuminate :: Vec3 -> [CRay]}

instance Monoid Illumination where
    mempty = Illumination (const [])
    i1 `mappend` i2 = Illumination $ \v -> illuminate i1 v ++ illuminate i2 v

pointLight :: Color -> Vec3 -> Illumination
pointLight color p1 = Illumination $ \p2 -> [CRay p1 (p2-p1) color]