module Render where
    
import Core
import Codec.Picture
import Codec.Picture.Types
    
render :: RenderSettings -> Illumination -> Scene -> IO DynamicImage
render settings () () = do
    mut_img <- createMutableImage (width settings) (height settings) (color settings)
    img <- unsafeFreezeImage mut_img
    return $! ImageRGBF img

