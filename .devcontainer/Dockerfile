# Pin OS variant; bare :3.11 has no manifest on MCR (breaks Codespaces docker pull).
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# Install Databricks tools
RUN pip install --no-cache-dir \
    databricks-cli \
    databricks-sql-connector