.PHONY: build run stop test

run: build
	docker run --rm -p 4000:4000 \
		-e SECRET_KEY_BASE=$$(mix phx.gen.secret) \
		-e PHX_HOST=localhost \
		-e PHX_SCHEME=http \
		-e PHX_URL_PORT=4000 \
		hangman

build:
	docker build -t hangman .

stop:
	docker stop $$(docker ps -q --filter ancestor=hangman) 2>/dev/null || true

test:
	mix test
