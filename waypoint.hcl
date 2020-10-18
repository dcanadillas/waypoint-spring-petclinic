project = "spring-petclinic"

app "docker-petclinic" {
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
