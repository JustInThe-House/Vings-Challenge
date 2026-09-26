shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D sprite_texture: source_color, filter_nearest_mipmap;

void vertex() {
	//	move vertex 10 to the right. despite it being out of its "region rect", it still gets shown.
	//VERTEX += vec3(10.0, 0.0, 0.0);
// moving in a circle
	VERTEX += vec3(cos(TIME), sin(TIME), 0.0);
}

void fragment() {
	vec4 color = texture(sprite_texture, UV);
	ALBEDO = vec3(color.r, color.g, color.b);
	ALPHA = color.a;
}
