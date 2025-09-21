{ pkgs, ... }: {
	# https://developers.google.com/idx/guides/customize-idx-env
	channel = "stable-20240207"; # Or "unstable"
	packages = [
		pkgs.flutter.withPackages (ps: with ps; [
			# For more details on the Flutter packages, see
			# https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/development/flutter/packages.nix
		])
	];

	# A list of ports to expose
	# You can also set "onAutoForward" to "openPreview" or "openBrowser"
	ports = {
		# "8080" = {
		# 	onAutoForward = "openPreview";
		# };
	};
	# Processes to start on boot
	# You can also configure a pre-start command
	processes = {
		# "Start API" = {
		# 	command = "npm run start";
		# 	pre-start = "npm install";
		# };
	};
	# Enable previews
	previews = {
		enable = true;
		previews = {
			web = {
				command = [
					"flutter"
					"run"
					"-d"
					"web-server"
					"--port"
					"$PORT"
					"--web-hostname"
					"0.0.0.0"
				];
				manager = "web";
			};
			# android = {
			# 	command = ["flutter" "run" "-d" "android-emulator" "--host" "0.0.0.0"];
			# 	manager = "android";
			# };
		};
	};
}
