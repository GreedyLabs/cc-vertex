#!/bin/sh

VERSION=dev

# ANSI color codes
BOLD='\033[1m'
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RESET='\033[0m'

# Check for version flag
if [ "$1" = "-v" ] || [ "$1" = "--version" ]; then
	printf "${BOLD}${CYAN}claudev${RESET} version ${BOLD}$VERSION${RESET}\n"
	exit 0
fi

# Check for help flag
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then

	printf "${BOLD}${CYAN}claudev - Claude Code via Vertex AI${RESET}\n\n"
	printf "${BOLD}Usage:${RESET} claudev [options]\n\n"
	printf "This is a wrapper script that runs Claude Code using Vertex AI.\n\n"

	printf "${BOLD}Requirements:${RESET}\n"
	printf "  - claude binary (Claude Code CLI)\n"
	printf "  - gcloud CLI (Google Cloud SDK)\n\n"

	printf "${BOLD}Installation:${RESET}\n"
	printf "  ${GREEN}brew install claude-code google-cloud-sdk${RESET}\n\n"

	printf "${BOLD}Authentication:${RESET}\n"
	printf "  # Authenticate with Google Cloud\n"
	printf "  ${GREEN}gcloud auth login${RESET}\n\n"
	printf "  # Set up your project\n"
	printf "  ${GREEN}gcloud config set project ${YELLOW}YOUR_PROJECT_ID${RESET}\n\n"
	printf "  # Authenticate application default credentials\n"
	printf "  ${GREEN}gcloud auth application-default login${RESET}\n\n"

	printf "Once configured, use 'claudev' to interact with Claude Code via Vertex AI.\n\n"

	printf "${BOLD}Options:${RESET}\n"
	printf "  ${CYAN}-h, --help${RESET}       Show this help message\n"
	printf "  ${CYAN}-v, --version${RESET}    Show version information\n"
	printf "  ${CYAN}[other]${RESET}          All other options are passed to the claude binary\n"

	exit 0
fi

# Set environment variables for Vertex AI
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION=global
export ANTHROPIC_VERTEX_PROJECT_ID=$(gcloud config get-value project)

# Display current configuration
echo "Using Anthropic Vertex project: $ANTHROPIC_VERTEX_PROJECT_ID"

# Execute Claude Code with all passed arguments
exec "$(brew --prefix)/bin/claude" "$@"
