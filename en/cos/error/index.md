---
title: "Troubleshooting {{ coi }} issues in {{ cos-full-name }}"
description: "This guide describes how you can fix issues with a {{ coi }}."
---

# Troubleshooting

To view Docker image startup logs, use the command:

```bash
sudo journalctl -u yc-container-daemon
```

Below are common errors and ways to fix them.

## The service account has no permission to download the specified Docker image {#permission-denied}

**Example:**

```
Mar 25 12:07:39 instance-name yc-container-daemon[516]:
{"level":"DEBUG","ts":"2021-03-25T12:07:39.785Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:07:39 instance-name yc-container-daemon[516]:
{"level":"DEBUG","ts":"2021-03-25T12:07:39.786Z","caller":"container/image.go:47","msg":"pulling image: '{{ registry }}/crpgrueprnc1cgt1la/nginx:1.16.0'"}
Mar 25 12:07:41 instance-name yc-container-daemon[516]:
{"level":"ERROR","ts":"2021-03-25T12:07:41.005Z","caller":"container/image.go:78","msg":"error pulling image: Error response from daemon: pull access denied for {{ registry }}/crpgruernc1bgt1la/ngin>
```

**How to fix it:** [Assign](../../iam/operations/sa/set-access-bindings.md) the `viewer` or `container-registry.images.puller` role to the service account to work with the repository, registry, or folder. For more information about the roles available in the service, see our [documentation](../../container-registry/security/index.md).

## No network access to {{ container-registry-name }} {#connection-to-cr}

**Example:**

```
Sep 28 08:00:18 cl17bn514eluq62dj8jo-unar yc-container-daemon[952]:
{"level":"DEBUG","ts":"2019-09-28T08:00:18.842Z ","caller":"container/container.go:121","msg":"trying to pull image (0/3)"}
Sep 28 08:00:18 cl17bn514eluq62dj8jo-unar yc-container-daemon[952]:
{"level":"DEBUG","ts":"2019-09-28T08:00:18.842Z","caller":"container/container.go:162","msg":"pulling image: '{{ registry }}/crpgrueprnhc1cgt1lab/nginx:1.16.0'"}
Sep 28 08:00:33 cl17bn514eluq62dj8jo-unar yc-container-daemon[952]:
{"level":"ERROR","ts":"2019-09-28T08:00:33.843Z","caller":"container/container.go:124","msg":"error pulling image: Error response from daemon: Get https://{{ registry }}/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)"}
```

**How to fix it:** Check if there is access to {{ container-registry-name }} by running this command: `nc -vz {{ registry }} 443`. If there is no access, [configure a NAT instance](../../tutorials/routing/nat-instance.md) or assign a public IP address to the VMs with {{ coi }}. You can also [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) for the subnet the VMs are being created in.

## No service account is linked to the VM to enable access to {{ container-registry-name }} {#sa-for-registry}

**Example:**

```
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"WARN","ts":"2021-03-25T12:13:23.466Z","caller":"container/container.go:240","msg":"Attempting to pull Container Registry image with empty credentials. It will only work if public registry>
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:13:23.466Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:13:23 instance-name yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:13:23.467Z","caller":"container/image.go:47","msg":"pulling image: '{{ registry }}/crpgruehrnhc0bgt1lab/nginx:1.16.0'"}
Mar 25 12:13:24 instance-name yc-container-daemon[518]:
{"level":"ERROR","ts":"2021-03-25T12:13:24.706Z","caller":"container/image.go:78","msg":"error pulling image: Error response from daemon: unauthorized: Authentication problem ; requestId = b2f6f07>
```

**How to fix it:** For private registries, [link a service account](../../compute/operations/vm-connect/auth-inside-vm.md#link-sa-with-instance) to access Docker images.

## Not enough disk space {#disk-full}

**Example:**

```
Mar 25 12:34:22 intr13-vm yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:22.043Z","caller":"container/image.go:75","msg":"trying to pull image (0/3)"}
Mar 25 12:34:22 intr13-vm yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:22.043Z","caller":"container/image.go:47","msg":"pulling image: 'openjdk:7' (normalized: 'docker.io/library/openjdk:7')"}
Mar 25 12:34:46 intr13-vm yc-container-daemon[518]:
{"level":"DEBUG","ts":"2021-03-25T12:34:46.276Z","caller":"container/image.go:59","msg":"received ImagePull response: ... {\"message\":\"failed to register layer: Error processing tar file(exit status 1): write /usr/bin/hostnamectl: no space left on device\"},\"error\":\"failed to register layer: Error processing tar file(exit status 1): write /usr/bin/hostnamectl: no space left on device\"}\r\n)."}
```

**How to fix it:** Stop the VM and [increase the disk size](../../compute/operations/disk-control/update.md#change-disk-size).