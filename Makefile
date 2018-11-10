image: build

env:
	$(eval GIT_REF=$(shell git rev-parse --short HEAD))
	$(eval URL=$(shell cat zipfile.url.in))
	$(eval ZIPFILE=$(shell echo ${URL} | sed 's#.*/\([^:]*\).*#\1#'))
	$(eval TEMPDIR=/$(shell echo ${ZIPFILE} | sed 's/\.zip//1'))
	$(eval SHA256SUM=$(shell cat zipfile.sha256sum.in))

build: env
	@echo building lokid:${GIT_REF} from ${URL} in ${TEMPDIR} after extracting ${ZIPFILE}
	@docker build --build-arg ZIPFILE="${ZIPFILE}" --build-arg SHA256SUM="${SHA256SUM}" --build-arg URL="${URL}" --build-arg TEMPDIR="${TEMPDIR}"  -f Dockerfile -t lokid:${GIT_REF} .

daemon: build
	@docker run -p 22022-22023:22022-22023 --mount source=lokid,target=/data/loki lokid:${GIT_REF} lokid --data-dir /data/loki --service-node --non-interactive

interactive: build
	@docker run -i -p 22022-22023:22022-22023 --mount source=lokid,target=/data/loki lokid:${GIT_REF} lokid --data-dir /data/loki --service-node
