shader_type canvas_item;

uniform sampler2D noise_1:repeat_enable;
uniform sampler2D noise_2:repeat_enable;
uniform vec3 color;
uniform float distortion_strength = 0.2;

uniform vec2 scroll_1 = vec2(0.05, 0.05);
uniform vec2 scroll_2 = vec2(-0.05, -0.05);
void vertex() {
	// Called for severy vertex the material is visible on.

	
}

void fragment() {
	// Called for every pixel the material is visible on.
	//noise_1
	float depth = texture(noise_1,UV + scroll_1 * TIME).r
				* texture(noise_2, UV + scroll_2 * TIME).r;
	vec4 noise_col = texture(noise_1, UV + distortion_strength * vec2(depth));
	COLOR = noise_col * vec4(color, 1);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
