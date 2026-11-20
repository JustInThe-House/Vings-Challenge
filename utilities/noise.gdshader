shader_type canvas_item;

uniform float intensity: hint_range(0.0, 1.0, 0.1) = 0.2;

float random (vec2 uv) {
	return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv_noise = UV * TIME;
	vec4 noise = vec4(random(uv_noise), random(uv_noise), random(uv_noise), 1.0);
	COLOR = mix(COLOR, COLOR * noise, intensity);
}
