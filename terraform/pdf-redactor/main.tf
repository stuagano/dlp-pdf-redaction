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
  required_providers {
    google = {
      version = "=4.50.0"
    }
    google-beta = {
      version = "=4.50.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "=3.0.1"
    }
  }
}

provider "docker" {
  registry_auth {
    address     = "gcr.io"
    config_file = pathexpand("~/.docker/config.json")
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

locals {
  app_suffix            = "-${var.suffix}"
  app_suffix_underscore = "_${var.suffix}"
  src_path              = "${path.module}/../../src"
  docker_repo           = "gcr.io/${var.project_id}"
}
