ARG VARIANT=3.11-bookworm
FROM mcr.microsoft.com/devcontainers/python:${VARIANT}

# Sourced from ~/.bashrc (see postCreateCommand): Databricks CLI 0.18+ needs https:// on DATABRICKS_HOST;
# Codespaces secrets are often hostname-only (avoids ://None API errors).
RUN mkdir -p /usr/local/etc && printf '%s\n' \
	'case "${DATABRICKS_HOST:-}" in' \
	'	"") ;;' \
	'	http://*|https://*) ;;' \
	'	*) export DATABRICKS_HOST="https://${DATABRICKS_HOST}" ;;' \
	'esac' \
	> /usr/local/etc/databricks-codespaces-env.sh && chmod 644 /usr/local/etc/databricks-codespaces-env.sh

# Install Databricks tools
RUN pip install --no-cache-dir \
	databricks-cli \
	databricks-sql-connector
