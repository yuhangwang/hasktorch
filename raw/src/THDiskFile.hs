{-# LANGUAGE ForeignFunctionInterface #-}

module THDiskFile (
    c_THDiskFile_new,
    c_THPipeFile_new,
    c_THDiskFile_name,
    c_THDiskFile_isLittleEndianCPU,
    c_THDiskFile_isBigEndianCPU,
    c_THDiskFile_nativeEndianEncoding,
    c_THDiskFile_littleEndianEncoding,
    c_THDiskFile_bigEndianEncoding,
    c_THDiskFile_longSize,
    c_THDiskFile_noBuffer,
    p_THDiskFile_new,
    p_THPipeFile_new,
    p_THDiskFile_name,
    p_THDiskFile_isLittleEndianCPU,
    p_THDiskFile_isBigEndianCPU,
    p_THDiskFile_nativeEndianEncoding,
    p_THDiskFile_littleEndianEncoding,
    p_THDiskFile_bigEndianEncoding,
    p_THDiskFile_longSize,
    p_THDiskFile_noBuffer) where

import Foreign
import Foreign.C.Types
import THTypes
import Data.Word
import Data.Int

-- |c_THDiskFile_new : name mode isQuiet -> THFile *
foreign import ccall "THDiskFile.h THDiskFile_new"
  c_THDiskFile_new :: Ptr CChar -> Ptr CChar -> CInt -> IO (Ptr CTHFile)

-- |c_THPipeFile_new : name mode isQuiet -> THFile *
foreign import ccall "THDiskFile.h THPipeFile_new"
  c_THPipeFile_new :: Ptr CChar -> Ptr CChar -> CInt -> IO (Ptr CTHFile)

-- |c_THDiskFile_name : self -> char *
foreign import ccall "THDiskFile.h THDiskFile_name"
  c_THDiskFile_name :: Ptr CTHFile -> IO (Ptr CChar)

-- |c_THDiskFile_isLittleEndianCPU :  -> int
foreign import ccall "THDiskFile.h THDiskFile_isLittleEndianCPU"
  c_THDiskFile_isLittleEndianCPU :: CInt

-- |c_THDiskFile_isBigEndianCPU :  -> int
foreign import ccall "THDiskFile.h THDiskFile_isBigEndianCPU"
  c_THDiskFile_isBigEndianCPU :: CInt

-- |c_THDiskFile_nativeEndianEncoding : self -> void
foreign import ccall "THDiskFile.h THDiskFile_nativeEndianEncoding"
  c_THDiskFile_nativeEndianEncoding :: Ptr CTHFile -> IO ()

-- |c_THDiskFile_littleEndianEncoding : self -> void
foreign import ccall "THDiskFile.h THDiskFile_littleEndianEncoding"
  c_THDiskFile_littleEndianEncoding :: Ptr CTHFile -> IO ()

-- |c_THDiskFile_bigEndianEncoding : self -> void
foreign import ccall "THDiskFile.h THDiskFile_bigEndianEncoding"
  c_THDiskFile_bigEndianEncoding :: Ptr CTHFile -> IO ()

-- |c_THDiskFile_longSize : self size -> void
foreign import ccall "THDiskFile.h THDiskFile_longSize"
  c_THDiskFile_longSize :: Ptr CTHFile -> CInt -> IO ()

-- |c_THDiskFile_noBuffer : self -> void
foreign import ccall "THDiskFile.h THDiskFile_noBuffer"
  c_THDiskFile_noBuffer :: Ptr CTHFile -> IO ()

-- |p_THDiskFile_new : Pointer to function : name mode isQuiet -> THFile *
foreign import ccall "THDiskFile.h &THDiskFile_new"
  p_THDiskFile_new :: FunPtr (Ptr CChar -> Ptr CChar -> CInt -> IO (Ptr CTHFile))

-- |p_THPipeFile_new : Pointer to function : name mode isQuiet -> THFile *
foreign import ccall "THDiskFile.h &THPipeFile_new"
  p_THPipeFile_new :: FunPtr (Ptr CChar -> Ptr CChar -> CInt -> IO (Ptr CTHFile))

-- |p_THDiskFile_name : Pointer to function : self -> char *
foreign import ccall "THDiskFile.h &THDiskFile_name"
  p_THDiskFile_name :: FunPtr (Ptr CTHFile -> IO (Ptr CChar))

-- |p_THDiskFile_isLittleEndianCPU : Pointer to function :  -> int
foreign import ccall "THDiskFile.h &THDiskFile_isLittleEndianCPU"
  p_THDiskFile_isLittleEndianCPU :: FunPtr (CInt)

-- |p_THDiskFile_isBigEndianCPU : Pointer to function :  -> int
foreign import ccall "THDiskFile.h &THDiskFile_isBigEndianCPU"
  p_THDiskFile_isBigEndianCPU :: FunPtr (CInt)

-- |p_THDiskFile_nativeEndianEncoding : Pointer to function : self -> void
foreign import ccall "THDiskFile.h &THDiskFile_nativeEndianEncoding"
  p_THDiskFile_nativeEndianEncoding :: FunPtr (Ptr CTHFile -> IO ())

-- |p_THDiskFile_littleEndianEncoding : Pointer to function : self -> void
foreign import ccall "THDiskFile.h &THDiskFile_littleEndianEncoding"
  p_THDiskFile_littleEndianEncoding :: FunPtr (Ptr CTHFile -> IO ())

-- |p_THDiskFile_bigEndianEncoding : Pointer to function : self -> void
foreign import ccall "THDiskFile.h &THDiskFile_bigEndianEncoding"
  p_THDiskFile_bigEndianEncoding :: FunPtr (Ptr CTHFile -> IO ())

-- |p_THDiskFile_longSize : Pointer to function : self size -> void
foreign import ccall "THDiskFile.h &THDiskFile_longSize"
  p_THDiskFile_longSize :: FunPtr (Ptr CTHFile -> CInt -> IO ())

-- |p_THDiskFile_noBuffer : Pointer to function : self -> void
foreign import ccall "THDiskFile.h &THDiskFile_noBuffer"
  p_THDiskFile_noBuffer :: FunPtr (Ptr CTHFile -> IO ())