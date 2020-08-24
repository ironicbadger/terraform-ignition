# IronicBadger/terraform-ignition

This repo contains examples of using Terraform 0.13 to create a Red Hat CoreOS image running HAproxy in a container.

> NOTE: Red Hat CoreOS ships as a component of OpenShift Container Platform. Therefore using RHCOS in this fashion is not supported and these scripts are provided for educational purposes only.

```bash
[core@haproxy ~]$ systemctl status haproxy -l
● haproxy.service - haproxy
   Loaded: loaded (/etc/systemd/system/haproxy.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2020-08-17 02:09:29 UTC; 38s ago
  Process: 1754 ExecStartPre=/bin/podman pull quay.io/openshift/origin-haproxy-router (code=exited, status=0/SUCCESS)
  Process: 1744 ExecStartPre=/bin/podman rm haproxy (code=exited, status=1/FAILURE)
  Process: 1677 ExecStartPre=/bin/podman kill haproxy (code=exited, status=125)
 Main PID: 1814 (podman)
    Tasks: 9 (limit: 5760)
   Memory: 354.3M
   CGroup: /system.slice/haproxy.service
           └─1814 /bin/podman run --name haproxy --net=host --privileged --entrypoint=/usr/sbin/haproxy -v /etc/haproxy/haproxy.conf:/var/lib>
```

When creating the instance, a standard `/etc/haproxy/haproxy.cfg` is generated from the template in the module code. This is then rendered into an ignition file and injected into the RHCOS instance using `extra_config` parameters. At runtime, it uses a systemd unit file to execute a container using podman.

An instance of RHCOS is created and HAproxy is up and running. You may verify success by using the enabled stats component at `http://<ip-address>:1936/haproxy?stats`.

## Usage

* Modify `infra/production/terraform.tfvars` as required
* Run `make tfinit` to initialise the Terraform modules and providers
* Run `make infra` to create the RHCOS VM
* Run `make destroy` to destroy the RHCOS VM

> For full details on using `yamldecode` to read in configuration review the follow [blog post](https://blog.ktz.me/store-terraform-secrets-in-yaml-files-with-yamldecode/). See `vsphere.yaml.example` for example syntax of this method.

## Notes

This code was originally written as part of an OpenShift 4 deployment, the code for that is in [this repo](https://github.com/IronicBadger/ocp4).