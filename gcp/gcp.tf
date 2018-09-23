resource "google_compute_address" "test-ip" {
  name = "lucas-ip"
  region = "asia-east1"
}

resource "google_compute_instance" "test-gcp" {

  name         = "lucasko"
  zone         = "asia-east1-b"
  machine_type = "n1-standard-1"

  tags = [ "mylucas"]

  boot_disk {
        initialize_params {
            image = "ubuntu-1604-lts"
            type  = "pd-ssd"
            size = 40
        }
    }

  network_interface {
    network = "default"

    access_config {
       
      nat_ip = "${google_compute_address.test-ip.address}"
                 
                  }
  }

}

resource "google_compute_firewall" "test-firewall" {
  name    = "lucas-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
  source_ranges = ["1.163.211.186"]
  source_tags = ["mylucas"]   
}


 
