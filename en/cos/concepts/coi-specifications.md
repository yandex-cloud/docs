---
title: Docker container specifications in {{ cos-full-name }}
description: You can describe a Docker container's launch configuration using the COI or Docker Compose specification.
---

# Docker container specifications

There are two ways to describe a Docker container's launch configuration:
* [COI specification](#coi-spec), which you can use to run a single Docker container.
* [Docker Compose specification](#compose-spec), which offers more flexibility. For example, you can run multiple Docker containers and services.

{% note warning %}

You can only use one specification at a time, the COI or Docker Compose.

{% endnote %}

## COI specifications {#coi-spec}

In a {{ coi }}, the Docker container description is in a YAML specification file based on a [{{ k8s }} pod spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

[Creating a VM from a {{ coi }}](../tutorials/vm-create.md) in the management console or YC CLI automatically generates the specification file using the provided data. When [creating an instance group from a {{ coi }}](../tutorials/ig-create.md), you set the specification manually. Below are a sample specification file and the required keys.

### Example of the COI specification for a Docker container {#coi-spec-example}

The COI specification is a YAML file with the following contents:

```yaml
spec:
  containers:
  - command:
    - sleep
    args:
    - 100000
    env:
    - name: MYENV
      value: myvalue
    image: {{ registry }}/mirror/ubuntu:16.04
    name: my-container
    securityContext:
      privileged: false
    stdin: false
    tty: false
    volumeMounts:
      - mountPath: /home/yc-user/cache
        name: cache-volume
      - mountPath: /home/yc-user/data
        name: data-volume
  restartPolicy: Always
  volumes:
    - name: cache-volume
      emptyDir:
        medium: Memory
    - name: data-volume
      hostPath:
        path: /data
```

Where:
* `command`: Command to run on Docker container launch.
* `args`: Arguments the command to run in the Docker container gets.
* `env`: Environment variables available in the Docker container.
* `image`: Docker image for creating and running a Docker container.
* `name`: Docker container to run.
* `securityContext`: Security and access control settings inside the Docker container. You can only run a privileged Docker container.
* `privileged`: Run the Docker container in privileged mode. Processes in privileged Docker containers can access any system device and are identical to those with root permissions on a VM. The default value is `false`.
* `stdin`: Buffer for the input stream while running the Docker container. The system will link the input stream to the running Docker container. The default value is `false`.
* `tty`: TTY allocation for the Docker container. The default value is `false`.
* `restartPolicy`: Docker container [restart policy](restart-policy.md).
* `volumeMounts`: List of volumes to mount inside a Docker container.
* `mountPath`: Path in the Docker container for mounting the specified volume.
* `volumes`: Description of the volumes the specification file uses.
* `emptyDir`: Empty directory in the `tmpfs` temporary file system created in the VM RAM. Stopping the directory Docker container or restarting the VM deletes the contents of this directory. To use `tmpfs`, make sure to specify the `medium: Memory` parameter. The size of a volume cannot be greater than the amount of RAM allocated to the VM.
* `hostPath`: Directory from the VM file system to mount in the Docker container.
* `path`: `hostPath` directory path.

### Use cases {#examples-coi-spec}

* [{#T}](../tutorials/coi-with-terraform.md)
* [{#T}](../tutorials/serial-port.md)

## Docker Compose specification {#compose-spec}

You need to provide instructions on running Docker containers together with service configurations in the `docker-compose.yaml` specification file as per [this Compose file reference](https://docs.docker.com/compose/compose-file/).

For more information about how to run multiple Docker containers, see [{#T}](../tutorials/docker-compose.md).

### Example of the Docker Compose specification {#compose-spec-example}

The Docker Compose specification is a file named `docker-compose.yaml` with these contents:

```yaml
version: '3.7'
services:
  app1:
    container_name: nginx
    image: "nginx"
    ports:
      - "80:80"
    restart: always
  app2:
    container_name: redis
    image: "redis"
    restart: always
    volumes:
      - /mnt/logs:/logs
      - /mnt/data:/data

x-yc-disks:
  - device_name: compute-disk-data
    fs_type: ext4
    host_path: /mnt/data
    partition: 1
  - device_name: compute-disk-data
    fs_type: ext4
    host_path: /mnt/logs
    partition: 2
```

Where:
* `version`: Specification version tag the file should start with.
* `services`: Section describing the services.
* `container_name`: Docker container to run.
* `image`: Docker image for creating and running the Docker container.
* `ports`: Redirects service ports. Use this format: `<PC_port>:<container_port>`.
* `restart`: Docker container restart policy.
* `volumes`: Description of the volumes the Docker container uses.
* `x-yc-disks`: Section describing the [disks](../../compute/concepts/disk.md) to connect. It is an [extension of the Docker Compose specification](https://docs.docker.com/compose/compose-file/#extension-fields) you use when preparing to run Docker containers, before running the Docker Compose file. Docker Compose skips this section.
* `device_name`: Device name, different from the disk name. You use it on the VM to locate the disk in the `/dev/disk/by-id/virtio-<device_name>` tree. You can set the `device-name` parameter in CLI flags and commands for adding disks to a VM or in the management console when [connecting](../../compute/operations/vm-control/vm-attach-disk#attach) a disk to a VM.
* `fs_type`: File system type. The supported file systems are ext4 and xfs.
* `host_path`: Directory to mount the disk to.
* `partition`: Disk partition being used.

### Use cases {#examples-compose-spec}

* [{#T}](../tutorials/docker-compose.md)
* [{#T}](../tutorials/vm-create-with-second-disk.md)
* [{#T}](../tutorials/coi-fluent-bit-logging.md)
