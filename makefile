tfinit:
	cd infra/production; terraform init
	cd modules/vmware/ign_haproxy; terraform init
	cd modules/vmware/rhcos; terraform init

infra:
	cd infra/production; terraform apply

destroy:
	cd infra/production; terraform destroy