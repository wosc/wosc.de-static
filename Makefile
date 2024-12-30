.PHONY: deploy
deploy:
# local setup:
#   git remote add deploy ssh://wosc.de/home/wosc/public_html
# remote setup
#   git config --local receive.denyCurrentBranch updateInstead  # git>=2.4
	@git push deploy --force

.PHONY: links
links: .venv/bin/linkchecker
	$< --verbose --check-extern https://wosc.de/

.venv/bin/linkchecker: .venv/bin/pip
	$< install linkchecker

.venv/bin/pip:
	python -m venv .venv
