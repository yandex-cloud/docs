# Uploading {{ ai-studio-name }} images

{{ model-gallery-name }} and {{ agent-atelier-name }} images come in separate `model-gallery` and `agent-atelier` bundles and do not form part of the `full` package.

Before you activate {{ ai-studio-name }}, make sure the {{ model-gallery-name }} and {{ agent-atelier-name }} images are available in the registry used by your cluster. This guide describes how to push them into a local registry, e.g., for an air-gapped cluster. If relevant images are already available to the cluster, you do not need to push them again.

## Getting started {#before-you-begin}

1. Make sure the service account can access the licensed {{ model-gallery-name }} and {{ agent-atelier-name }} images in the container registry.
1. Download the `sladm` utility for your cluster version as described in the [Installation guide](../../quickstart.md#download-files).
1. Prepare the cluster configuration and enough free space for the images, including model weights.

## Pulling images from the registry {#download-images}

On an internet-connected machine, run this command:

```bash
sladm pull \
  --image-bundle model-gallery,agent-atelier \
  --image-bundle-folder ai-studio-images \
  --config config/
```

Where:

* `--image-bundle`: Comma-separated image bundle names, `model-gallery` and `agent-atelier`.
* `--image-bundle-folder`: Path to the directory for the OCI images. Specify the path to a new directory.
* `--config`: Path to the cluster configuration.

## Pushing images to the local registry {#push-images}

If your cluster is air-gapped, transfer the `ai-studio-images` directory and the `sladm` binary to a machine with access to the cluster.

{% note info %}

The `sladm push` command may take a while to complete due to large images. Wait for it to complete before enabling the {{ ai-studio-name }} components.

{% endnote %}

On a machine with cluster access, run this command:

```bash
sladm push \
  --local-registry \
  --kubeconfig=<kubeconfig_path> \
  --image-bundle-folder ai-studio-images
```

Where:

* `--local-registry`: Indicates the use of the cluster’s local registry.
* `--kubeconfig`: Path to the `kubeconfig` file for access to the cluster.
* `--image-bundle-folder`: Path to the directory with pulled images.

## What's next {#whats-next}

* [{#T}](configure.md)
