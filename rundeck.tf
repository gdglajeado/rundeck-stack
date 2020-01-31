module "network" {
  source = "./../../tf-modules/gcp-network"

  name                    = "rundeck"
  description             = "Rede para o projeto Rundeck"
  auto_create_subnetworks = false
}

module "subnetwork" {
  source = "./../../tf-modules/gcp-subnetwork"

  name          = "rundeck"
  region        = "us-central1"
  network       = module.network.self_link
  ip_cidr_range = "10.10.1.0/24"
  private_ip_google_access = false
}

module "instance" {
  source = "./../../tf-modules/gcp-instances"

  name       = "rundeck"
  network    = module.network.self_link
  subnetwork = module.subnetwork.self_link
}