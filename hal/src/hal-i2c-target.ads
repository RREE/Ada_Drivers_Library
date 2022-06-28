------------------------------------------------------------------------------
--                                                                          --
--                     Copyright (C) 2022, AdaCore                          --
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

package HAL.I2C.Target is
   pragma Preelaborate;

   type I2C_Target_Port is limited interface;
   type Any_I2C_Target_Port is access all I2C_Target_Port'Class;

   --  The target has to respond to several events.  Typically it must
   --  either read from or write to the bus upon signal from the
   --  controller
   type I2C_Target_Events is (Request,  --  target has to transmit data
                              Receive,  --  target has to receive data
                              Restart); --  target can be reset

   type I2C_Action is access procedure;

   type Event_Action is array (I2C_Target_Events) of I2C_Action;


   procedure Configure
     (This   : in out I2C_Target_Port;
      Addr   : I2C_7bit_Address;
      Action : Event_Action) is abstract;

   procedure Configure
     (This   : in out I2C_Target_Port;
      Addr   : I2C_10bit_Address;
      Action : Event_Action) is abstract;

   --  Send the Data to the requester (controller) through the port This.
   --  The number of bytes is determined by the length of Data.
   --  Success or failure is reported in Status.
   procedure Transmit
     (This   : in out I2C_Target_Port;
      Data   : I2C_Data;
      Status : out I2C_Status) is abstract;

   --  Read Data from the bus (controller) through the port This.  The
   --  number of bytes is determined by the length of Data.  Success
   --  or failure is reported in Status.
   procedure Receive
     (This   : in out I2C_Target_Port;
      Data   : out I2C_Data;
      Status : out I2C_Status) is abstract;

end HAL.I2C.Target;
