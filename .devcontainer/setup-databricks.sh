#!/usr/bin/env bash
# Configure legacy pip databricks-cli (~/.databrickscfg) from env vars.
# In GitHub Codespaces, repository secrets with these names are injected automatically.
set -euo pipefail

if [[ -z "${DATABRICKS_HOST:-}" || -z "${DATABRICKS_TOKEN:-}" ]]; then
  echo "Databricks CLI: DATABRICKS_HOST and/or DATABRICKS_TOKEN not set; skipping ~/.databrickscfg."
  exit 0
fi

HOST="${DATABRICKS_HOST%%/}"
CFG="${HOME}/.databrickscfg"

umask 077
cat > "${CFG}" <<EOF
[DEFAULT]
host = ${HOST}
token = ${DATABRICKS_TOKEN}
EOF
chmod 600 "${CFG}"
echo "Databricks CLI: wrote ${CFG} (host: ${HOST})."
