### Version 3.0.0 {#version3.0.0}

* Upgraded to Ubuntu 22.04.

### Version 2.3.0 {#version2.3.0}

* Fixed the `gpu-standard-v3` platform issues.
* Updated system components and packages.

### Version 2.2.0 {#version2.2.0}

* Added the `net.netfilter.nf_conntrack_tcp_be_liberal = 1` flag to the `sysctl` configuration.
* Updated system components and packages.

### Version 2.1.1 {#version2.1.1}

* Added Docker container logs rotation using the `local` logging driver.
* Disabled `rpcbind`.
* Fixed a network connection leak in the system when updating Docker Compose projects.

### Version 2.1.0 {#version2.1.0}

* Added XFS file support in the [Docker Compose specification](../../cos/concepts/index.md#compose-spec).
* Added Docker container labels to identify automatically launched containers.
* Added COI version data to Docker image descriptions.
* Fixed the disk mount issue after a VM restart when using the Docker Compose spec.

### Version 2.0.4 {#version2.0.4}

* Added a Container Optimized Image with GPU support.
  `yc compute image get-latest-from-family coi-base-gpu --folder-id standard-images`

### Version 2.0.3 {#version2.0.3}

* Enabled strict mode for the `net.ipv4.conf.all.rp_filter` kernel parameter.
* Fixed the `logrotate` utility configuration.
* Deleted the `daemon.json` Docker configuration file that incorrectly disabled the Docker container’s internet access.

### Version 2.0.2 {#version2.0.2}

* Fixed the CVE-2021-3156 vulnerability.

### Version 2.0.1 {#version2.0.1}

* Updated the Docker version.

### Version 2.0.0 {#version2.0.0}

* Upgraded to Ubuntu 20.04.

### Version 1.3.1 {#version1.3.1}

* Fixed an issue where Docker containers were recreated in a loop if the metadata service was inaccessible.

### Version 1.3.0 {#version1.3.0}

* Added disk support in the COI and Docker Compose specs.

### Version 1.2.1 {#version1.2.1}

* Improved working with `docker volumes`.

### Version 1.2.0 {#version1.2.0}

* Added the option to use {{ oslogin }}, with the system automatically adding {{ oslogin }} users to the `docker` group.
* Improved updating Docker Compose projects by adding the `--delete-orphans` flag for deleting older project versions.

### Version 1.1.2 {#version1.1.2}

* Fixed the automatic launch of Docker containers.

### Version 1.1.1 {#version1.1.1}

* Fixed the automatic launch of Docker containers.

### Version 1.1.0 {#version1.1.0}

* Added Docker Compose support.

### Version 1.0.3 {#version1.0.3}

Fixed the automatic launch of Docker containers:
* When you restart a VM and update its metadata, this will no longer start an outdated Docker container.
* Reduced the number of logs in `yc-container-daemon`.
* Added retries to update a Docker container if the previous update attempt fails.

### Version 1.0.2 {#version1.0.2}

Fixed the automatic launch of Docker containers:
* Added a detailed error message when using `docker login` for a domain with a configured Docker credential helper.

### Version 1.0.1 {#version1.0.1}

Fixed the automatic launch of Docker containers:
* The system will no longer delete Docker containers with `-` in their name.

### Version 1.0 {#version1.0}

* The first COI version on Ubuntu 16.04.
