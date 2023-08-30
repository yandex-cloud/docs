## Connecting from a Docker container {#connection-docker}

You can only use Docker containers to connect to public cluster hosts [using SSL certificates](../../../managed-mongodb/operations/connect/index.md#get-ssl-cert).

To connect to a {{ mmg-name }} cluster, add the following lines to the Dockerfile:

```bash
RUN apt-get update && \
    apt-get install wget --yes && \
    mkdir -p ~/.mongodb && \
    wget "{{ crt-web-path }}" \
         --output-document ~/.mongodb/root.crt && \
    chmod 0644 ~/.mongodb/root.crt
```

After running the Docker container, switch to it and [install](https://www.mongodb.com/docs/mongodb-shell/install/) the `mongosh` utility. You will need it to connect to the cluster.
