/*
rotateTrue 按键
rotateOK 未碰撞，可行
clock
reset
[0:15] randomBlockShape
[0:15] current_block
*/

always@(posedge clock or posedge reset) begin
  if (reset) begin
    current_block <= 16'd0;
  end
  
  else if(rotateOK && rotateTrue) begin //player hits rotate button on keyboard and rotate is OK (no collision)
    current_block[0] <= current_block[12];
    current_block[1] <= current_block[8];
    current_block[2] <= current_block[4];
    current_block[3] <= current_block[0];
    current_block[4] <= current_block[13];
    current_block[5] <= current_block[9];
    current_block[6] <= current_block[5];
    current_block[7] <= current_block[1];
    current_block[8] <= current_block[14];
    current_block[9] <= current_block[10];
    current_block[10] <= current_block[6];
    current_block[11] <= current_block[2];
    current_block[12] <= current_block[15];
    current_block[13] <= current_block[11];
    current_block[14] <= current_block[7];
    current_block[15] <= current_block[3];
  end

  else if(bottomTouch) begin //last square is collided, load a new one
    current_block <= randomBlockShape;
  end

  else begin
   current_block <= current_block; //no new block, no rotate, then we hold the current block
  end
end
