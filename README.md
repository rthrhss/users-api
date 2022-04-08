# Users API

### Running with Docker Compose

#### Clone this repository:

```bash
$ git clone git@github.com:rthrhss/users-api.git
$ cd users-api/
```

#### Setup your API keys

The app needs the `USERS_API_KEY` environment variables to be set. This can be done with a `.env` file, and a `.env.sample` has been provided.

#### Build the services

```bash
$ docker-compose build
```

#### Setup and seed the database

```bash
$ docker-compose run users-api bin/rails db:setup
```

#### Run the specs (optional)

```bash
$ docker-compose run users-api bin/rspec
```

#### Download users' data from the API

```bash
$ docker-compose run users-api bin/rails users:update
```

#### Start the services:

```bash
$ docker-compose up -d
```

Afterwards, the server will be available at http://localhost:3001/

### Exploring it with `curl` and `jq`

#### Listing users (without filtering)
```
$ curl http://localhost:3001/users.json | jq '.data[] | { id, email, status }'
{
  "id": 1,
  "email": "juliusjohns@mcclure.net",
  "status": "Active"
}
{
  "id": 2,
  "email": "kenheaney@hilll.io",
  "status": "Active"
}
{
  "id": 3,
  "email": "zackaryskiles@gutkowski.name",
  "status": "Active"
}
{
  "id": 4,
  "email": "frankzboncak@willms.net",
  "status": "Inactive"
}
...
```

#### Listing users (filtering by status)

```
$ curl http://localhost:3001/users.json\?status\=Inactive | jq '.data[] | { id, email, status }'
{
  "id": 4,
  "email": "frankzboncak@willms.net",
  "status": "Inactive"
}
{
  "id": 8,
  "email": "willia@watsicaraynor.com",
  "status": "Inactive"
}
{
  "id": 12,
  "email": "patsy@buckridgekautzer.net",
  "status": "Inactive"
}
{
  "id": 16,
  "email": "shizue@fisher.net",
  "status": "Inactive"
}
...
```
