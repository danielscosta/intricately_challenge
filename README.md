
# Intricately Challanged

This is a ruby on rails app for the Intricately Challanged API.

[Docker](https://www.docker.com/community-edition) is required.

### Development instructions:

1. Clone this repository (you need [git](https://git-scm.com/) installed):
  
    `git clone git@github.com:danielscosta/intricately_challenge.git`

2. In this repository create and run the containers:
   
   `docker-compose up --build app`

    It will create a postgres container database and ruby container for install the ruby dependencies and start rails server on port 3000.

3. Setup database: 

    `docker-compose run app bundle exec rake db:setup`

4. Migrate database:

    `docker-compose run app bundle exec rails db:migrate`

    `docker-compose run test bundle exec rails db:migrate`

5. Get a bash into app container, run: 

    `docker-compose run app bash`

### Running tests:

1. Tests are stored in the `spec` folder. To run them execute:

    `docker-compose up --build test`