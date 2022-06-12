shader_type canvas_item;

uniform vec4 col : hint_color = vec4(1.,0.,0.,1.);

void fragment() {
	COLOR = col;
	COLOR.a *= smoothstep(0.1,0.14,texture(TEXTURE, UV).g);
}