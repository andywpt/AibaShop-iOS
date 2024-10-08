.SILENT:
default: setup

setup: \
  install_dependencies \
	decrypt_files \
	generate_project

install_dependencies:
	bundle install
	Configurations/Make/install_dependencies.sh

decrypt_files:
	Configurations/Make/decrypt.sh

generate_project:
	set -a && \
	source Configurations/XcodeGen/.xcodegen.env && \
	set +a && \
	xcodegen generate --spec Configurations/XcodeGen/project.yml --project ./
