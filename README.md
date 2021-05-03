# gps_collector
 The gps_collector is a application with 3 simple endpoints. The endpoints help add GeoJSON points into a database and help retrieve GeoJSON points from database which are within a certain parameter. gps_collector is a Rack application with a Postgres/PostGIS database. Using PostGIS helps make Geometry operations simple and easy, as most come as built in functionality. 
<br>

# Install
## Prerequisite
 If you intent to use the application a few prequesistes are required. Current setup was build using the following libraries and services with the stated versions
 * a way to install gems
 * ruby 3.0.0p0
 * Rack 1.3 (Release: 2.2.3)
 * Docker version 20.10.5, build 55c4c88
 * mdillon/postgis:9.4

### Install Prerequisites
> 1. Install Ruby
>    * To install ruby, follow the given instructions at https://www.ruby-lang.org/en/documentation/installation/
> 2. Install Rack
>    * Follow documentation [here](https://github.com/rack/rack) to understand Rack
>    * The instructions [here](https://github.com/rack/rack#installing-with-rubygems-) will help install Rack on local machine - same as below
>      * A Gem of Rack is available at rubygems.org. You can install it with:
>      * `gem install rack`
> 3. Install Docker
>    * Follow instructions from docker.com to install docker on local machine
>       * [Docker Desktop](https://www.docker.com/products/docker-desktop)
>    * These instructions assume your setup of Docker will come with docker-compose, if not use the instructions [here](https://docs.docker.com/compose/install/) to install docker-compose
> 4. Standup PostGIS
>    * To stand up the database image, run the following in a Bash terminal where the `docker-compose.yml` from this repo is located:
>      * docker-compose command:
>         * `docker-compose up -d db`
> 5. [Install the actual Application](#Install-App)
>

To verify the container is up run `docker ps`:
```bash
➜ docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                    NAMES
d22806639140        mdillon/postgis:9.4   "docker-entrypoint.s…"   3 seconds ago       Up 2 seconds        0.0.0.0:5432->5432/tcp   gps_collector_db
```

## Install App
1. Clone this repo.
2. Navigate, in a terminal, to `gps_collector_app` folder.
3. Perform a `bundle install` command, in a terminal, here.
   * This will try and install all needed gem for this project
     * 'json'
     * 'pg'
     * 'rack'
     * 'rubocop'
     * 'yard'
<br>

# Running Rack App
1. Assuming docker is running with the Database
2. Navigate, in a terminal, to `gps_collector_app` folder
3. Perform a `rackup` command, in a terminal, here.
4. App should be up and running
   * Served on http://127.0.0.1:9292
<br>

# Testing App
1. Navigate, in a terminal, to `gps_collector_app` folder.
2. Perform a `ruby gps_test.rb` command, in a terminal, here.
3. This will perform tests listed in the `gps_test.rb` file.
   * These are a few simple `minitest` test fucntions
<br>

# Building Docs
1. Navigate, in a terminal, to `gps_collector_app` folder.
2. Perform a `yardoc` command, in a terminal, here.
3. Documentation for the methods and class will be generated
   * HTML doc will be located in `doc` folder within the `gps_collector_app` folder.
   * Access the documentation webpage by opening the `Index.html` file.
<br>

# Linting App
1. Navigate, in a terminal, to `gps_collector_app` folder.
2. Perform a `rubocop` command, in a terminal, here.
3. The above command will go through all code and check for any linting errors.
<br>
<br>
