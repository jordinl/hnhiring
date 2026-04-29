# HN Hiring

HN Hiring is an index of jobs from Hacker News' Who is Hiring? posts.

## Requirements

* [Mise](https://mise.jdx.dev/)
* Postgres or Docker

## Setting up Postgres via Docker (Optional)

There's a docker-compose.yml that will spin up a postgres service on port 5432. 

If the port needs to be overriden:

```
cp .mise.local.sample .mise.local.toml
```

And update this file with the desired port.

Finally run:

```
docker compose up -d
```

## Installation

```
mise install
bundle
rake db:create db:migrate
```

## Loading jobs

```
rake cron
```

## Running server locally

```
rails s
```

Visit [localhost:3000](http://localhost:3000)
