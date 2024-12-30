.PHONY: deploy
deploy:
# local setup:
#   git remote add deploy ssh://wosc.de/home/wosc/public_html
# remote setup
#   git config --local receive.denyCurrentBranch updateInstead  # git>=2.4
	@git push deploy --force

.PHONY: links
links: .venv/bin/linkchecker
	$< --verbose --check-extern http://wosc.de/

.venv/bin/linkchecker: .venv/bin/pip
# The old dependency check is `< '2.2.0'`, which the current 2.18.4 fails.
# The new incarnation https://github.com/linkcheck/linkchecker fails setup.py;
# its restriction to <2.15 seems to be necessary, however.
	$< install requests==2.14.2
	$< install --no-deps linkchecker==9.3
	sed -i -e '/2.2.0/d' .venv/lib/python2.7/site-packages/linkcheck/__init__.py
	rm .venv/lib/python2.7/site-packages/linkcheck/__init__.pyc

.venv/bin/pip:
	virtualenv --python=python2.7 .venv
