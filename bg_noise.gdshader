shader_type canvas_item;
uniform sampler2D texture_1:repeat_enable;
uniform vec2 noise_offset;
uniform float scroll_speed = 0.05;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixel_color = texture(TEXTURE,UV);
	vec4 pixel_color_2 = texture(texture_1, UV + noise_offset + TIME * scroll_speed);
	vec2 new_uv = UV;
	vec4 new_color = vec4(new_uv, 0, 1);
	vec2 center = vec2(.5, .5);
	float radius = mod(TIME, 0.5);
	float _distance = distance(center, UV);
	if (_distance <  0.5 && _distance > 0.4) {
		COLOR = new_color;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
