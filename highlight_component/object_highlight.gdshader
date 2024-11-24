shader_type canvas_item;

uniform vec4 line_color = vec4(1.0, 1.0, 1.0, 0.25);
uniform float line_thickness = 3.0;

const vec2 OFFSETS[8] = {
    vec2(-1, -1), vec2(-1, 0), vec2(-1, 1),
    vec2(0, -1), vec2(0, 1),
    vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
    float outline = 0.0;
    for (int i = 0; i < 8; i++) {
        outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
    }
    outline = min(outline, 1.0);
    vec4 color = texture(TEXTURE, UV);
    COLOR = mix(color, line_color, outline - color.a);
}
