.PHONY: all pre-commit mypy test test-cov-html test-cov-xml

CMD:=python -m
PYMODULE:=pyrit
TESTS:=tests
UNIT_TESTS:=tests/unit
INTEGRATION_TESTS:=tests/integration

all: pre-commit

pre-commit:
	$(CMD) isort --multi-line 3 --recursive $(PYMODULE) $(TESTS)
	pre-commit run --all-files

mypy:
	$(CMD) mypy $(PYMODULE) $(UNIT_TESTS)

docs-build:
	jb build -W -v ./doc

unit-test:
	$(CMD) pytest --cov=$(PYMODULE) $(UNIT_TESTS)

unit-test-cov-html:
	$(CMD) pytest --cov=$(PYMODULE) $(UNIT_TESTS) --cov-report html

unit-test-cov-xml:
	$(CMD) pytest --cov=$(PYMODULE) $(UNIT_TESTS) --cov-report xml --junitxml=junit/test-results.xml --doctest-modules

integration-test:
	$(CMD) pytest $(INTEGRATION_TESTS) --cov=$(PYMODULE) $(INTEGRATION_TESTS) --cov-report xml --junitxml=junit/test-results.xml --doctest-modules

#clean:
#	git clean -Xdf # Delete all files in .gitignore
