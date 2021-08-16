# Using the YDB Docker container

For debugging or tests, you can create a local {{ ydb-full-name }} instance in a Docker container. Docker containers use the current {{ ydb-short-name }} build version, but the build revision may differ.

{% note warning %}

When a local database is running, some tasks may require a significant portion of a machine's resources.

{% endnote %}



## Downloading a YDB Docker image {#install}


Before downloading a {{ ydb-short-name }} Docker image, see [how to get information on available Docker images](../../container-registry/operations/docker-image/docker-image-list.md) in [Yandex Container Registry](../../container-registry/).

1. Download a Docker image by running the command:

   ```bash
   sudo docker pull cr.yandex/yc/yandex-docker-local-ydb:latest
   ```

   Command parameters:
   `cr.yandex/yc/yandex-docker-local-ydb:latest`: Current version of a Docker image.

1. Make sure the Docker image has downloaded:

   ```bash
   docker image list
   ```

## Running the YDB Docker container {#start}

In local launch mode, you can only interact with a database using the API.
The data handling API deploys to port `2135`, and the previously created database is called `/local`.

{{ ydb-full-name }} in a Docker container accepts incoming TLS-encrypted connections. To establish a connection, automatically generated certificates are used.
For certificates to work correctly, you must mount the following directory from a running Docker container: `/ydb_cert`.

To save the database state in a local directory, use the following directory from inside the Docker container: `/ydb_data`.

To start the {{ ydb-short-name }} Docker container and mount the required directories, run the command:

```bash
docker run --name ydb-local --rm --hostname localhost --rm -dp 2135:2135 -dp 8765:8765 -v $(pwd)/ydb_certs:/ydb_certs -v $(pwd)/ydb_data:/ydb_data -e YDB_LOCAL_SURVIVE_RESTART=true cr.yandex/yc/yandex-docker-local-ydb:latest
```

Command parameters:

- `--name`: Docker container name.
- `--hostname`: Container hostname.

{% note info %}

It can take up to two minutes to initialize a Docker container, depending on how powerful your computer is. The database will not be available until the container is initialized.

{% endnote %}

## Database queries {#request}

You can use the command-line client built into the Docker image to work with your local {{ ydb-short-name }} database ([YDB CLI](../quickstart/examples-ydb-cli.md)). Review [example YDB CLI queries](../quickstart/examples-ydb-cli.md#use-examples) against the database.

Like {{ ydb-full-name }}, {{ yandex-cloud }} uses a secure TLS connection to exchange data with the local database.
To work with {{ ydb-full-name }} in a Docker container, use the certificate located in the `/ydb_cert` directory mounted from a running Docker container.

Example query:

```bash
{{ ydb-cli }} -e grpcs://localhost:2135 --ca-file $(pwd)/ydb_certs/ca.pem -d /local table query execute -q 'select 1;'
```

Command parameters:

- `-e`: Endpoint.
- `--ca-file`: Option used to set the path to the TLS certificate.
- `-d`: Database.

Command output:

```bash
┌─────────┐
| column0 |
├─────────┤
| 1       |
└─────────┘
```

## Stopping a Docker container {#stop}

Once your work is complete, you can stop a Docker container with the command:

```bash
docker kill ydb-local
```

## Additional options {#options}

{{ ydb-short-name }} Docker containers support several additional options accessible through environment variables:

* `YDB_LOCAL_SURVIVE_RESTART=true`: Enables you to restart a container without losing data.
* `YDB_USE_IN_MEMORY_PDISKS=true`: Enables you to store all your data in memory. If this option is enabled, restarting the container with a local {{ ydb-short-name }} instance will result in complete data loss.
* `YDB_DEFAULT_LOG_LEVEL=<level>`: Enables you to configure the default logging level. Valid levels: `CRIT`, `ERROR`, `WARN`, `NOTICE`, `INFO`.

## License and components {#license}

The Docker container root includes a file with the license agreement (`LICENSE`) and a list of the components used and their licenses (`THIRD_PARTY_LICENSES`).

Display the license agreement by running the command:

```
sudo docker run --rm -it --entrypoint cat cr.yandex/yc/yandex-docker-local-ydb LICENSE
```

View all the included components and their licenses:

```
sudo docker run --rm -it --entrypoint cat cr.yandex/yc/yandex-docker-local-ydb THIRD_PARTY_LICENSES
```

