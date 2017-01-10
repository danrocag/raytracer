module Scene.Object.Plane where
    
import Scene.Base
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra

-- Sphere
plane' :: Material -> Ray -> Object
plane' mat r = Object (plane_intercept r) mat

plane mat ray = [plane' mat ray]

plane_intercept :: Ray -> Ray -> Maybe (Double,Ray)
plane_intercept (Ray p normal) incidence@(Ray q v) =
    let
        v_orth = v <.> normal
        pq_orth = (p-q) <.> normal
        lambda = pq_orth / v_orth
    in if lambda > 0
        then Just (lambda, Ray (parametric incidence lambda) (scale (-signum (v_orth)) normal))
        else Nothing