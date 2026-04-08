# Configuring and activating {{ speechsense-name }}

Once the [images are uploaded](install-images.md), activate the {{ speechsense-name }} component in the {{ stackland-name }} cluster.

## Getting started {#before-you-begin}

1. Make sure the {{ speechsense-name }} images are [available](install-images.md) in your cluster.
1. Make sure the [{{ gpu-operator }}](../../concepts/components/gpu.md) component is enabled and the GPU nodes are available.
1. Make sure the [{{ mpg-name }}](../../concepts/components/postgresql.md), [{{ mch-name }}](../../concepts/components/clickhouse.md), and [{{ mkf-name }}](../../concepts/components/kafka.md) are enabled.
1. Set up an S3-compatible storage:
    * [Create a bucket](../storage/create-bucket.md) to store audio files.
    * [Create AccessKey](../storage/create-accesskey.md) for storage access.

## Activating the component {#enable}

1. Create the `speechsense-config.yaml` manifest file:

    {% include notitle [speechsense-config](../../_includes/yamls/components/speechsenseconfig.md) %}

    Where:

    * `endpoint`: Object storage address in the cluster.
    * `accessKeyID`: Storage access key ID.
    * `secretAccessKey`: Storage secret access key.

1. Apply the manifest:

    ```bash
    kubectl apply -f speechsense-config.yaml
    ```

1. Wait for the installation to complete. The controller automatically performs the following steps:

    * Creates a namespace named `stackland-speechsense`.
    * Generates secrets with database passwords.
    * Creates {{ PG }}, {{ CH }}, {{ KF }}, and {{ OS }} clusters.
    * Issues certificates via {{ certificate-manager-name }}.
    * Installs a Helm chart named `stackland-speechsense`.

## Checking the installation status {#check-status}

Check the component status:

```bash
kubectl get componentinstallation -n stackland-speechsense
```

Make sure all pods are running:

```bash
kubectl get pods -n stackland-speechsense
```

{% note info %}

{{ speechsense-name }} installation takes time. The size of LLM images ranges from 30 to 70 GB.

{% endnote %}

## Accessing the {{ speechsense-name }} console {#open-console}

Once the installation is complete, the {{ speechsense-name }} console will be available at:

```text
https://speechsense.sys.$cluster.$baseDomain
```

To log in, use the {{ stackland-name }} user credentials. Cluster administrators automatically get the {{ speechsense-name }} admin permissions.

## What's next {#whats-next}

* [{#T}](disable.md): Disabling {{ speechsense-name }}.
* [{{ speechsense-name }}](../../concepts/components/speechsense.md): Component description.
