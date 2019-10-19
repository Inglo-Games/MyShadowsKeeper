shader_type canvas_item;

uniform float tile_factor = 0.5;

uniform sampler2D uv_offset_texture : hint_black;
uniform vec2 uv_offset_size = vec2(0.3, 0.3);
uniform vec2 wave_size = vec2(0.015, 0.03);
uniform vec2 time_scale = vec2(0.03, 0.05);

void fragment() {
	
	if (SCREEN_UV.y < 0.5) {
		vec2 base_uv_offset = SCREEN_UV * uv_offset_size;
		base_uv_offset += TIME * time_scale;
		
		vec2 texture_based_offset = texture(uv_offset_texture, base_uv_offset).rg;
		texture_based_offset = texture_based_offset * 2.0 - 1.0;
		texture_based_offset *= wave_size;
		
		vec2 adjusted_uv = SCREEN_UV * tile_factor;
		
		COLOR = texture(SCREEN_TEXTURE, adjusted_uv + texture_based_offset);
	} else {
		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV)
	}
}