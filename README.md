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
<<<<<<< HEAD
=======


---
kubectl apply -f namespace.yaml
kubectl apply -f mongodb-secret.yaml
kubectl apply -f mongodb-pvc.yaml
kubectl apply -f mongodb-deployment.yaml
kubectl apply -f mongodb-service.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
---

helm install my-app ./my-app

helm uninstall my-app
>>>>>>> 04bf784 (Clahan fss repo)
