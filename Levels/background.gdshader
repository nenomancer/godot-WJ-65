shader_type canvas_item;
uniform vec2 noise_offset;

group_uniforms grid_setup;
uniform float line_thickness:hint_range(0.00, 1.00, 0.01) = 0.01;
uniform float grid_offset_x:hint_range(0.00, 1.00, 0.01);
uniform float grid_offset_y:hint_range(0.00, 1.00, 0.01);
uniform int grid_divisions_x:hint_range(0, 16, 0.1);
uniform int grid_divisions_y:hint_range(0, 16, 0.1);

group_uniforms grid_animation;
uniform bool is_moving = false;
uniform float scroll_speed_x:hint_range(-0.5, 0.5, 0.01) = 0.00;
uniform float scroll_speed_y:hint_range(-0.5, 0.5, 0.01) = 0.00;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 center = vec2(.5, .5);
	float _i = 1.0;
	float _radius = mod(TIME * 0.2, 1);
	float _distance = distance(center, UV);
	float _distance_2 = distance(center, UV) / 2.0;
	vec4 color_2_place;
	vec4 color_1_place;
	float wavy = 1.0;
	if (is_moving) {
		wavy = (sin(TIME) / 2.0 + .5);
	}
	//wavy = 0.0;
	vec2 new_uv = vec2(UV.r - grid_offset_x + (scroll_speed_x * TIME) + line_thickness / 2.0, 
					UV.g + grid_offset_y + (scroll_speed_y * TIME) + line_thickness / 2.0);
	vec4 grid_uv = vec4(mod(new_uv.x, 1.0 / float(grid_divisions_x)), mod(new_uv.y, 1.0 / float(grid_divisions_y)), 1.0, 1.0);
	vec4 grid_x_2 = vec4(grid_uv.g);
	vec4 grid_y_2 = vec4(grid_uv.r);
	vec4 grid = min(grid_x_2, grid_y_2);
	
	float circle_uv_x = pow(UV.r, 2.0);
	float circle_uv_y = pow(UV.g, 2.0);
	vec2 offset_uv = vec2(UV.r + 0.5, UV.g +0.5);
	
	//offset_uv = pow(offset_uv, vec2(2.0));
	float xx = offset_uv.x - 1.0;
	xx = abs(xx);
	
	
	//COLOR = max(grid_x, grid_y);
	COLOR = step(grid_x_2, grid_y_2); // interesno, ali nebitno za sega
	COLOR = step(grid, vec4(line_thickness * wavy)) * vec4(1.0, 0.5, 0.0, 1.0);
	COLOR = smoothstep(grid, vec4(line_thickness * wavy), vec4(0.02)) * vec4(UV, 0.0, 1.0);
	COLOR = vec4(1.0, 0.0, 0.0, 1.0) + step(grid, vec4(line_thickness)) * vec4(0.0, 1.0, 0.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
