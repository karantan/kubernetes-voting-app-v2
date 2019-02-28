# kubernetes-voting-app-v2

Simple example of the kubernetes voting app (version 2). This is an upgrade from the
first version which is located here: [link](https://github.com/karantan/kubernetes-voting-app-v1)

The only difference is that instead of using pods we are using [deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/).


# Deployments

Multiple pods are deployed using replication controllers or replica sets and then
comes deployment which is a Kubernetes object that comes higher in the hierarchy, the
deployment provides us with the capability to upgrade the underlying instances
seamlessly using rolling updates.

In Production use cases typically you will not be creating a pod definition file or
a replica set to finish an file. In most cases you will be creating only a deployment
definition file directly.


## Create Deployment

The definition defines how to launch an application called webapp1 using the Docker
Image katacoda/docker-http-server that runs on Port 80.


`deployment.yaml`:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp1
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: webapp1
    spec:
      containers:
      - name: webapp1
        image: katacoda/docker-http-server:latest
        ports:
        - containerPort: 80
```

This is deployed to the cluster with the command:

```
$ kubectl create -f deployment.yaml
$ kubectl get deployments
$ kubectl describe deployment webapp1
```


## Create Service

Kubernetes has powerful networking capabilities that control how applications
communicate. These networking configurations can also be controlled via YAML.

The Service selects all applications with the label `app: webapp1`. As multiple replicas, or
instances, are deployed, they will be automatically load balanced based on this common
label. The Service makes the application available via a NodePort.

`service.yaml`:
```
apiVersion: v1
kind: Service
metadata:
  name: webapp1-svc
  labels:
    app: webapp1
spec:
  type: NodePort
  ports:
  - port: 80
    nodePort: 30080
  selector:
    app: webapp1
```

Deploy the Service with:

```
$ kubectl create -f service.yaml
$ kubectl get svc
$ kubectl describe svc webapp1-svc
```

## Scale Deployment

Details of the YAML can be changed as different configurations are required for
deployment. This follows an infrastructure as code mindset. The manifests should be
kept under source control and used to ensure that the configuration in production
matches the configuration in source control.

Update the deployment.yaml file to increase the number of instances running.
Updates to existing definitions are applied using kubectl apply. To scale the number
of replicas, deploy the updated YAML file using:

```
$ kubectl apply -f deployment.yaml
$ kubectl get deployment
$ kubectl get pods
```
