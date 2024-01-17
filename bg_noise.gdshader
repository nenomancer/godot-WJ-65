shader_type canvas_item;
uniform sampler2D texture_1:repeat_enable;
uniform vec2 noise_offset;
uniform float scroll_speed = 0.05;
uniform float line_thickness:hint_range(0.00, 1.00, 0.01) = 0.01;
uniform float grid_offset_x:hint_range(0.00, 1.00, 0.01);
uniform float grid_offset_y:hint_range(0.00, 1.00, 0.01);
uniform int grid_divisions:hint_range(1, 12, 0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 center = vec2(.5, .5);
	float _i = 1.0;
	float _radius = mod(TIME * 0.2, 1);
	float _distance = distance(center, UV);
	float _distance_2 = distance(center, UV) / 2.0;
	vec4 color_2_place;
	vec4 color_1_place;
	float wavy = (sin(TIME) / 3.0 + .5);
	//wavy = 0.0;
	vec2 new_uv = vec2(UV.r - grid_offset_x + (wavy / (line_thickness * 1000.0)) + line_thickness / 2.0, 
					UV.g + grid_offset_y + (wavy / (line_thickness * 1000.0)) + line_thickness / 2.0);
	vec4 grid_uv = vec4(mod(new_uv, 1.0 / float(grid_divisions)), 1.0, 1.0);
	vec4 grid_x = step(vec4(grid_uv.g), vec4(line_thickness));
	vec4 grid_x_2 = vec4(grid_uv.g);
	vec4 grid_y = step(vec4(grid_uv.r), vec4(line_thickness));
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
	//COLOR = vec4(circle_uv_x + circle_uv_y);
	//COLOR = vec4(offset_uv.r, offset_uv.r, 0.0, 1.0);
	//COLOR = vec4(xx);
	
	//COLOR = step(grid_x_2 + grid_y_2, vec4(line_thickness));
	//COLOR = vec4(new_uv, 1.0, 1.0);
	if (_distance < _radius && _distance > _radius - 0.1 ||
		_distance_2 < _radius && _distance_2 > _radius - 0.1) {
		// COLOR = some color
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
