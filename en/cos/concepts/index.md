---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Image {{ coi }}

_{{ coi }}_ is an [image](../../compute/concepts/image.md) of a VM optimized for running Docker containers. The image includes Ubuntu LTS, Docker, and a daemon for launching Docker containers.

It's integrated with the {{ yandex-cloud }} platform, which lets you:

- Run a Docker container immediately after the VM is created from the management console or YC CLI.
- Update running Docker containers with minimum downtime.
- Access Docker container open network ports without any additional settings.

Learn more about working with a {{ coi }} in [{#T}](../solutions/vm-create.md).

## Specifics of working with a boot disk {#boot-disk}

* When creating a VM from a {{ coi }}, you can't create a boot disk from a disk snapshot.
* By default, when creating a VM from an image, a disk is created that is the same size as the image. However, since the purpose of a VM with a {{ coi }} is to run a Docker container, there may not be enough free space when deploying the Docker container. To avoid this, explicitly specify the required size of the boot disk using the `--create-boot-disk size=<disk size in GB>` flag.

## Specifics of working with the network {#network}

* In {{ coi }}, Docker containers are run using a host's network interface.
  All ports opened in a Docker container will also be opened on the host.
* All host ports have access to the internet. This lets you automatically access the ports of a running Docker container.

## Docker image {#docker-image}

When creating a VM with a {{ coi }}, you can specify the Docker image to use to launch a Docker container.
This Docker image can be pulled from both the public Docker image registry and the {{ container-registry-name }}. If you access the Docker image via the {{ container-registry-name }}, the service account linked to the VM will be used.

Examples of Docker image names for different registries:

- Docker Hub: `ubuntu:16.04`.
- {{ container-registry-name }}: `cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:16.04`.

## Policies for restarting a Docker container {#restart-policy}

You can specify the Docker container restart policies in its description:

- `Always`: Always restart the Docker container when it's stopped. If the Docker container is stopped manually, it restarts only when the Docker daemon restarts.
- `Never`: Don't restart the Docker container automatically.
- `OnFailure`: Restart the Docker container only if it shut down with a non-zero return code.

If the Docker container description in the metadata changed when restarting the VM, the specified restart policy is ignored and a Docker container that corresponds to the new description is started.

## Docker container specifications {#coi-specifications}

There are two ways to describe a Docker container's launch configuration:

- [The COI specification](#coi-spec) that lets you run only one Docker container.
- The [Docker Compose specification](#compose-spec) that lets you set a more flexible configuration, such as running multiple Docker containers and the necessary services.

{% note warning %}

You can only use one specification at a time, either COI or Docker Compose.

{% endnote %}

### COI specification {#coi-spec}

In a {{ coi }}, the Docker container is described in a specification (YAML file) based on a [pod spec{{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#pod-v1-core).

When [creating a VM from a {{ coi }}](../solutions/vm-create.md) in the management console or YC CLI, the specification file is generated automatically using the specified data. When [creating an instance group from a {{ coi }}](../solutions/ig-create.md), you set the specifications manually. A sample specification file and required keys are described below.

#### Sample COI specification of a Docker container {#coi-spec-example}

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
    image:  cr.yandex/mirror/ubuntu:16.04
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

Specification keys are described in the following table:

| Key | Value |
| ----- | ----- |
| `command` | The command to run on Docker container launch. |
| `args` | Arguments passed to the command run in the Docker container. |
| `env` | Environment variables available in the Docker container. |
| `image` | The Docker image to use to create and run a Docker container. |
| `name` | The Docker container to run. |
| `securityContext` | Security and access control settings inside the Docker container. You can only run a privileged Docker container. |
| `privileged` | Launch the Docker container in privileged mode. Processes in privileged Docker containers can access any system device and are the same as those with root permissions on a VM. The default value is false. |
| `stdin` | The buffer for the input stream while running the Docker container. The input stream will be linked to the running Docker container. The default value is false. |
| `tty` | TTY allocation for the Docker container. The default value is false. |
| `restartPolicy` | [The Docker container restart policy](#restart-policy). |
| `volumeMounts` | A list of volumes to mount inside a Docker container. |
| `mountPath` | The path in the Docker container where the specified volume will be mounted. |
| `volumes` | Description of the volumes used in the specification file. |
| `emptyDir` | An empty directory in the `tmpfs` temporary file system that is created in the VM RAM. The contents of this directory are deleted when the Docker container it's mounted to is stopped and when the VM is restarted. To use the `tmpfs`, specify the parameter `medium:Memory`. The volume size is limited by the amount of RAM allocated to the VM. |
| `hostPath` | The directory from the VM file system to be mounted in the Docker container. |
| `path` | The path to the `hostPath` directory. |

### Docker Compose specification {#compose-spec}

Instructions for running Docker containers and configuring services are set in a specification file named `docker-compose.yaml`, according to the [Docker documentation](https://docs.docker.com/compose/compose-file/).
For more information about how to run multiple Docker containers, see [{#T}](../solutions/docker-compose.md).

#### Sample Docker Compose specification {#compose-spec-example}

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

Specification keys are described in the following table:

| Key | Value |
| ----- | ----- |
| `version` | The specification version tag that the file should start with. |
| `services` | The section that describes the services. |
| `container_name` | The Docker container to run. |
| `image` | The Docker image to use to create and run a Docker container. |
| `ports` | Used for redirecting service ports. Specified in the format: `<PC port>:<container port>`. |
| `restart` | Docker container restart policy settings. |
| `volumes` | Description of the volumes used in the Docker container. |
| `x-yc-disks` | The section that describes the [disks](../../compute/concepts/disk.md) to attach. It's an [extension of the Docker Compose specification](https://docs.docker.com/compose/compose-file/#extension-fields). Used when preparing to run Docker containers, before running the Docker Compose file. Docker Compose skips this section. |
| `device_name` | Name of the device. |
| `fs_type` | File system type. Only ext4 and xfs file systems are supported. |
| `host_path` | The directory that the disk is mounted to. |
| `partition` | The used disk partition. |
