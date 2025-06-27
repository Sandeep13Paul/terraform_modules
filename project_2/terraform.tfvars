project_id = "my-second-project-463910" # my-second-project-463910  sunlit-cab-463104-m6
region = "us-central1"
zone = "us-central1-a"

services = {
  vm_instance = {
    enabled = true
    instances = [
      {
        name         = "vm-sandeep-2"
        machine_type = "e2-medium"
        image        = "debian-cloud/debian-11"
        zone         = "asia-southeast1-b"
      },
      {
        name         = "vm-sandeep-4"
        machine_type = "e2-small"
        image        = "debian-cloud/debian-11"
        zone         = "asia-southeast1-a"
      }
    ]
  }

  bucket = {
    enabled = true
    buckets = [
      {
        name          = "sandeep-bucket-3"
        location      = "ASIA"
        force_destroy = true
        storage_class = "STANDARD"
      },
      {
        name          = "sandeep-bucket-4"
        location      = "US"
        force_destroy = false
        storage_class = "NEARLINE"
      }
    ]
  }

  vpc_network = {
    enabled = true
    networks = [
      {
        name                    = "sandeep-vpc-3"
        auto_create_subnetworks = false
        description             = "VPC network for Sandeep's project"
        subnets = [
          {
            name               = "sandeep-subnet-2"
            region             = "asia-southeast1"
            ip_cidr_range      = "10.10.0.0/24"
            private_ip_google_access = true
          }
        ]
      },
      {
        name                    = "sandeep-vpc-4"
        auto_create_subnetworks = true
        description             = "Another VPC network for Sandeep's project"
        subnets                 = []
      }
    ]
  }

  service_account = {
    enabled = true
    service_accounts = [
      {
        account_id        = "sandeep-service-account-3"
        display_name = "Sandeep Service Account 3"
        description = "Service account for Sandeep's project 2"
        project_id = "my-second-project-463910"
      },
      {
        account_id        = "sandeep-service-account-4"
        display_name = "Sandeep Service Account 4"
        description = "Service account for Sandeep's project 2"
        project_id = "my-second-project-463910"
      }
    ]
  }

}