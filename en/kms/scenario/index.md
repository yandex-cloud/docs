# Running a Docker image on a VM

This example describes the steps required to run a Docker image on a VM using a registry.
If you don't have a VM yet, [create one](../../compute/quickstart/index.md).

1. Add variables for convenience:

    * Address of your VM in the `${INSTANCE_ID}` variable:

        ```
        export INSTANCE_ID=ef3ni90g6qblknkph60v
        ```

    * Your OAuth token in the `${OAUTH}` variable:

        ```
        export OAUTH=AQAAAAAV6O...
        ```

    * Your IAM token in the `${IAM}` variable:

        ```
        export IAM=CggaATEVAg...
        ```

    * Registry ID from the [example](../quickstart/index.md) in the `${REGISTRY_ID}` variable:

        ```
        export REGISTRY_ID=crpc9qeoft236r8tfalm
        ```

1. Build an Ubuntu-based Docker image from the [example](../operations/key.md):

    ```
    docker build . \
    -t cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

1. Log in to the registry under your username:

    ```
    docker login \
    --username oauth \
    --password ${OAUTH} \
    cr.yandex
    ```

1. Push the created Docker image to Yandex Cloud Registry:

    ```
    docker push \
    cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

1. Log in to the VM via SSH and authenticate as the service account associated with this VM:

    ```
    ssh ${INSTANCE_ID} docker login \
    --username iam \
    --password ${IAM} \
    cr.yandex
    ```

1. Pull the Docker image to the VM:

    ```
    ssh ${INSTANCE_ID} \
    docker pull cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

1. Run the Docker image on the VM:

    ```
    ssh ${INSTANCE_ID} \
    docker run cr.yandex/${REGISTRY_ID}/ubuntu:hello
    ```

