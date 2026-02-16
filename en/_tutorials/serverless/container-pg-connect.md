

To connect to the {{ mpg-name }} cluster from the {{ serverless-containers-name }} container:

1. [Prepare files for a Docker image](#prepare-docker).
1. [Create a Docker image in the registry](#create-image).
1. [Create and set up a {{ serverless-containers-name }} container](#create-container).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mpg-name }} cluster fee: Using computing resources allocated to hosts and disk space (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* {{ container-registry-name }} fee: Using the storage (see [{{ container-registry-name }} pricing](../../container-registry/pricing.md#rules-storage)).
* Fee for the {{ serverless-containers-name }} container: Number of container invocations and computing resources (see [{{ container-registry-name }} pricing](../../serverless-containers/pricing.md)).


## Getting started {#before-begin}

1. If you do not have Docker yet, [install it](https://docs.docker.com/get-docker/). Make sure Docker Engine is running.
1. If you do not have a {{ mpg-name }} cluster, [create one](../../managed-postgresql/operations/cluster-create.md). You can connect from the {{ serverless-containers-name }} container regardless of the public access settings to cluster hosts.

## Prepare files for a Docker image {#prepare-docker}

1. In the local directory, create an Ubuntu-based Dockerfile. The container environment configuration depends on whether there is public access to the cluster hosts:

    {% list tabs %}

    - Without public access

        ```docker
        FROM ubuntu:latest

        RUN apt-get update && \
            apt-get install postgresql-client --yes

        COPY pg-version.sh pg-version.sh

        RUN chmod +x pg-version.sh

        ENTRYPOINT ["/pg-version.sh"]
        ```

    - With public access

        ```docker
        FROM ubuntu:latest

        RUN apt-get update && \
            apt-get install wget postgresql-client --yes && \
            mkdir --parents ~/.postgresql && \
            wget "{{ crt-web-path }}" \
            --output-document ~/.postgresql/root.crt && \
            chmod 0600 ~/.postgresql/root.crt

        COPY pg-version.sh pg-version.sh

        RUN chmod +x pg-version.sh

        ENTRYPOINT ["/pg-version.sh"]
        ```

    {% endlist %}

1. Put the `pg-version.sh` script in the same working directory. The script connects to the database and requests the {{ PG }} version. The connection string in the script depends on whether there is public access to the cluster hosts:

    {% list tabs %}

    - Without public access

        ```bash
        #!/bin/bash

        echo "$0: Start: $(date)"

        echo "Viewing the PostgreSQL Server Version"

        export PGPASSWORD='<password>'
        psql -h <host_FQDN> -p 6432 -U <username> -d <DB_name> -c 'select version();'

        echo "$0: End: $(date)"
        ```

    - With public access

        ```bash
        #!/bin/bash

        echo "$0: Start: $(date)"

        echo "Viewing the PostgreSQL Server Version"

        export PGPASSWORD='<password>'
        psql -h <host_FQDN> -p 6432 --set=sslmode=require -U <username> -d <DB_name> -c 'select version();'

        echo "$0: End: $(date)"
        ```

    {% endlist %}

    Specify the following in the script:

    * [FQDN](../../managed-postgresql/operations/connect.md#fqdn) of your cluster host.
    * Username for connection.
    * User password.
    * Name of the database to connect to.

## Create the Docker image in the registry {#create-image}

1. [Create a registry](../../container-registry/operations/registry/registry-create.md) in {{ container-registry-full-name }}.

1. Build the Docker image by running the command in the working directory with the Docker file:

    ```bash
    docker build . \
        -t {{ registry }}/<registry_ID>/ubuntu:pgconnect
    ```

    Check that the image with the specified name appeared in the local repository:

    ```bash
    docker images
    ```

1. Authenticate in the registry:

    1. [Get an IAM token](../../iam/operations/iam-token/create.md).
    1. Run this command:

        ```bash
        docker login \
        --username iam \
        --password <IAM_token> \
        {{ registry }}
        ```

    For other methods, see [{#T}](../../container-registry/operations/authentication.md).

1. Push the Docker image to the registry:

    ```bash
    docker push {{ registry }}/<registry_ID>/ubuntu:pgconnect
    ```

## Create and set up a {{ serverless-containers-name }} container {#create-container}

1. [Create a service account](../../iam/operations/sa/create.md) named `docker-puller` with the `container-registry.images.puller` role.
1. [Create a {{ serverless-containers-name }} container](../../serverless-containers/operations/create.md) named `demo-pg-connect`.
1. In the container revision settings, specify:

    * Reference to the previously created image in the registry, in the **{{ ui-key.yacloud.serverless-containers.label_image-url }}** field.
    * In the Service account `docker-puller` field, specify **{{ ui-key.yacloud.forms.label_service-account-select }}**.
    * Network in which the {{ mpg-name }} cluster is located, in the **{{ ui-key.yacloud.vpc.label_network }}** field. You do not need to specify the network if public access is enabled for the cluster.

1. Click **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.
1. Copy the link to invoke the container from the **{{ ui-key.yacloud.common.section-base }}** section in the management console.
1. Invoke the container by running the command:

    ```bash
    curl --header "Authorization: Bearer $(yc iam create-token)" <invocation_link>
    ```

1. Go to the **{{ ui-key.yacloud.common.logs}}**section and make sure the container logs contain information about the {{ PG }} version.

## Delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete the {{ serverless-containers-name }} container](../../serverless-containers/operations/delete.md).
1. [Delete the Docker images from the registry](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Delete the registry](../../container-registry/operations/registry/registry-delete.md).
1. [Delete the service account](../../iam/operations/sa/delete.md).
1. [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

To delete the created Docker image from the local repository, run the command:

```bash
docker rmi {{ registry }}/<registry_ID>/ubuntu:pgconnect
```
