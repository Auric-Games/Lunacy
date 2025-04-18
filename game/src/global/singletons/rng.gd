extends Node

func bell_curve(min: int, max: int, samples: int = 6) -> int:
	var total := 0.0
	for i in range(samples):
		total += randf()
	var avg := total / samples  # value from 0 to 1, bell-ish shaped
	return int(min + avg * (max - min))