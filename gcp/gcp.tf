resource "google_compute_address" "test-ip" {
  name = "gcp-ip"
  region = "asia-east1"
}
resource "google_compute_instance" "lucas" {
  
  name         = "lucasko"
  zone         = "asia-east1-b"
  machine_type = "n1-standard-1"
 
  tags = [ "lucas"]

  boot_disk {
        initialize_params {
            image = "ubuntu-1604-lts"
            type  = "pd-ssd"
            size = 40
        }
        auto_delete = false
    }

 
  network_interface {
    network = "default"

    access_config {
       
    nat_ip = "${google_compute_address.test-ip.address}"
          }

  }
  metadata_startup_script = "echo hi > /test.txt"
}
resource "google_compute_network" "default" {
  name = "test-network"
}
resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  source_ranges = ["1.163.211.186"]
  source_tags = ["lucas"]   
}
