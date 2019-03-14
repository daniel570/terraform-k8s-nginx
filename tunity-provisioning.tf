resource "google_compute_network" "tunity_development" {
  name                    = "tunity-development"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "tunitycluster" {
  name          = "tunitycluster"
  ip_cidr_range = "10.0.1.0/24"
  network       = "${google_compute_network.tunity_development.self_link}"
  region        = "europe-west1"
}
resource "google_container_cluster" "tunity_development_cluster" {
  name               = "tunity-development-cluster"
  zone               = "europe-west1-b"
  initial_node_count = "2"
  network            = "tunity-development"
  subnetwork         = "tunitycluster"
  node_config {
    machine_type     = "n1-standard-1"
  }
  master_auth {
    username = "xxxxx"
    password = "xxxxx"
  }
}
