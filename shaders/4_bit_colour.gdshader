shader_type canvas_item;

void fragment() {
	float steps = 16.0;

	COLOR.r = round(COLOR.r * steps) / steps;
	COLOR.g = round(COLOR.g * steps) / steps;
	COLOR.b = round(COLOR.b * steps) / steps;
}
