# define phony targets
.PHONY: all build clean clean-all debug run shell test

# define behavior for; make AND make all
all: run
	@echo "  Waiting 1 minute before containers are up and running before testing" \
	&& sleep 60 \
	&& ./scripts/get-env.sh ./scripts/test.sh

# just build
build:
	@./scripts/get-env.sh ./scripts/build.sh

# build and run
run: build
	@./scripts/get-env.sh ./scripts/run.sh

# perform tests
test:
	@./scripts/get-env.sh ./scripts/test.sh

# build, run and attaches terminal with variables from .env file
debug: build
	@./scripts/get-env.sh ./scripts/debug.sh

# build, run and connects to shell with variables from .env file
shell: build run
	@./scripts/get-env.sh ./scripts/shell.sh

# stop and remove containers, images
clean:
	@./scripts/get-env.sh ./scripts/clean.sh

# stop and remove containers, images, dangling images and volumes
clean-all: clean
	@./scripts/get-env.sh ./scripts/clean-all.sh
