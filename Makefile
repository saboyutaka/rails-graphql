.DEFAULT_GOAL := help

build: ## build develoment environment
	cp .env.sample .env
	docker-compose run --rm ruby bundle install
	docker-compose run --rm ruby bundle exec rails db:migrate

serve: up attach ## Run Serve

up: ## Run web container
	docker-compose up -d ruby

workspace: ## Login to ruby dontainer
	docker-compose exec ruby bash

console: ## Run Rails Console
	docker-compose run --rm ruby bundle exec rails c

bundle: ## Run bundle install
	docker-compose run --rm ruby bundle install

migrate: ## Run rails db:migrate
	docker-compose run --rm ruby bundle exec rails db:migrate

attach: ## Attach running web container for binding.pry
	docker attach `docker ps -f name=rails-graphql_ruby -f status=running --format "{{.ID}}"`

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
