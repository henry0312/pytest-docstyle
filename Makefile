SHELL := /bin/bash
PACKAGE := $(shell \grep "name=" setup.py | \sed -e "s/ *name='\(.*\)',/\1/")
VERSION := $(shell \cat VERSION)

install:
	pip install .
.PHONY: install

uninstall:
	pip uninstall -y $(PACKAGE)
.PHONY: uninstall

update: clean uninstall install
.PHONY: update

clean:
	${RM} -fr {.,src,tests}/*.egg-info {.,src,tests}/.cache {.,src,tests}/.pytest_cache {.,src,tests}/__pycache__
.PHONY: clean

setup:
	pip install -e .[tests]
.PHONY: setup

test:
	pytest src tests
.PHONY: test

sdist: clean
	python setup.py sdist
.PHONY: sdist
