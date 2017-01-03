module Illumination.Base(Illumination(..), illuminate) where
    
import GHC.TypeLits
import Numeric.LinearAlgebra.Static
import qualified Numeric.LinearAlgebra as LA

import Math.Color
import Math.Ray    

data Illumination
    = Lamp 
        {-# UNPACK #-} !(R 3) Color

illuminate :: Illumination -> R 3 -> [Ray]
illuminate () _ = []