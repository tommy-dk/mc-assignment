ENV ?= dev
TF_VAR_file := environments/$(ENV).tfvars
BACKEND_KEY := eks-mastercard/$(ENV)/terraform.tfstate
AWS_REGION ?= eu-west-1
AWS_PROFILE ?= default

export AWS_REGION
export AWS_PROFILE

# Load .env automatically if it exists
ifneq ("$(wildcard .env)","")
	include .env
	export
endif

init:
	@echo "Initializing Terraform for $(ENV)..."
	terraform init \
		-backend-config="key=$(BACKEND_KEY)" \
		-backend-config="region=$(AWS_REGION)"

validate: ## Terraform validate
	terraform validate

fmt: ## Terraform format
	terraform fmt -check

plan: ## Terraform plan
	terraform plan -var-file=$(TF_VAR_file)

apply: ## Terraform apply
ifeq ($(ENV),prod)
	@echo "Applying changes to production..."
	terraform apply -auto-approve -var-file=environments/prod.tfvars
else
	$(error apply can only be run for ENV=prod (main branch))
endif

destroy: ## Terraform destroy
	terraform destroy -auto-approve -var-file=$(TF_VAR_file)

output: ## Terraform output
	terraform output

whoami: ## Prints your identity in AWS
	aws sts get-caller-identity

lint: ## Terraform lint
	tflint .

secure: ## Scan the terraform code for any security flaws
	tfsec .

checkov: ## Checkov scan of the terraform code
	checkov -d .

docs: ## Create docs for the terraform code
	terraform-docs markdown table . > terraform.md

install: ## Install all needed tools with brew
	brew bundle install --file=Brewfile

help: ## Print help for Makefile
	@echo "💡 Makefile Usage:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

## SemVer

version: ## Get current Version
	@git describe --tags --abbrev=0

tag-patch: ## Tag patch version
	@git tag v`git describe --tags --abbrev=0 | awk -F. '{print $1 "." $2 "." $3+1}'`
	@git push --tags

tag-minor: ## Tag minor version
	@git tag v`git describe --tags --abbrev=0 | awk -F. '{print $1 "." $2+1 ".0"}'`
	@git push --tags

tag-major: ## Tag major version
	@git tag v`git describe --tags --abbrev=0 | awk -F. '{print $1+1 ".0.0"}'`
	@git push --tags
