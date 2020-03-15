SHELL := /bin/bash

export build_target=

build_path = /build
app_path = /example
venv_path = .venv
python_version = $(shell grep --only-matching --perl-regexp 'Python :: \K[23]\.[0-9]{1,2}' setup.py)

DEFAULT_GOAL: help

.PHONY: \
	build-compose \
	build-dev \
	build-gcb \
	clean-dev \
	ensure-venv \
	freeze-reqs \
	help \
	run-dev \
	psql \
	setup \
	test

build-compose:
	docker-compose \
		build \
		--build-arg PYPI_AUTH="$(pypi_auth)" \
		--build-arg BUILD_PATH=$(build_path) \
		--build-arg APP_PATH=$(app_path) \
		$(build_target)


build-dev:
	cloud-build-local \
		--config=cloudbuild.yaml \
		--dryrun=false \
		--substitutions _BUILD_PATH=$(build_path),_APP_PATH=$(app_path) \
		.

run-dev:
	build_target=example $(MAKE) build-compose
	docker-compose up --force-recreate example

psql:
	psql postgres://$(DATABASE_OWNER):$(DATABASE_OWNER_PASSWORD)@localhost:5432/$(DATABASE_NAME)"

build-gcb:
	gcloud \
		builds \
		submit \
		--config cloudbuild.yaml \
		--substitutions _BUILD_PATH=$(build_path),_APP_PATH=$(app_path) \
		.


clean-dev:
	docker-compose \
		down \
		--remove-orphans \
		--volume


ensure-venv:
	@if [[ ! -d "$(venv_path)" || ! -f "$(venv_path)/bin/activate" ]]; then \
		PIPENV_VENV_IN_PROJECT=true \
		pipenv --python $(python_version) \
	; fi


freeze-reqs: ensure-venv
	@echo "Updating requirements.txt"
	@source $(venv_path)/bin/activate \
		&& PYPI_AUTH=$(pypi_auth) \
			pipenv lock --requirements \
				|sed -e 's/^-.*$$//' -e 's/ -i .*$$//' -e '/^$$/d' \
				|sort -u \
				> requirements.txt


help:
	@echo "Please provide a valid target"


setup: ensure-venv
	@echo "Installing pip requirements"
	@source $(venv_path)/bin/activate \
		&& PYPI_AUTH=$(pypi_auth) \
			pipenv install --dev


test:
	source $(venv_path)/bin/activate \
		&& pytest example/ || true
	build_target=test $(MAKE) build-compose
	docker-compose up \
		--force-recreate \
		test
