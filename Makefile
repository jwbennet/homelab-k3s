.PHONY: install
install: ## Install roles dependencies
	@pip install --user ansible-lint
	@ansible-galaxy install -r requirements.yaml --force $(opts)

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
	@ansible-playbook --syntax-check $(opts) "k3s.yaml" "os-update.yaml"

.PHONY: start-cluster
start-cluster: ## Start the k3s cluster
	@ansible-playbook k3s.yaml --become -e 'k3s_state=started'

.PHONY: stop-cluster
stop-cluster: ## Stop the k3s cluster
	@ansible-playbook k3s.yaml --become -e 'k3s_state=stopped'

.PHONY: restart-cluster
restart-cluster: ## Restart the k3s cluster
	@ansible-playbook k3s.yaml --become -e 'k3s_state=restarted'

.PHONE: shutdown-cluster
shutdown-cluster: ## Shut down the k3s cluster nodes
	@ansible all -a 'shutdown -h now' --become

.PHONY: update-os-cluster
update-os-cluster: ## Apply OS updates on the k3s cluster
	@ansible-playbook os-update.yaml

.PHONY: ping
ping: ## Ping all nodes in the cluster to ensure SSH connections are working
	@ansible all -m ping

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
