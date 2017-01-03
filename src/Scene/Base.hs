module Scene.Base where
    
import Illumination.Base
import Math.Color
import Math.Ray

import Data.List(sortBy)
import Data.Function

type Scene = [Object]

data Object = Object {
    intercept :: Ray -> Double,
    calc_color :: Vec3 -> Ray -> [CRay] -> Color}

traceRay :: Scene -> Ray -> Illumination -> Maybe Color
traceRay scene ray illum =
    let
        intercepts = map (\o -> (o, intercept o ray)) scene
        candidates = takeWhile ((<1/0) . snd) . dropWhile ((<0) . snd) $ sortBy (compare `on` snd) intercepts
    in case candidates of
        [] -> Nothing
        (obj,k):_ -> let point = (parametric ray k) in Just (calc_color obj point ray (illuminate illum point))