shader_type spatial;

uniform float outside_time;
void vertex() {
	// Called for every vertex the material is visible on.
}
void fragment() {
	//if (time < 3) {
		//
	//}
	if (outside_time <= 2.0){
		ALBEDO = vec3(255.0 - outside_time/2.0 * 255.0, 3.0 - outside_time/2.0 * 3.0, 0.0);
		ALPHA = 1.0 - outside_time/2.0 * 0.5;
	}
	else {
		ALBEDO = vec3(0.0, 0.0, 0.0);
		ALPHA = 0.0;
	}
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
