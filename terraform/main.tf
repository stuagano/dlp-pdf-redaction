# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

terraform {
  backend "gcs" {
    bucket  = "var.project_id-terraform-backend"
    prefix  = "terraform/state"
  }
}

resource "random_id" "pdf_redaction" {
  byte_length = 2
}

module "pdf_redactor" {
  source = "./pdf-redactor"

  project_id            = var.project_id
  region                = var.region
  wf_region             = var.wf_region
  suffix                = random_id.pdf_redaction.hex
  image_dlp_runner      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.docker_repo_name}/dlp-runner"
  image_findings_writer = "${var.region}-docker.pkg.dev/${var.project_id}/${var.docker_repo_name}/findings-writer"
  image_pdf_merger      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.docker_repo_name}/pdf-merger"
  image_pdf_splitter    = "${var.region}-docker.pkg.dev/${var.project_id}/${var.docker_repo_name}/pdf-splitter"
}
