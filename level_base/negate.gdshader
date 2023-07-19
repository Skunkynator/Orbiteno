shader_type canvas_item;

uniform sampler2D screen : hint_screen_texture;

void fragment() {
	COLOR = COLOR - texture(screen,SCREEN_UV);
	COLOR.a = 1.;
}
