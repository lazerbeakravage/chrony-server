### Default config from vanilla install on alpine
```sh
# default config

pool pool.ntp.org iburst
initstepslew 10 pool.ntp.org
driftfile /var/lib/chrony/chrony.drift
rtcsync
cmdport 0
```

## Environment variables (optional)
| Variable | Description | Default | Example |
| - | - | - | - |
| NTP_SERVERS | Space (" ") separated list of upstream servers| pool.ntp.org | 0.pool.ntp.org 1.pool.ntp.org |
| ALLOWED_CLIENTS | Space (" ") separated list of ALLOWED clients in CIDR format | all clients | 192.168.1.0/24 192.168.2.0/24 |
| DENIED_CLIENTS | Space (" ") separated list of DENIED clients in CIDR format | N/A | 192.168.1.0/24 192.168.2.0/24 |
| ## REMOTE_PORT | Used for remote monitoring and control of the chronyd daemon by the chronyc utility.  Disabled by default | N/A | 323 |
| MAKESTEP | Step the system clock instead of slewing it if the adjustment is larger than one second, but only in the first three clock updates. | 1 3 | |
||||

## docker-compose
- host networking must be used or "chronyc clients" will show ingress ip (10.0.0.xxx)

## Random checks

#### <b>ntpq -pn</b>
```sh
overlord@totodile:/mnt/docker/chrony$ ntpq -pn
     remote                                   refid      st t when poll reach   delay   offset   jitter
=======================================================================================================
+10.55.10.55                             23.155.40.38     2 u    5   64  377   0.2578  -6.7002   2.0148
+91.189.91.157                           132.163.96.1     2 u   74   64  376  11.0259   0.2089   1.2271
```

### <b>timedatectl</b>
```sh
overlord@totodile:/mnt/docker/chrony$ timedatectl
               Local time: Wed 2025-04-02 12:29:50 EDT
           Universal time: Wed 2025-04-02 16:29:50 UTC
                 RTC time: Wed 2025-04-02 16:29:50
                Time zone: America/New_York (EDT, -0400)
System clock synchronized: yes
              NTP service: n/a
          RTC in local TZ: no
```

### <b>Client connectivity</b>
```sh
docker exec -it $(docker ps -q --filter "name=chrony" ) chronyc clients
```

```sh
overlord@totodile:/mnt/docker/chrony$ docker exec -it $(docker ps -q --filter "name=chrony" ) chronyc clients
Hostname                      NTP   Drop Int IntL Last     Cmd   Drop Int  Last
===============================================================================
wartortle.zergrush.local       55      0   6   -    10       0      0   -     -
piplup.zergrush.local          54      0   6   -    64       0      0   -     -
172.18.0.1                     54      0   6   -    43       0      0   -     -
morpeko.zergrush.local         54      0   6   -    30       0      0   -     -
cerberus.zergrush.local         3      0  10   -   654       0      0   -     -
behemoth.zergrush.local         3      0  10   -   384       0      0   -     -
```