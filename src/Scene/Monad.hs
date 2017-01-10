module Scene.Monad where
    
import Math.Ray
import Math.Color

import Control.Monad
import Control.Monad.Trans
import Control.Monad.Random

class Tracer m where
    trace :: Ray -> m Color

newtype TracerT m a = TracerT {runTracerT :: (Ray -> m Color) -> m a} deriving Functor
 
instance Applicative m => Applicative (TracerT m) where
    pure x = TracerT $ \_ -> pure x
    a <*> b = TracerT $ \tracer -> runTracerT a tracer <*> runTracerT b tracer
 
instance Monad m => Monad (TracerT m) where
    m >>= f = TracerT $ \tracer -> runTracerT m tracer >>= (\x -> runTracerT (f x) tracer)

instance MonadTrans TracerT where
    lift m = TracerT $ \_ -> m

instance Tracer (TracerT m) where
    trace ray = TracerT $ \tracer -> tracer ray
    
instance (MonadRandom m) => MonadRandom (TracerT m) where
    getRandom = lift  getRandom
    getRandoms = lift getRandoms
    getRandomR = lift . getRandomR
    getRandomRs = lift . getRandomRs
    