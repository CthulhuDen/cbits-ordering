{-# LANGUAGE ForeignFunctionInterface #-}

module Lib where

import Foreign
import Foreign.C.String

#include <a_dependent.h>

{# fun pure unsafe greeting {} -> `String' #}

data StrStruct = StrStruct String

{# pointer *strStruct as StrStructPtr -> StrStruct #}

instance Storable StrStruct where
  sizeOf _ = {# sizeof strStruct #}
  alignment _ = {# alignof strStruct #}
  poke ptr (StrStruct str) = newCString str >>= {# set strStruct->str #} ptr
  peek ptr = StrStruct <$> ({#get strStruct->str #} ptr >>= peekCString)

{# fun unsafe greet {with* %`StrStruct'} -> `()' #}
