module Scene.Object.SimpleSphere(sphere) where
    
import Scene.Base
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra

-- Sphere
sphere :: Color -> Double -> Vec3 -> Scene
sphere color r p = [sphere' color r p]

sphere' :: Color -> Double -> Vec3 -> Object
sphere' color r p = Object (sphere_intercept r p) (sphere_calc color r p)

sphere_intercept :: Double -> Vec3 -> Ray -> Double
sphere_intercept r p (Ray o v) =
    let
        o' = o-p
        a = v <.> v
        b = v <.> o'
        c = o' <.> o' - r**2
        discriminant = b**2 - a*c
    in if discriminant > 0
        then
            let
                x1 = (-b + sqrt(discriminant))/a
                x2 = (-b - sqrt(discriminant))/a
            in case (x1 > 0, x2 > 0) of
                (True,True) -> max x1 x2
                (False,True) -> x2
                (True, False) -> x1
                (False, False) -> 1/0
        else 1/0

sphere_calc :: Color -> Double -> Vec3 -> Vec3 -> Tracer -> Tracer
sphere_calc mat r center intersect env (Ray p v) =
    let
        normal = intersect - center
        coeff = (normal <.> v)/(normal <.> normal)
        reflected = v + scale (2*coeff) normal
        forward_light = env (Ray intersect reflected)
    in scaleColor coeff (multiply mat forward_light)