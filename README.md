# gps_collector
 The gps_collector is a application with 3 simple endpoints. The endpoints help add GeoJSON points into a database and help retrieve GeoJSON points from database which are within a certain parameter. gps_collector is a Rack application with a Postgres/PostGIS database. Using PostGIS helps make Geometry operations simple and easy, as most come as built in functionality. 
<br>
<br>

## Prerequisite
 If you intent to use the application a few prequesistes are required. Current setup was build using the following libraries and services with the stated versions
 * ruby 3.0.0p0
 * Rack 1.3 (Release: 2.2.3)
 * Docker version 20.10.5, build 55c4c88
 * mdillon/postgis:9.4

### Install Prerequisites
> 1. Install Ruby
>    * To install ruby one must follow the given instructions at https://www.ruby-lang.org/en/documentation/installation/
> 2. Install Rack
>    * abc
> 3. Install Docker
> 4. Standup PostGIS
