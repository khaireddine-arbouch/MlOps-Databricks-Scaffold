.PHONY: install install-dev lint format test ci clean

# Editable install with dev tools (pytest, ruff) — matches devcontainer postCreateCommand
install:
	pip install -e ".[dev]"

install-dev: install

lint:
	ruff check src tests
	ruff format --check src tests

format:
	ruff format src tests
	ruff check --fix src tests

test:
	pytest -q

ci: lint test

clean:
	rm -rf build dist *.egg-info .pytest_cache .ruff_cache
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
