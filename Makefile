.SILENT:
default: setup

setup: \
  log_info \
  install_dependencies \
	decrypt_files \
	generate_project

log_info: 
	Configurations/Make/debug_info.sh

install_dependencies:
	Configurations/Make/install_dependencies.sh

decrypt_files:
	Configurations/Make/decrypt.sh

generate_project:
	set -a && \
	source Configurations/XcodeGen/.xcodegen.env && \
	set +a && \
	xcodegen generate --spec Configurations/XcodeGen/project.yml --project ./
