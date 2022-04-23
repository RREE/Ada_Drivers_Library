------------------------------------------------------------------------------
--                                                                          --
--                     Copyright (C) 2015-2016, 2022, AdaCore               --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

package HAL.I2C is
   pragma Preelaborate;

   type I2C_Status is
     (Ok,
      Error,
      Timeout,
      No_Connection,
      Busy);

   subtype I2C_Data is UInt8_Array;

   -- 7 and 10-bit addressess are distinct types
   subtype I2C_7bit_Address is UInt7 range 8 .. 16#77#;

   -- 8-bit addresses are actually 7-bit addresses shifted by 1 bit
   subtype I2C_8bit_Address is Uint8 range 16#10# .. 16#EE#;

   subtype I2C_10bit_Address is UInt10;

   subtype I2C_Address is I2C_8Bit_Address;
   -- for backward compatibility to hal-0.3.0

   --
   --  Communication
   --
   --  Each slave device on the bus should have a unique address. The
   --  communication starts with the Start condition, followed by the
   --  7-bit slave address and the data direction bit. If this bit is
   --  0 then the master will write to the slave device. Otherwise, if
   --  the data direction bit is 1, the master will read from slave
   --  device. After the slave address and the data direction is sent,
   --  the master can continue with reading or writing. The
   --  communication is ended with the Stop condition which also
   --  signals that the I2C bus is free. If the master needs to
   --  communicate with other slaves it can generate a repeated start
   --  with another slave address without generation Stop condition.
   --
   --  All the bytes are transferred with the MSB bit shifted first.

   --  Explanations are from https://i2c.info/i2c-bus-specification

end HAL.I2C;
