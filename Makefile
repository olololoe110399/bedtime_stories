
feature_template:
	mason make feature_template -c bricks_configs/feature.json -o lib/presentation/src
	dart run build_runner build  --delete-conflicting-outputs
	
sync:
	flutter pub get
	dart run build_runner build  --delete-conflicting-outputs
	dart run intl_utils:generate

wr:
	dart run build_runner watch  --delete-conflicting-outputs

update_app_icon:
	dart run flutter_launcher_icons:main -f app_icon/app-icon.yaml

update_splash:
	dart run flutter_native_splash:create --path=splash/splash.yaml

remove_splash:
	dart run flutter_native_splash:remove --path=splash/splash.yaml