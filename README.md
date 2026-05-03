# README

## Development with Docker

This project includes a development-focused Docker setup:

- [`Dockerfile.dev`](Dockerfile.dev) for the Rails app container
- [`docker-compose.yml`](docker-compose.yml) for Rails + Tailwind + PostgreSQL

### Start the stack

Build and start the app plus PostgreSQL:

```sh
docker compose up --build
```

The Rails app will be available at `http://localhost:4000` by default.

To use a different port:

```sh
PORT=3000 docker compose up --build
```

You can also change the published PostgreSQL port if `5432` is already in use:

```sh
POSTGRES_PORT=5433 docker compose up --build
```

### Common commands

Start in the background:

```sh
docker compose up -d
```

Stop the stack:

```sh
docker compose down
```

Stop the stack and remove volumes:

```sh
docker compose down -v
```

Rebuild after changing Docker-related files or native dependencies:

```sh
docker compose up --build
```

View logs:

```sh
docker compose logs -f web
docker compose logs -f css
docker compose logs -f db
```

Open a shell in the running app container:

```sh
docker compose exec web bash
```

### Rails commands

Open a Rails console in the running container:

```sh
docker compose exec web bin/rails console
```

Run a one-off Rails command in a fresh container:

```sh
docker compose run --rm web bin/rails about
```

Run the test suite:

```sh
docker compose run --rm web bin/rspec
```

### Database

The app container runs `bin/rails db:prepare` on startup, so initial setup and pending migrations are applied
automatically when the `web` service boots.

Create a migration:

```sh
docker compose exec web bin/rails generate migration AddSomethingToTable
```

Run migrations:

```sh
docker compose exec web bin/rails db:migrate
```

Rollback the last migration:

```sh
docker compose exec web bin/rails db:rollback
```

Reset the development database:

```sh
docker compose exec web bin/rails db:reset
```

Open a PostgreSQL shell:

```sh
docker compose exec db psql -U postgres -d kedu2_development
```

### Notes

Gems are stored in a named Docker volume so repeated boots are faster.

The app source is bind-mounted into the container, so code changes on your machine are reflected immediately.

If the app fails to boot after Gem changes, run:

```sh
docker compose run --rm web bundle install
```
