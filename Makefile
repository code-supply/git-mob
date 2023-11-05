install:
	mkdir -p $$out/bin
	install $$src/src/* $$out/bin/

installcheck:
	shellcheck $$src/src/*
	set -e; for test in $$src/test/*-tests; do PATH="src:$$PATH" bash $$test; done
