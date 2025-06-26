project_id_2 = "my-second-project-463910" # my-second-project-463910  sunlit-cab-463104-m6
project_id_1 = "sunlit-cab-463104-m6"
region = "us-central1"
zone = "us-central1-a"

# enable_vm     = false
# enable_vpc    = true
# enable_storage = false
enable_service_account = false

# service_count = 3

project_selector = "project1" # project1 or project2


services = {
  vm_instance = {
    enabled = true
    instances = [
      {
        name         = "vm-sandeep-4"
        machine_type = "e2-medium"
        image        = "debian-cloud/debian-11"
        zone         = "asia-southeast1-b"
      },
      {
        name         = "vm-sandeep-5"
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
        name          = "sandeep-bucket-5"
        location      = "US"
        force_destroy = false
        storage_class = "NEARLINE"
      }
    ]
  }

    vpc_network = {
        enabled = false
        networks = [
        {
        name                    = "sandeep-vpc-1"
        auto_create_subnetworks = false
        description             = "VPC network for Sandeep's project"
        subnets = [
            {
            name               = "sandeep-subnet-1"
            region             = "asia-southeast1"
            ip_cidr_range      = "10.10.0.0/24"
            private_ip_google_access = true
            }
          ]
        },
        {
            name                    = "sandeep-vpc-2"
            auto_create_subnetworks = true
            description             = "Another VPC network for Sandeep's project"
        }
        ]
    }
}