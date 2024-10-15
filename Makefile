.SILENT:
default: setup

SCRIPTS_DIR = Configurations/Make
XCODEGEN_DIR = Configurations/XcodeGen
start = printf "\e[36m⚙️ %s...\e[0m\n" $(1)
success = printf "\e[32m✓ %s\e[0m\n" $(1)

setup: \
  log_info \
  install_packages \
	decrypt_files \
	generate_project \
	install_pod \
	done
	
log_info: 
	[ -f debug.log ] && > debug.log || true 
	sh $(SCRIPTS_DIR)/build_info.sh

install_packages:
	$(call start, "Installing packages")
	sh $(SCRIPTS_DIR)/install_dependencies.sh

decrypt_files:
	$(call start, "Decrypting files")
	sh $(SCRIPTS_DIR)/decrypt.sh
  
generate_project:
	$(call start, "Generating project")
	set -a && . $(XCODEGEN_DIR)/.xcodegen.env && set +a && \
	xcodegen generate --spec $(XCODEGEN_DIR)/project.yml --project ./ --quiet 

install_pod:
	$(call start, "Installing pods")
	set -a && . $(XCODEGEN_DIR)/.xcodegen.env && set +a && \
	sh $(SCRIPTS_DIR)/install_pod.sh

done:
	$(call success, "All Done ლ(╹◡╹ლ)")