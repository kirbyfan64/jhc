module Jhc.JumpPoint(JumpPoint(), withJumpPoint__, jumpJumpPoint__) where

import Jhc.IO
import Jhc.Addr

newtype JumpPoint = JumpPoint Addr


-- | in order to be safe, the JumpPoint must not escape the handling function
withJumpPoint__ :: (JumpPoint -> Bool -> IO a) -> IO a
withJumpPoint__ action = do
    p <- _malloc jmp_buf_size
    let jp = (JumpPoint p)
    r <- jhc_setjmp jp
    r <- action jp (r /= 0)
    _free p
    return r

jumpJumpPoint__ :: JumpPoint -> IO a
jumpJumpPoint__ jp = jhc_longjmp  jp >> return (error "jumpJumpPoint__")


foreign import ccall jhc_setjmp :: JumpPoint -> IO Int
foreign import ccall jhc_longjmp :: JumpPoint -> IO ()
foreign import primitive "const.sizeof(jmp_buf)" jmp_buf_size  :: Int
foreign import ccall "malloc.h malloc" _malloc :: Int -> IO Addr
foreign import ccall "malloc.h free" _free :: Addr -> IO ()



