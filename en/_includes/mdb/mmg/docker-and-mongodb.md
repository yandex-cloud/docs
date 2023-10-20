## Before you connect from a Docker container {#connection-docker}

To connect to a {{ mmg-name }} cluster from a Docker container using SSL, add the following lines to the Dockerfile:

```bash
RUN apt-get update && \
    apt-get install wget --yes && \
    mkdir --parents ~/.mongodb && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mongodb/root.crt && \
    chmod 0644 ~/.mongodb/root.crt
```

To connect without SSL, no additional Dockerfile settings are required.

After running the Docker container, switch to it and [install](https://www.mongodb.com/docs/mongodb-shell/install/) the `mongosh` utility. You will need it to connect to the cluster.
