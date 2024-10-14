.SILENT:
default: setup

start = printf "⚙️  %s...\n" $(1)
success = printf "\e[32m✓  %s\e[0m\n" $(1)

setup: \
  log_info \
  install_dependencies \
	decrypt_files \
	generate_project \
	done
	
log_info: 
	sh Configurations/Make/debug_info.sh

install_dependencies:
	$(call start, "Installing dependencies")
	sh Configurations/Make/install_dependencies.sh
	$(call success, "Dependencies installed")

decrypt_files:
	$(call start, "Decrypting files")
	sh Configurations/Make/decrypt.sh
	$(call success, "Files decrypted")
  
generate_project:
	set -a && \
	source Configurations/XcodeGen/.xcodegen.env && \
	set +a && \
	xcodegen generate --spec Configurations/XcodeGen/project.yml --project ./ && \
	sh Configurations/Make/install_pod.sh
	$(call success, "Project generated")

done: 
	printf "\e[32m%s\e[0m\n" "✓  All Done ლ(╹◡╹ლ)"