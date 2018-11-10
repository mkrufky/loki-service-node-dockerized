# loki-service-node-dockerized
loki service node daemon container for loki.network


This method uses a [bind mount](https://docs.docker.com/storage/bind-mounts) to persist the blockchain data on the host.

To simplify things, basic operations have been added as `Makefile` commands.

## To build:
```
make image
```

## To register / run (interactive):
```
make interactive
```

## To run (non-interactive):
```
make daemon
```


## To run as a systemd service:
Assuming you have created a user `loki` in group `loki` and have cloned this repository in the `loki` home user directory,
the following service file will start the daemon automatically at system startup.

Enter the following into /etc/systemd/system/lokinode.service:
```
[Unit]
Description=Loki daemon service
After=network.target

[Service]
User=loki
Group=loki
Type=simple
Restart=always
RestartSec=30s
WorkingDirectory=/home/loki/loki-service-node-dockerized
ExecStart=/usr/bin/make daemon

[Install]
WantedBy=default.target
```

After creating the service file, enable and restart the service:
```
systemctl enable lokinode
systemctl restart lokinode
```

NOTE: You should make sure the service is *not* running while you use interactive mode for service node registration.

To stop the service:
```
systemctl stop lokinode
```

To restart the service:
```
systemctl restart lokinode
```
<hr>

#### Donations accepted:
`LQVBxRvxBNYLFyHRiA5XNZXpi1dvptvR5THSN4c9FCYSU7mtLWPQpc99kqTQjJNnNETt35m6cT6Qb4jLtL5x8iwAL3mPnSE (LOKI)`
