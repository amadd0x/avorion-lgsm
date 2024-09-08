job "avorion" {
  datacenters = ["dc1"]
  type        = "service"
  namespace   = "default"
  priority    = 100

  constraint {
    attribute = "${node.unique.name}"
    value     = "daedalus"
  }

  group "avorion" {
    count = 1

    network {
      port "game_port" {
        static = 27000
        to     = 27000
      }

      port "query_port" {
        static = 27003
        to     = 27003
      }

      port "steam_port" {
        static = 27021
        to     = 27021
      }

      port "steamworks_p2p_port" {
        static = 27020
        to     = 27020
      }

      port "rcon_port" {
        static = 27015
        to     = 27015
      }
    }

    service {
      provider = "nomad"
      name = "avorion"
      port = "rcon_port"
      check {
        type     = "tcp"
        interval = "10s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    task "avorion" {
      driver = "docker"
      config {
        image = "amadd0x/avorion-lgsm:latest"
        ports = ["game_port", "query_port", "steam_port", "steamworks_p2p_port", "rcon_port"]
        volumes = [
          "/media/data/games/avorion/serverfiles:/home/avserver/serverfiles/",
          "/media/data/games/avorion/log:/home/avserver/log/",
          "/media/data/games/avorion/backup:/home/avserver/lgsm/backup/",
          "/media/data/games/avorion/lgsm-config:/home/avserver/lgsm/config-lgsm/avserver/"
        ]
      }

      env = {
        TimeZone   = "America/Chicago"
      }

      resources {
        cpu        = 15 * 1024
        memory     = 16 * 1024
        memory_max = 20 * 1024
      }
    }
  }
}