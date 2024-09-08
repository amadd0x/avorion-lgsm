#### Image: `amadd0x/avorion-lgsm:latest`

This is a work in progress. The image is based on the [LinuxGSM](https://linuxgsm.com/) project and is intended to be used with the [Avorion](https://www.avorion.net/) game server.

### Example `docker-compose.yml` file:

```yaml
version: '3'
services:
  avorion:
    image: amadd0x/avorion-lgsm:latest
    ports:
      - 27000:27000
      - 27003:27003
      - 27021:27021
      - 27020:27020
      - 27015:27015
    volumes:
      - <host_dir>/serverfiles:/home/avserver/serverfiles
      - <host_dir>/log:/home/avserver/log
      - <host_dir>/backup:/home/avserver/lgsm/backup
      - <host_dir>/lgsm-config:/home/avserver/lgsm/config-lgsm/avserver
    environment:
      - TimeZone=America/Chicago # Update timezone if needed
    restart_policy:
      condition: on-failure
      delay: 15s
      max_attempts: 2
      window: 30m
```

### Example nomad job file: [avorion.nomad.hcl](https://github.com/amadd0x/avorion-lgsm/blob/master/deployment/avorion.nomad.hcl)
