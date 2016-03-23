## README

An online Data Matching Tool.

### Ruby version

* ruby: >= 2.3.0

### System dependencies

* *nix based system
* postgresql-client: ~> 9.4
* libicu

### Configuration

* config/database.yml
* config/settings/#{environment}.yml

settings keys see [config/settings.yml](config/settings.yml)

### Database creation

```sh
bundle exec rails db:create
```

### Database initialization

```sh
bundle exec rails db:setup
```

### How to run the test suite

```sh
rspec
```

### Services

Database: PostgreSQL (~> 9.4)
Job queue: Redis
Cache Server: Memcached

future: 
Search engine: Elasticsearch

### Deployment instructions

Developming
