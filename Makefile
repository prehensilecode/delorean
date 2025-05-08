PKGDIR=delorean

test:
	-bandit --recursive --skip B101 ${PKGDIR}
	-black --check ${PKGDIR}
	-codespell ${PKGDIR}
	-flake8 --count --select=E9,F63,F7,F82 --show-source --statistics ${PKGDIR}
	-flake8 --count --exit-zero --max-complexity=10 --max-line-length=88 --show-source --statistics ${PKGDIR}
	-isort --check-only --profile black ${PKGDIR}
	-mypy --ignore-missing-imports --install-types --non-interactive --exclude ./docs/ ${PKGDIR}
	-pytest tests/delorean_tests.py
	-pytest --doctest-modules
	-nosetests --with-coverage --cover-package=${PKGDIR}

doc:
	make -C docs clean doctest html
	open docs/_build/html/index.html
