# HN Hiring

HN Hiring is an index of jobs from Hacker News' Who is Hiring? posts.

## Requirements

* Ruby
* Postgres

## Installation

```
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
