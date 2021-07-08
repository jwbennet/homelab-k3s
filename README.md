# Homelab Kubernetes

This project tracks the files used to setup and configure the Raspberry Pi nodes used for a home Kubernetes cluster. This is primarily powered by [k3s](https://k3s.io).

## Requirements

* Ansible 2.11.x or newer
* Make
* Target nodes have been configured with SSH keys and `ssh-agent` is active

## Make Commands

| Command         | Description                                |
|-----------------|--------------------------------------------|
| install         | Install roles dependencies                 |
| inventory-graph | Display the inventory as seen from Ansible |
| inventory-list  | Display the inventory as seen from Ansible |
| lint            | Check syntax of the playbook               |
| run             | Run playbook to setup Kubernetes cluster   |
