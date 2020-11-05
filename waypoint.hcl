project = "spring-petclinic"

app "docker-petclinic" {
    build {
        use "pack" {}

    }
    
    deploy {
        use "docker" {
            service_port = 9090
        }
    }
}

app "kubernetes-petclinic" {
    build {
        use "pack" {}
        
        registry {
          use "docker" {
            image = "gcr.io/hc-dcanadillas/spring-petclinic"
            tag   = "latest"
            # encoded_auth = file()
          }
        }

    }
    
    deploy {
        use "kubernetes" {}
    }
}

app "cloudrun-petclinic" {
    build {
        use "pack" {}
        
        registry {
          use "docker" {
            image = "gcr.io/hc-dcanadillas/spring-petclinic"
            tag   = "latest"
            # encoded_auth = file()
          }
        }

    }
    
    deploy {
        use "google-cloud-run" {
            project  = "${jsondecode(file("gcp-values.json"))["project"]}"
            location = "${jsondecode(file("gcp-values.json"))["region"]}"

            port = 8080

            capacity {
                memory                     = 1024
                cpu_count                  = 2
                max_requests_per_container = 10
                request_timeout            = 300
            }

            auto_scaling {
                max = 5
            }
        }
    }
    release {
        use "google-cloud-run" {}
    }
}
