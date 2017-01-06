module Scene.Base where
    
import Math.Color
import Math.Ray

import Data.List(sortBy)
import Data.Function

type Scene = [Object]
type Tracer = Ray -> Color

data Object = Object {
    intercept :: Ray -> Double,
    calc_color :: Vec3 -> Tracer -> Tracer}

traceRay :: Color -> Scene -> Maybe Object -> Tracer
traceRay bgcolor scene old ray =
    let
        intercepts = map (\o -> (o, intercept o ray)) scene
        candidates = takeWhile ((<1/0) . snd) . dropWhile ((<0) . snd) $ sortBy (compare `on` snd) intercepts
    in case candidates of
        [] -> bgcolor
        (obj,k):other_objects_with_k ->
            let
                point = (parametric ray k)
                other_objects = map fst other_objects_with_k
            in (calc_color obj point (traceRay bgcolor (maybe other_objects (:other_objects) old) (Just obj)) ray)