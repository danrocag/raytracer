module Scene.Illumination.Sky(sky) where
    
import Scene.Base
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra

-- Sphere
sky' :: Color -> Ray -> Object
sky' color (Ray p normal) = Object (sky_intercept p normal) (\_ _ _ -> color)

sky color ray = [sky' color ray]

sky_intercept :: Vec3 -> Vec3 -> Ray -> Double
sky_intercept p normal (Ray q v) =
    let
        v_orth = v <.> normal
        pq_orth = (p-q) <.> normal
        lambda = pq_orth / v_orth
    in if lambda > 0
        then lambda
        else 1/0