# {{ coi }}

_{{ coi }}_ is an [image](../../compute/concepts/image.md) that is optimized for running Docker containers. The image includes Ubuntu LTS, Docker, and a daemon for launching Docker containers.

It's integrated with the Yandex.Cloud platform, that allows you to:

- Run a Docker container immediately after the VM is created from the management console or YC CLI.
- Update running Docker containers with minimum downtime.
- Access Docker container opened network ports without any additional settings.

Learn more about working with a {{ coi }} in [{#T}](../solutions/vm-create.md).

## Specifics of working with a boot disk {#boot-disk}

* When creating a VM from a {{ coi }}, you can't create a boot disk from a disk snapshot.
* By default, when creating a VM from an image, a disk is created that is the same size as the image. However, since the purpose of a VM with a {{ coi }} is to run a Docker container, there may not be enough free space when deploying the Docker container. To avoid this, explicitly specify the required size of the boot disk using the `--create-boot-disk size=<disk size in GB>` flag.

## Docker image {#docker-image}

When creating a VM with a {{ coi }}, you can specify the Docker image to use for launching a Docker container.
This Docker image can be pulled from both the public Docker image registry and the {{ container-registry-name }}. If you access the Docker image via the {{ container-registry-name }}, the service account linked to the VM will be used.

Examples of Docker image names for different registries:

- Docker Hub: `ubuntu:16.04`.
- {{ container-registry-name }}: `cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:16.04`.

## Policies for restarting a Docker container {#restart-policy}

You can specify the Docker container restart policies in its description:

- `Always`: Always restart the Docker container when it's stopped. If the Docker container is stopped manually, it restarts only when the Docker daemon restarts.
- `Never`: Don't restart the Docker container automatically.
- `OnFailure`: Restart the Docker container only if it is shut down with a non-zero return code.

If the Docker container description in the metadata changed when restarting the VM, the specified restart policy is ignored
and a Docker container that corresponds to the new description is started.

## Docker container specifications {#coi-specification}

In a {{ coi }}, the Docker container is described with a specification (YAML file) based on a [{{ k8s }} PodSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#pod-v1-core).

When [creating a VM from a {{ coi }}](../solutions/vm-create.md) from the management console or YC CLI, the specification file is generated automatically
using the specified data. When [creating an instance group from a {{ coi }}](../solutions/ig-create.md), you set the specifications manually. A sample specification file and required keys are described below.

#### Sample Docker container specification {#spec-example}

{% note info %}

In this specification file, you can't run multiple Docker containers. For more information about how to run multiple Docker containers, see [{#T}](../solutions/docker-compose.md).

{% endnote %}

The specification is a YAML file with the following contents:

```
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

