.SILENT:
default: setup

start = printf "\e[32m⚙️ %s...\e[0m\n" $(1)
success = printf "\e[32m✓ %s\e[0m\n" $(1)

setup: \
  log_info \
  install_dependencies \
	decrypt_files \
	generate_project \
	done
	
log_info: 
	[ -f debug.log ] && : > debug.log
	sh Configurations/Make/debug_info.sh

install_dependencies:
	$(call start, "Installing dependencies")
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