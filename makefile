tfinit:
	cd infra/production; terraform init
	cd modules/ign_haproxy; terraform init
	cd modules/rhcos; terraform init

create:
	cd infra/production; terraform apply

destroy:
	cd infra/production; terraform destroy