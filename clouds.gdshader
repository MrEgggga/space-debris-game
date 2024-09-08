shader_type canvas_item;

void fragment() {
	float alpha2 = min(UV.y * 5.0, 1.0);
	vec4 usualColor = texture(TEXTURE, UV);
	COLOR = vec4(usualColor.rgb, usualColor.a * alpha2);
}