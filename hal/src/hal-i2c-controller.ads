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

package HAL.I2C.Controller is
   pragma Preelaborate;

   type I2C_Controller_Port is interface;

   type Any_I2C_Controller_Port is access all I2C_Controller_Port'Class;

   --  We recommend to provide a procedure named Configure for
   --  initialisation of the I2C port
   --
   --  procedure Configure (This : in out My_Derived_I2C_Port,
   --                       Baudrate : Hertz;
   --                       ...);
   --

   --  Start and Stop Condition
   --
   --  Each I2C command initiated by controller device starts with a START
   --  condition and ends with a STOP condition. For both conditions
   --  SCL has to be high. A high to low transition of SDA is
   --  considered as START and a low to high transition as STOP.

   -- Create I2C start condition.  Send the Data to the device
   -- (target) at I2C_Address through the port This.  The number of
   -- bytes is determined by the length of Data.  Ends with I2C stop
   -- condition if Stop is true.  Success or failure is reported in
   -- Status.
   procedure Transmit
     (This    : in out I2C_Controller_Port;
      Addr    : I2C_7bit_Address;
      Data    : I2C_Data;
      Status  : out I2C_Status;
      Timeout : Natural := 1000;  --  needed?, I haven't seen that in other APIs (except Python)
      Stop    : Boolean := True   --  true: send Stop sequence, release bus after transmission
                                  --  false: do not send Stop sequence, keep bus busy
     ) is abstract;

   procedure Transmit
     (This    : in out I2C_Controller_Port;
      Addr    : I2C_10bit_Address;
      Data    : I2C_Data;
      Status  : out I2C_Status;
      Timeout : Natural := 1000;
      Stop    : Boolean := True) is abstract;

   -- Create I2C start condition.  Receive Data from the device
   -- (target) at I2C_Address through the port This.  The number of
   -- expected bytes is determined by the length of Data.  Ends with
   -- I2C stop condition if Stop is true.  Success or failure is
   -- reported in Status.
   procedure Receive
     (This    : in out I2C_Controller_Port;
      Addr    : I2C_7bit_Address;
      Data    : out I2C_Data;
      Status  : out I2C_Status;
      Timeout : Natural := 1000;
      Stop    : Boolean := True) is abstract;

   procedure Receive
     (This    : in out I2C_Controller_Port;
      Addr    : I2C_10bit_Address;
      Data    : out I2C_Data;
      Status  : out I2C_Status;
      Timeout : Natural := 1000;
      Stop    : Boolean := True) is abstract;

   --  unconditionally send a Stop condition
   procedure Stop
     (This    : in out I2C_Controller_Port) is abstract;

   --
   --  The following routines are not strictly needed but provide
   --  subprograms for typical scenarios and for backwar
   --  compatitibility.
   --

   -- Create I2C start condition.  Send the Send_Data to the device
   -- (target) at I2C_Address through the port This.  The number of
   -- bytes is determined by the length of Send_Data.  Without
   -- intermediate stop request Recv_Data'Length bytes from the same
   -- client.  Ends with I2C stop condition.  Success or failure is
   -- reported in Status.
  procedure Transmit_And_Receive
     (This      : in out I2C_Controller_Port;
      Addr      : I2C_7Bit_Address;
      Send_Data : I2C_Data;
      Recv_Data : out I2C_Data;
      Status    : out I2C_Status;
      Timeout   : Natural := 1000) is abstract;

  procedure Transmit_And_Receive
     (This      : in out I2C_Controller_Port;
      Addr      : I2C_10bit_Address;
      Send_Data : I2C_Data;
      Recv_Data : out I2C_Data;
      Status    : out I2C_Status;
      Timeout   : Natural := 1000) is abstract;


   -- The following routines first send Mem_Addr to the device
   -- (target).  Mem_Addr is either one byte if Mem_Addr_Size =
   -- Memory_Size_8b or two bytes if Mem_Addr_Size = Memory_Size_16b.
   -- In the latter case the upper half of the 16bit value (MSB) is
   -- sent first. The lower half (LSB) is sent as the second byte.

   type I2C_Memory_Address_Size is
     (Memory_Size_8b,   --  send only low byte of Mem_Addr
      Memory_Size_16b); --  first send high byte then low byte of Mem_Addr

   -- Create I2C start condition.  First send Mem_Addr then Data to
   -- the device (target) at I2C_Address through the port This. The
   -- number of bytes is determined by the length of Data.  Ends with
   -- I2C stop condition.  Success or failure is reported in Status.
   procedure Mem_Write
     (This          : in out I2C_Controller_Port;
      Addr          : I2c_7bit_Address;
      Mem_Addr      : UInt16;
      Mem_Addr_Size : I2C_Memory_Address_Size;
      Data          : I2C_Data;
      Status        : out I2C_Status;
      Timeout       : Natural := 1000) is abstract;

   -- Create I2C start condition.  First send Mem_Addr to the device
   -- (target).  Then receive Data from the device. The number of bytes
   -- to be received is determined by the length of Data.  Ends with
   -- I2C stop condition.  Success or failure is reported in Status.
   procedure Mem_Read
     (This          : in out I2C_Controller_Port;
      Addr          : I2c_7bit_Address;
      Mem_Addr      : UInt16;
      Mem_Addr_Size : I2C_Memory_Address_Size;
      Data          : out I2C_Data;
      Status        : out I2C_Status;
      Timeout       : Natural := 1000) is abstract;

end HAL.I2C.Controller;
