.SILENT:
default: setup

setup: \
	decrypt_files \
	install_dependencies \
	generate_project \

decrypt_files:
	Configurations/Make/decrypt.sh

install_dependencies:
	Configurations/Make/install_dependencies.sh

generate_project:
	set -a && \
	source Configurations/XcodeGen/.xcodegen.env && \
	set +a && \
	xcodegen generate --spec Configurations/XcodeGen/project.yml --project ./
