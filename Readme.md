== Sencha Touch /w Padrino

## Dependency Setup

First install the latest bundler

    gem install bundler

Then install a tool called "Terminitor" that will handle our environment setup

    gem install terminitor

## Project Setup

    terminitor setup

## Start the application

    terminitor start

if this command fails, try running `terminitor setup` again (dependencies might have changed)

## Setup for deployment to Heroku

Edit config/heroku.yml with your Heroku settings and run:

    rake setup

## Deploy to Heroku

    rake deploy

