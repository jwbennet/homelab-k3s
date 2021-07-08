.PHONY: install
install: ## Install roles dependencies
	@ansible-galaxy install -r requirements.yaml $(opts)
	echo $(MAKEFILE_LIST)

.PHONY: run
run: ## Run playbook to setup Kubernetes cluster
	@ansible-playbook k3s.yaml

.PHONY: inventory-graph
inventory-graph: ## Display the inventory as seen from Ansible
	@ansible-inventory --graph $(opts)

.PHONY: inventory-list
inventory-list: ## Display the inventory as seen from Ansible
	@ansible-inventory --list $(opts)

.PHONY: lint
lint: ## Check syntax of the playbook
	@ansible-playbook --syntax-check $(opts) "k3s.yaml"

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
