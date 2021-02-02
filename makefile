clean:
	rm -rf ./.localstack && rm -rf ./terraform && rm -rf ./terraform.tfstate && rm -rf ./terraform.tfstate.backup
init:
	docker-compose up & terraform init
build:
	export TF_LOG=WARN && terraform apply -auto-approve