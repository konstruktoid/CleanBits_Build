[![](https://images.microbadger.com/badges/image/konstruktoid/cleanbits.svg)](https://microbadger.com/images/konstruktoid/cleanbits "Cleanbits")

# Docker cap and suid bits test

## Docker security cheat sheet

https://github.com/konstruktoid/Docker/blob/master/Security/CheatSheet.adoc

## Build the cleanbits container

`$ docker build --no-cache -t cleanbits -t konstruktoid/cleanbits -f Dockerfile .`

## Drop all capabilites and run ping as root

With `cap_net_raw+ep` on `ping`:

```
$ docker run --rm -v /dev/log:/dev/log --cap-drop all -t -i cleanbits ping 1.1.1.1
standard_init_linux.go:207: exec user process caused "operation not permitted"
```

Without capabilites on `ping`:

```
$ docker run --rm -v /dev/log:/dev/log --cap-drop all -t -i cleanbits ping 1.1.1.1
ping: icmp open socket: Operation not permitted
```

## Drop all capabilities except net_raw as root

```
$ docker run --rm -v /dev/log:/dev/log --cap-drop all --cap-add net_raw -t -i cleanbits ping -c 3 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=61 time=9.07 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=61 time=14.1 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=61 time=10.4 ms

--- 1.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 9.072/11.229/14.165/2.152 ms
```

## Default run with all capabilites

```
$ docker run --rm -v /dev/log:/dev/log -t -i cleanbits ping -c 3 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=61 time=8.93 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=61 time=12.8 ms
64 bytes from 1.1.1.1: icmp_seq=3 ttl=61 time=12.5 ms

--- 1.1.1.1 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 8.934/11.445/12.836/1.778 ms
```

## Run as user dockeru, with suid and capabilites removed

```
$ docker run -u dockeru --rm -v /dev/log:/dev/log -t -i cleanbits ping 1.1.1.1
ping: icmp open socket: Operation not permitted
```
