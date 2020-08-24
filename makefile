tfinit:
	cd infra/production; terraform init

create:
	cd infra/production; terraform apply

destroy:
	cd infra/production; terraform destroy