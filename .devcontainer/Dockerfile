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

# DBFS and some API paths still read ~/.databrickscfg; env-only auth is not enough for `databricks fs`.
# Writes [DEFAULT] from DATABRICKS_HOST + DATABRICKS_TOKEN (https:// added if missing). No secrets in the image.
RUN printf '%s\n' \
	'#!/bin/sh' \
	'set -e' \
	'h="${DATABRICKS_HOST:-}"' \
	'case "$h" in "") exit 0 ;; http://*|https://*) ;; *) h="https://${h}" ;; esac' \
	'[ -z "${DATABRICKS_TOKEN:-}" ] && exit 0' \
	'umask 077' \
	'printf "%s\n" "[DEFAULT]" "host = ${h}" "token = ${DATABRICKS_TOKEN}" > "${HOME}/.databrickscfg"' \
	'chmod 600 "${HOME}/.databrickscfg"' \
	> /usr/local/bin/ensure-databricks-cfg && chmod 755 /usr/local/bin/ensure-databricks-cfg

# Install Databricks tools
RUN pip install --no-cache-dir \
	databricks-cli \
	databricks-sql-connector
