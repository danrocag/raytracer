module Scene.Material.Diffuse where

import Numeric.LinearAlgebra

import Scene.Base
import Math.Color
import Math.Ray
import Scene.Monad

import Control.Applicative
import Control.Monad.Random

doWhileM :: Monad m => (a -> Bool) -> m a -> m a
doWhileM cond prog = prog >>= (\x -> if cond x then return x else doWhileM cond prog)

diffuse :: (Color -> Color) -> Material
diffuse absorb (Ray p normal) (Ray q incidence) = do
    s_unit <- doWhileM (\s -> s <.> s < 1) $ vec3 <$> getRandomR (-1,1) <*> getRandomR (-1,1) <*> getRandomR (-1,1)
    let s = scale (norm_2 normal) s_unit + normal
    ahead <- trace (Ray p s)
    return $! absorb ahead