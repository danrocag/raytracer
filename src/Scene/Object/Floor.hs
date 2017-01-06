module Scene.Object.Floor(floor_obj) where
    
import Scene.Base
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra

-- Sphere
floor' :: Color -> Ray -> Object
floor' color (Ray p normal) = Object (floor_intercept p normal) (floor_calc color p normal)

floor_obj color ray = [floor' color ray]

floor_intercept :: Vec3 -> Vec3 -> Ray -> Double
floor_intercept p normal (Ray q v) =
    let
        v_orth = v <.> normal
        pq_orth = (p-q) <.> normal
        lambda = pq_orth / v_orth
    in if lambda > 0
        then lambda
        else 1/0

floor_calc :: Color -> Vec3 -> Vec3 -> Vec3 -> Tracer -> Tracer
floor_calc mat p normal intersect env (Ray q v) =
    let
        coeff = (normal <.> v)/(normal <.> normal)
        reflected = v - scale (2*coeff) normal
        forward_light = env (Ray intersect reflected)
    in multiply mat forward_light