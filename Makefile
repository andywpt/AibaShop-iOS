.SILENT:
default: setup

start = printf "\e[36m⚙️ %s...\e[0m\n" $(1)
success = printf "\e[32m✓ %s\e[0m\n" $(1)

setup: \
  log_info \
  install_packages \
	decrypt_files \
	generate_project \
	done
	
log_info: 
	[ -f debug.log ] && > debug.log || true
	sh Configurations/Make/build_info.sh

install_packages:
	$(call start, "Installing packages")
	sh Configurations/Make/install_dependencies.sh

decrypt_files:
	$(call start, "Decrypting files")
	sh Configurations/Make/decrypt.sh
  
generate_project:
	$(call start, "Generating project")
	set -a && \
	source Configurations/XcodeGen/.xcodegen.env && \
	set +a && \
	xcodegen generate --quiet --spec Configurations/XcodeGen/project.yml --project ./ && \
	$(call start, "Installing pods") && \
	sh Configurations/Make/install_pod.sh

done: 
	$(call success, "All Done ლ(╹◡╹ლ)")