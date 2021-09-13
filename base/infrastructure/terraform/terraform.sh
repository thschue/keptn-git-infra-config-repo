#!/usr/bin/env sh

set -e

export TF_WORKING_DIR=/keptn/terraform
export GOOGLE_APPLICATION_CREDENTIALS=${TF_WORKING_DIR}/account.json
export TF_VAR_keptn_token="${keptn-api-token}"
echo "${GCP_SA}" > ${TF_WORKING_DIR}/account.json

export TF_DATA_DIR=/tmp/.terraform/infra
terraform -chdir=${TF_WORKING_DIR}/infra init -backend-config="bucket=${GCP_BUCKET}" -backend-config="prefix=terraform/state-${KEPTN_STAGE}"
terraform -chdir=${TF_WORKING_DIR}/infra validate
terraform -chdir=${TF_WORKING_DIR}/infra plan -var-file=${TF_WORKING_DIR}/terraform.tfvars -var="gke_project=${GCP_PROJECT}" -var="gke_region=${GCP_REGION}" -out ${TF_WORKING_DIR}/infra.tfplan

# export TF_DATA_DIR=/tmp/.terraform/keptn
# terraform -chdir=${TF_WORKING_DIR}/keptn_execution_plane init -backend-config="bucket=${GCP_BUCKET}" -backend-config="prefix=terraform/state-keptn-${KEPTN_STAGE}"
# terraform -chdir=${TF_WORKING_DIR}/keptn_execution_plane validate
# terraform -chdir=${TF_WORKING_DIR}/keptn_execution_plane plan -var-file=${TF_WORKING_DIR}/terraform.tfvars -var="gke_project=${GCP_PROJECT}" -var="gke_region=${GCP_REGION}" -out ${TF_WORKING_DIR}/keptn-exec.tfplan

export TF_DATA_DIR=/tmp/.terraform/infra
terraform -chdir=${TF_WORKING_DIR}/infra apply -var-file=${TF_WORKING_DIR}/terraform.tfvars -var="gke_project=${GCP_PROJECT}" -var="gke_region=${GCP_REGION}" -input=false -auto-approve

# export TF_DATA_DIR=/tmp/.terraform/keptn
# terraform -chdir=${TF_WORKING_DIR}/keptn_execution_plane apply -var-file=${TF_WORKING_DIR}/terraform.tfvars -var="gke_project=${GCP_PROJECT}" -var="gke_region=${GCP_REGION}" -input=false -auto-approve