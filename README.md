# IronicBadger/terraform-ignition

This repo contains examples of using Terraform 0.13 to create a Red Hat CoreOS image running HAproxy in a container.

When creating the instance, a standard `/etc/haproxy/haproxy.cfg` is generated from the template in the module code. This is then rendered into an ignition file and injected into the RHCOS instance using `extra_config` parameters. At runtime, it uses a systemd unit file to execute a container using podman.

An instance of RHCOS is created and HAproxy is up and running. You may verify success by using the enabled stats component at `http://<ip-address>:1936/haproxy?stats`.

## Usage

* Modify `infra/production/terraform.tfvars` as required
* Run `make tfinit` to initialise the Terraform modules and providers
* Run `make infra` to create the RHCOS VM
* Run `make destroy` to destroy the RHCOS VM

> For full details on using `yamldecode` to read in configuration review the follow [blog post](https://blog.ktz.me/store-terraform-secrets-in-yaml-files-with-yamldecode/).

## Notes

This code was originally written as part of an OpenShift 4 deployment, the code for that is in [this repo](https://github.com/IronicBadger/ocp4).