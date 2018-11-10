# loki-service-node-dockerized
loki service node daemon container for loki.network


This method uses a [bind mount](https://docs.docker.com/storage/bind-mounts) to persist the blockchain data on the host.

## To build:
From within this repository, do:
```
docker build -f Dockerfile -t lokid:`git rev-parse --short HEAD` .
```

## To register / run (interactive):
From within this repository, do:
```
docker run -i -p 22022-22023:22022-22023 --mount source=lokid,target=/data/loki lokid:`git rev-parse --short HEAD` lokid --data-dir /data/loki --service-node
```

## To run (non-interactive):
From within this repository, do:
```
docker run -p 22022-22023:22022-22023 --mount source=lokid,target=/data/loki lokid:`git rev-parse --short HEAD` lokid --data-dir /data/loki --service-node --non-interactive
```
<hr>

#### Donations accepted:
`LQVBxRvxBNYLFyHRiA5XNZXpi1dvptvR5THSN4c9FCYSU7mtLWPQpc99kqTQjJNnNETt35m6cT6Qb4jLtL5x8iwAL3mPnSE (LOKI)`
