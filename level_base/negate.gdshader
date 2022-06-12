shader_type canvas_item;

void fragment() {
	COLOR = 1. - texture(SCREEN_TEXTURE,SCREEN_UV);
	COLOR.a = 1.;
}
