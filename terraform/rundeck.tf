module "network" {
  source = "git@github.com:gdglajeado/tf-module-gcp-network.git?ref=v1.0"

  name                    = "rundeck"
  description             = "Rede para o projeto Rundeck"
  auto_create_subnetworks = false
}

module "subnetwork" {
  source = "git@github.com:gdglajeado/tf-module-gcp-subnetwork.git?ref=v1.0"

  name                     = "rundeck"
  region                   = "us-central1"
  network                  = module.network.self_link
  ip_cidr_range            = "10.10.1.0/24"
  private_ip_google_access = false
}

module "firewall" {
  source = "git@github.com:gdglajeado/tf-module-gcp-firewall.git?ref=v1.0"

  name          = "rundeck"
  network       = module.network.self_link
  protocol      = "TCP"
  ports         = ["80", "4440", "443", "22"]
  source_tags   = ["rundeck-stack"]
  source_ranges = ["0.0.0.0/0"]
}

module "instance" {
  source = "git@github.com:gdglajeado/tf-module-gcp-instances.git?ref=v1.0"

  name         = "rundeck"
  machine_type = "n1-standard-1"
  network      = module.network.self_link
  subnetwork   = module.subnetwork.self_link
  tags         = ["rundeck-stack"]
}

output "nat_ip" {
  value = module.instance.nat_ip
}