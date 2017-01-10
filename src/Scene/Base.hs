module Scene.Base where
    
import Scene.Monad    

import Math.Color
import Math.Ray

import Data.List(sortBy)
import Data.Function

import Control.Monad.Random
import System.Random
import Control.Monad.Trans
import Data.Maybe(mapMaybe)

type Trace = TracerT (Rand StdGen)

type Scene = [Object]

data Object = Object {
    intercept :: Ray -> Maybe (Double, Ray),
    calc :: Material}

instance Show Object where
    show _ = "(obj)"
    
type Material = Ray -> Ray -> Trace Color

traceRay :: Color -> Scene -> Ray -> Rand StdGen Color
traceRay bgcolor scene ray =
    let
        intercepts :: [(Double,(Object,Ray))]
        intercepts = mapMaybe (\o -> (\(k,r) -> (k,(o,r))) <$> (intercept o ray)) scene
        candidates :: [(Double,(Object,Ray))]
        candidates = (sortBy (compare `on` fst) intercepts)
    in case candidates of
        [] -> return bgcolor
        (_,(obj,normal)):other_objects_with_extra_data -> let other_objects = map (fst . snd) other_objects_with_extra_data in
            runTracerT
                (calc obj normal ray)
                (traceRay bgcolor scene)
--}