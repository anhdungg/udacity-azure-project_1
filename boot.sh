#!/bin/bash

echo "Setting the environment variables"

export BLOB_ACCOUNT='udacityaccount'
export BLOB_STORAGE_KEY='MBQ4hvC1ST2kpWTDn8u60FxtvYnWzIFSR+/ra83MLeR7QyfmP2FqPsagTYK4hpBSzD3B0SbtQiiM+AStUF7TNQ=='
export BLOB_CONTAINER='images'
export SQL_SERVER='udacity-sql-server.database.windows.net'
export SQL_DATABASE='udacity-database'
export SQL_USER_NAME='admin_user'
export SQL_PASSWORD='my-passw0rd-(!)'

export CLIENT_ID='f958e84a-92b8-439f-a62d-4f45996b6d07'
export CLIENT_SECRET='wSf8Q~2GWYE21WQvazaM4EbkZ7Ucbzh_GMtkRatP'
export REDIRECT_PATH='/getAToken'

echo "Environment variables setup finished"

echo " "

echo "Booting the Application"
python3 application.py
