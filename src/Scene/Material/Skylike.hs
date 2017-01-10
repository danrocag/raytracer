module Scene.Material.Skylike where

import Numeric.LinearAlgebra

import Scene.Base
import Math.Color
import Math.Ray
import Scene.Monad

import Control.Applicative
import Control.Monad.Random

skylike :: Color -> Color -> Material
skylike near far (Ray p normal) (Ray q incidence) = do
    let t = abs $ (normal <.> incidence)/(norm_2 normal * norm_2 incidence)
    return $! weigh [(t,near),(1-t,far)]