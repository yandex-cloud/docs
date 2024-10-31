---
title: Docker container specifications in {{ cos-full-name }}
description: You can describe a Docker container's launch configuration using the COI or Docker Compose specification.
---

# Docker container specifications

There are two ways to describe a Docker container's launch configuration:
* [COI specification](#coi-spec) that allows you to run only one Docker container.
* [Docker Compose specification](#compose-spec) that allows you to set a more flexible configuration, such as running multiple Docker containers and the required services.

{% note warning %}

You can only use one specification at a time, either COI or Docker Compose.

{% endnote %}

## COI specification {#coi-spec}

In a {{ coi }}, the Docker container is described in a specification (YAML file) based on a [{{ k8s }} pod spec](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/).

When [creating a VM from a {{ coi }}](../tutorials/vm-create.md) in the management console or YC CLI, the specification file is generated automatically using the specified data. When [creating an instance group from a {{ coi }}](../tutorials/ig-create.md), you set the specification manually. A sample specification file and required keys are described below.

### Sample COI specification of a Docker container {#coi-spec-example}

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
* `args`: Arguments sent to the command run in the Docker container.
* `env`: Environment variables available in the Docker container.
* `image`: Docker image used to create and run a Docker container.
* `name`: Docker container to run.
* `securityContext`: Security and access control settings inside the Docker container. You can only run a privileged Docker container.
* `privileged`: Launching the Docker container in privileged mode. Processes in privileged Docker containers can access any system device and are the same as those with root permissions on a VM. The default value is false.
* `stdin`: Buffer for the input stream while running the Docker container. The input stream will be linked to the running Docker container. The default value is false.
* `tty`: TTY allocation for the Docker container. The default value is false.
* `restartPolicy`: Docker container [restart policy](restart-policy.md).
* `volumeMounts`: List of volumes to mount inside a Docker container.
* `mountPath`: Path in the Docker container where the specified volume will be mounted.
* `volumes`: Description of the volumes used in the specification file.
* `emptyDir`: Empty directory in the `tmpfs` temporary file system that is created in the VM RAM. The contents of this directory are deleted when the Docker container it's mounted to is stopped and when the VM is restarted. To use the `tmpfs`, specify the parameter `medium:Memory`. Volume size cannot be greater than the amount of RAM allocated to the VM.
* `hostPath`: Directory from the VM file system to mount in the Docker container.
* `path`: Path to the `hostPath` directory.

## Docker Compose specification {#compose-spec}

More information on running Docker containers and configuring services is provided in the `docker-compose.yaml` specification file (see the [Docker documentation](https://docs.docker.com/compose/compose-file/) for details).

For more information about how to run multiple Docker containers, see [{#T}](../tutorials/docker-compose.md).

### Sample Docker Compose specification {#compose-spec-example}

The Docker Compose specification is a YAML file named `docker-compose.yaml` with the following contents:

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
* `services`: Section that describes the services.
* `container_name`: Docker container you are going to run.
* `image`: Docker image used to create and run a Docker container.
* `ports`: Used for redirecting service ports. Use the format: `<PC_port>:<container_port>`.
* `restart`: Docker container restart policy settings.
* `volumes`: Description of the volumes used in the Docker container.
* `x-yc-disks`: Section that describes the [disks](../../compute/concepts/disk.md) to attach. It is an [extension of the Docker Compose specification](https://docs.docker.com/compose/compose-file/#extension-fields). Used when preparing to run Docker containers, before running the Docker Compose file. Docker Compose skips this section.
* `device_name`: The device name. Not the same as the disk name. It is specified when attaching a disk to a VM. It is used on the VM to search for the disk through the `/dev/disk/by-id/virtio-<device_name>` tree. It is specified in flags and CLI commands for adding disks to a VM using the `device-name` parameter. In the management console, it is specified in the pop-up window when [attaching a disk to a VM](../../compute/operations/vm-control/vm-attach-disk#attach).
* `fs_type`: File system type. The supported file systems are ext4 and xfs.
* `host_path`: Directory the disk is mounted to.
* `partition`: Disk partition being used.