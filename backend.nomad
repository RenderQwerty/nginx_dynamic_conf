job "backend" {
  region = "emea"
  datacenters = ["incountry"]

  constraint {
    distinct_hosts = true
  }

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "webservers" {
    count = 1
    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "nginx" {
      constraint {
        attribute = "${meta.type}"
        value = "aws"
      }

      env {
        NOMAD_PORT_nginx = "${NOMAD_PORT_nginx}"
      }

      driver = "docker"
      config {
        image = "jaels/nginx-example"
      }

      resources {
        cpu    = 1000
        memory = 300
        network {
          mbits = 10
          port "nginx" {}
        }
      }

      service {
        name = "nginx"
        tags = ["nginx"]
        port = "nginx"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
