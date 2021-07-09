/// @desc
function TilePosToScreen(){
	
var xx = argument[0];
var yy = argument[1];
	
var draw_x = (xx - yy) * (isom_width / 2);
var draw_y = (xx + yy) * (isom_height / 2);
	
return [draw_x, draw_y];

}