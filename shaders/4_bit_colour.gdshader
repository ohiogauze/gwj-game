shader_type canvas_item;

void fragment() {
	float steps = 16.0;

	COLOR.r = round(COLOR.r * 12.0) / 12.0;
	COLOR.g = round(COLOR.g * 20.0) / 20.0;
	COLOR.b = round(COLOR.b * steps) / steps;
}
