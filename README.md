Testing the trigger which is related to the project
Testing
Testing
Testing


# frontend docker images
```
kdprasad028/fssfrontend:v1
```

#Mongo DB

FROM mongo:latest

# Copy initialization scripts into the container
# These scripts can be used to set up default users, roles, or databases
COPY ./mongo-init.js /docker-entrypoint-initdb.d/

# Expose MongoDB port
EXPOSE 27017
