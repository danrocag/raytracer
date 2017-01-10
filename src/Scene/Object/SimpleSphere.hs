module Scene.Object.SimpleSphere where
    
import Scene.Base
import Math.Color
import Math.Ray
import Numeric.LinearAlgebra

-- Sphere
sphere :: Double -> Vec3 -> Material -> Scene
sphere r p mat = [sphere' r p mat]

sphere' :: Double -> Vec3 -> Material -> Object
sphere' r p = Object (sphere_intercept r p)

sphere_intercept :: Double -> Vec3 -> Ray -> Maybe (Double, Ray)
sphere_intercept r p ray@(Ray o v) =
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
                x = case (x1 > 0, x2 > 0) of
                    (True,True) -> Just (min x1 x2)
                    (False,True) -> Just x2
                    (True, False) -> Just x1
                    (False, False) -> Nothing

            in (\lambda -> (lambda, Ray (parametric ray lambda) (parametric ray lambda - p))) <$> x
        else Nothing