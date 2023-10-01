
feature_template:
	mason make feature_template -c bricks_configs/feature.json -o lib/presentation/src
	dart run build_runner build  --delete-conflicting-outputs
	