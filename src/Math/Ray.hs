module Math.Ray where
    
import GHC.TypeLits
import Numeric.LinearAlgebra.Static
import qualified Numeric.LinearAlgebra as LA

import Codec.Picture

data Ray = Ray
    {-# UNPACK #-} !(R 3)
    {-# UNPACK #-} !(R 3)
    {-# UNPACK #-} !PixelRGBF
    deriving Show