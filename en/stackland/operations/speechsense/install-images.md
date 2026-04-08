# Uploading {{ speechsense-name }} images

The basic {{ stackland-name }} package does not include {{ speechsense-name }} images. Make sure to upload the images to the cluster before activating the component.

## Getting started {#before-you-begin}

1. Make sure your cluster service account can access protected images in the container registry.
1. Download the latest `sladm` version as described in our [Installation guide](../../quickstart.md#download-files).

## Cluster with internet access {#online}

If your cluster has internet access, pull the {{ speechsense-name }} images directly from the container registry:

```bash
sladm pull \
  --image-bundle speechsense \
  --config config/
```

Where:

* `--image-bundle`: Name of the protected component. To pull {{ speechsense-name }} images, specify `speechsense`.

The command will create a directory with container images in OCI format.

{% note info %}

{{ speechsense-name }} images contain machine learning models and use a considerable amount of disk space. Make sure the disk has at least 100 GB of available free space.

{% endnote %}

## Air-gapped cluster {#airgapped}

If the cluster has no internet access, pull the images to an internet-connected machine, transfer them into the internal infrastructure, and then push them to the cluster’s local registry.

### Pulling images on an internet-connected machine {#download-images}

On an internet-connected machine, run this command:

```bash
sladm pull \
  --image-bundle speechsense \
  --config config/
```

### Transferring artifacts into the internal infrastructure {#transfer}

Transfer the following to a machine with cluster access:

* Directory with container images in OCI format.
* Binary file named `sladm`.

The transfer method depends on the security policies in your organization: removable media, secure file storage systems, or isolated network segments.

### Pushing images to the local registry {#push-images}

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

If you only need to install {{ speechsense-name }} on some of the cluster nodes, you can specify a list of target nodes for copying images in the following format: `--target-registry <host_name_or_IP_1>:5001,<host_name_or_IP_2>:5001`.

## What's next {#whats-next}

* [{#T}](configure.md): Set up and activate {{ speechsense-name }} in your cluster.
