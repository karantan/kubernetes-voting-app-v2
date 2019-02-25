# convenience makefile

.PHONY: deployments
deployments:
	@kubectl create -f deployments

.PHONY: services
services:
	@kubectl create -f services

.PHONY: destroy
destroy:
	@kubectl delete deployments,service -l app=voting-app-v2
