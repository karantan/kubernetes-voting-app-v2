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
