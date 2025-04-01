TF = /usr/sbin/tofu
ENV = non-prod
REMOTE_STATE = "$(shell pwd)/remote-state"

.PHONY: help

help:
	@echo "Available commands:"
	@echo "  make help               - Show this help message"
	@echo "  make backend-once       - Build the remote state backend once"
	@echo "  make init               - Initialize the main infrastructure project"
	@echo "  make plan               - Create infrastructure plan"
	@echo "  make apply              - Apply the main infrastructure"

backend-once:
	@echo "Building backend..."
	cd $(REMOTE_STATE) && \
		$(TF) init -input=false && \
		$(TF) apply -input=false -auto-approve
	@echo "Backend build complete. Update ./env/<ENV>/backend.tf with the remote state details."

init:
	@echo "Initializing main infrastructure project..."
	$(TF) init -input=false -backend-config=./env/$(ENV)/backend.tfvars.tf -var-file=./env/$(ENV)/config.tfvars.tf || (echo "Failed to initialize Terraform" && exit 1)
	@echo "Initialization complete."

plan:
	@echo "Creating infrastructure plan..."
	$(TF) plan -out=infra.tfplan -var-file=./env/$(ENV)/config.tfvars.tf || (echo "Failed to plan Terraform" && exit 1)
	@echo "Main infrastructure plan complete."

apply: init plan
	@echo "Applying main infrastructure..."
	$(TF) apply -input=false infra.tfplan -auto-apply -backend-config=./env/$(ENV)/backend.tfvars.tf -var-file=./env/$(ENV)/config.tfvars.tf || (echo "Failed to apply Terraform" && exit 1)
	@echo "Main infrastructure build complete."
