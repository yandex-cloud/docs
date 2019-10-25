# Image {{ coi }}

_{{ coi }}_ is an [image](../../compute/concepts/image.md) that is optimized for running Docker containers. The image includes Ubuntu LTS, Docker, and a daemon for launching Docker containers.

It's integrated with the Yandex.Cloud platform, which allows you to:

- Run a Docker container immediately after the VM is created from the management console or YC CLI.
- Update running Docker containers with minimum downtime.
- Access Docker container open network ports without any additional configuration.

Learn more about working with a {{ coi }} in [{#T}](../operations/coi/vm-create.md).

## Docker image {#docker-image}

When creating a VM with a {{ coi }}, you can specify the Docker image to use to launch a Docker container.
This image can be pushed to both the public Docker image registry and the {{ container-registry-name }}. If you access the Docker image via the {{ container-registry-name }}, the service account linked to the VM will be used.

Examples of Docker image names for different registries:

- Docker Hub: `ubuntu:16.04`.
- {{ container-registry-name }}: `cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:hello`.

## Policies for restarting a Docker container {#restart-policy}

You can specify the Docker container restart policies in its description:

- `Always`: Always restart the container when it's stopped. If the container is stopped manually, it restarts only when restarting the Docker daemon.
- `Never`: Don't restart the container automatically.
- `OnFailure`: Restart the container only if it shut down with a non-zero return code.

If the Docker container description in the metadata changed when restarting the VM, the specified restart policy is ignored
and a Docker container that corresponds to a new description is started.

## Docker container specifications {#coi-specification}

In a {{ coi }}, the Docker container is described in a specification (YAML file) based on a [pod spec {{ k8s }}](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.15/#pod-v1-core).

When you [create a VM from a {{ coi }}](../operations/coi/vm-create.md) from the management console or YC CLI, the service generates a specification automatically using the specified data. When [creating an instance group from a {{ coi }}](../operations/coi/ig-create.md), you set the specification manually. A sample specification and required keys are described below.

#### Sample Docker container specification {#spec-example}

{% note info %}

You can't run multiple Docker containers. There should only be one Docker container in the specification.

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
    image: cr.yandex/mirror/ubuntu:16.04
    name: my-container
    securityContext:
      privileged: false
    stdin: false
    tty: false
  restartPolicy: Always
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

