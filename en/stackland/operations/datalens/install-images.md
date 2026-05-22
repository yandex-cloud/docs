# Uploading {{ datalens-name }} images

The basic {{ stackland-name }} package does not include {{ datalens-name }} images. Make sure to upload the images to the cluster before activating the component.

## Getting started {#before-you-begin}

1. Make sure the cluster service account can access licensed images in the container registry.
1. Download the latest `sladm` version as described in our [Installation guide](../../quickstart.md#download-files).

## Cluster with internet access {#online}

If your cluster has internet access, pull the {{ datalens-name }} images directly from the container registry:

```bash
sladm pull \
  --image-bundle datalens \
  --config config/
```

Where:

* `--image-bundle`: Component name. To pull {{ datalens-name }} images, specify `datalens`.
* `--config`: Configuration file path.

The command will create a directory with container images in OCI format.

## Air-gapped cluster {#airgapped}

If the cluster has no internet access, pull the images to an internet-connected machine, transfer them into the internal infrastructure, and then push them to the cluster’s local registry.

### Downloading images on an internet-connected machine {#download}

On an internet-connected machine, run this command:

```bash
sladm pull \
  --image-bundle datalens \
  --config config/
```

### Transferring artifacts into the internal infrastructure {#transfer}

Transfer the following to a machine with cluster access:

* Directory with container images in OCI format.
* Binary file named `sladm`.

The transfer method depends on the security policies in your organization: removable media, secure file storage systems, or isolated network segments.

{% note warning %}

Make sure the target machine has enough free space to store all artifacts.

{% endnote %}

### Pushing images to the local registry {#push}

On a machine with cluster access, run this command:

```bash
sladm push \
  --local-registry \
  --kubeconfig=<kubeconfig_path> \
  --image-bundle-folder <path_to_directory_with_images>
```

Where:

* `--local-registry`: Indicates the use of the cluster’s local registry.
* `--kubeconfig`: Path to the `kubeconfig` file for access to the cluster.
* `--image-bundle-folder`: Path to the directory with container images.

## What's next {#whats-next}

* [{#T}](configure.md): Set up and activate {{ datalens-name }} in your cluster.
