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
* `command`: The command to run on Docker container launch.
* `args`: Arguments passed to the command run in the Docker container.
* `env`: Environment variables available in the Docker container.
* `image`: The Docker image to use to create and run a Docker container.
* `name`: The Docker container to run.
* `securityContext`: Security and access control settings inside the Docker container. You can only run a privileged Docker container.
* `privileged`: Launch the Docker container in privileged mode. Processes in privileged Docker containers can access any system device and are the same as those with root permissions on a VM. The * default value is false.
* `stdin`: The buffer for the input stream while running the Docker container. The input stream will be linked to the running Docker container. The default value is false.
* `tty`: TTY allocation for the Docker container. The default value is false.
* `restartPolicy`: The Docker container [restart policy](restart-policy.md).
* `volumeMounts`: A list of volumes to mount inside a Docker container.
* `mountPath`: The path in the Docker container where the specified volume will be mounted.
* `volumes`: Description of the volumes used in the specification file.
* `emptyDir`: An empty directory in the `tmpfs` temporary file system that is created in the VM RAM. The contents of this directory are deleted when the Docker container it's mounted to is stopped and when the VM is restarted. To use the `tmpfs`, specify the parameter `medium:Memory`. Volume size cannot be greater than the amount of RAM allocated to the VM.
* `hostPath`: The directory from the VM file system to mount in the Docker container.
* `path`: The path to the `hostPath` directory.

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
* `version`: The specification version tag that the file should start with.
* `services`: The section that describes the services.
* `container_name`: The Docker container to run.
* `image`: The Docker image to use to create and run a Docker container.
* `ports`: Used for redirecting service ports. Specified in the format: `<PC port>:<container port>`.
* `restart`: Docker container restart policy settings.
* `volumes`: Description of the volumes used in the Docker container.
* `x-yc-disks`: Section that describes the [disks](../../compute/concepts/disk.md). It is an [extension of the Docker Compose specification](https://docs.docker.com/compose/compose-file/#extension-fields). Used when preparing to run Docker containers, before running the Docker Compose file. Docker Compose skips this section.
* `device_name`: Name of the device.
* `fs_type`: File system type. The supported file systems are ext4 and xfs.
* `host_path`: Directory the disk is mounted to.
* `partition`: The used disk partition.