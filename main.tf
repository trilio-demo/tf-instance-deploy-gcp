variable "node_count" {
 default = "4"
}

provider "google" {
  project     = "salab-273415"
  region      = "us-central1"
  zone 	      = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name         = "partner-training${count.index}"
  machine_type = "n2-standard-4"
  zone         = "us-central1-a"
  count        = "${var.node_count}"
metadata = {
    "ssh-keys" = <<EOT
stefankroll:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdnhE69RAkkyYTzJ9pmRBoVy/XjR/DqLX1BT1tEPOP2LokZN7bKy5WfWwOmV/QznpoAglhhlKPIseG5TwjzFQYRpGcqC9ZOutiNhl+HpY9z4ZAOuAkGgMnAKt0NYXHqPgm7Yu+nLhePOFDglm/tvWakPHZMgUTEHvNwuxEqtBGksEdt4baeiNteOSn6YcGXDnnvPhTo/wT2cH3PMujX/gv+BXkm4Wv/Ac999gM/XeCuEepuOxVJyfvVle7w933etfX1h0dmslTybBxXPmdVEQVbP2JXsfZmxUz5XAd7KBCCICbS3QQ/3Yjf/UAXy0Kxn5Pg0/x9tpuHXOUAGVf8P8ExHN83BT+PdD1OAiqfroDmVlyk1/RJZt1aT7U0jgXv4uQhyghuv4Ab7ot0mRfxfJB4bKm/475TKh5Q6VUjK7zfYaEzrqDUJnTvBqHuM2x1PGfWR5Nx+w8+eniZmBhe0QzerT8hsM6PUUTN5mvfr/0ikQRfLAgAh4gEyCCcJIXsF0= stefankroll@triliobook.local
EOT
  }
  tags = ["stefan", "terraform"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
      size = "500"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP - creates a public IP
    }
  }
}

