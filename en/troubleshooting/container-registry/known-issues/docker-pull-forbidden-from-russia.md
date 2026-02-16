---
noIndex: true
---

# Workaround for pulling images from Docker Hub

## Issue description {#issue-description}

When trying to pull an image using the `docker pull` command, you get this error message:

```bash
docker: Error response from daemon: 
error parsing HTTP 403 response body: invalid character '<' 
looking for beginning of value: 
"<html><body><h1>403 Forbidden</h1>\nSince Docker is a US company, 
we must comply with US export control regulations. 
In an effort to comply with these, we now block all IP addresses 
that are located in Cuba, Iran, North Korea, Republic of Crimea, Sudan, and Syria. 
If you are not in one of these cities, countries, or regions and are blocked, 
please reach out to https://hub.docker.com/support/contact/\n</body></html>\n".
See 'docker run --help'.
```

## Solution {#issue-resolution}

You can use any of the following solutions:

{% list tabs %}

- Add mirrors to the Docker configuration.


    You can add alternative Docker image registries to the Docker configuration.
    To do this, open the Docker configuration file and enter the URL addresses (mirrors within the `registry-mirrors` section) as a comma-separated list, e.g.:

    ```
    "registry-mirrors": ["https://mirror.gcr.io", "https://registry.docker-cn.com", "https://c.163.com/"] 

    ```

    The Docker configuration file path depends on the host operating system and superuser privileges:

    #|
    ||

    Operating system

    |

    Configuration file path

    ||
    ||

    Linux (with the `root` privileges)

    |

    `/etc/docker/daemon.json`

    ||
    ||

    Linux (without the `root` privileges)

    |

    `~/.config/docker/daemon.json`

    ||
    ||

    Windows

    |

    `%ProgramData%\docker\config\daemon.json`

    ||
    |#

- {{ GL }} dependency proxy 

    {% note alert %}
    
    Using third-party mirrors may involve risks of supply chain attacks. The mirror owner may manage the contents of popular images and substitute them at their own discretion. 

    {{ yandex-cloud }} bears no responsibility for the contents of third-party mirrors.

    {% endnote %}

    Alternatively, you can use the {{ GL }} dependency proxy. To do this, you need to create a new group first and then issue a new API key with the `read_registry` permissions in this group.

    To be able to pull the image you need using the Docker utility, use this command:

    ```
    docker pull gitlab.com/<GROUP_NAME>/dependency_proxy/containers/hello-world:latest
    ```

- {{ container-registry-name }} public mirror

    You can pull the majority of popular Docker images using our mirror that operates within {{ yandex-cloud }}.

    To do this, run this command:

    ```
    docker pull {{ registry }}/mirror/hello-world
    ```

- {{ container-registry-name }} private registry

    1. Use the command above to pull the Docker image to your local machine.
    1. [Push](../../../container-registry/operations/docker-image/docker-image-push.md) this Docker image to a {{ container-registry-full-name }} private registry as described in [this guide](../../../container-registry/operations/docker-image/docker-image-push.md).
    Make sure to replace the old Docker image URLs with the new ones in your CI/CD system.

{% endlist %}

{% note warning %}

DaemonSet for {{ managed-k8s-name }} that redirects requests to the `dockerhub.com` registry to a different mirror will be available soon.

We will notify you in this guide as soon as DaemonSet is ready.

{% endnote %}

## DaemonSet for {{ managed-k8s-name }}

Our support team prepared the DaemonSet object manifest for {{ k8s }} clusters. This DaemonSet creates a privileged pod within the cluster. This pod updates the `containerd` configuration so that requests to the `hub.docker.io` registry are redirected to `cr.yandex/mirror`.

You need to paste the manifest text to a YAML file and apply it to the cluster using the `kubectl apply -f filename.yaml` command:

```yaml

# Creating a namespace
---
apiVersion: v1
kind: Namespace
metadata:
  name: docker-mirror

# Creating a ConfigMap with config.toml for containerd
# Under [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"],
# defining mirrors. You can append the endpoint list.
---
apiVersion: v1
data:
  config.toml: |
    oom_score = -999
    version = 2

    [debug]
      level = "info"

    [plugins]
      [plugins."io.containerd.grpc.v1.cri".cni]
          bin_dir = "/home/kubernetes/cni/bin"
          conf_dir = "/etc/cni/net.d"

      [plugins."io.containerd.runtime.v1.linux"]
          runtime = "/home/kubernetes/bin/runc"
          shim = "/home/kubernetes/bin/containerd-shim"

      [plugins."io.containerd.grpc.v1.cri"]
          stream_server_address = "127.0.0.1"
          enable_tls_streaming = false
          sandbox_image = "{{ registry }}/crpsjg1coh47p81vh2lc/pause:3.9"
          [plugins."io.containerd.grpc.v1.cri".containerd]
              snapshotter = "overlayfs"

      [plugins."io.containerd.grpc.v1.cri".registry]
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
          [plugins."io.containerd.grpc.v1.cri".registry.mirrors."docker.io"]
            endpoint = ["https://{{ registry }}/v2/mirror/io/docker","https://mirror.gcr.io"]
kind: ConfigMap
metadata:
  name: configtoml
  namespace: docker-mirror

# Below is the DaemonSet manifest for running privileged pods, each of which is copying config.toml
# to etc/containerd/config.toml and restarting containerd one time.
# We added the section to run DaemonSet on nodes with taints. 
---
apiVersion: "apps/v1"
kind: DaemonSet
metadata:
  name: docker-mirror
  namespace: docker-mirror
  labels:
    app: docker-mirror
    version: 1v
spec:
  selector:
    matchLabels:
      app: docker-mirror
  template:
    metadata:
      labels:
        app: docker-mirror
    spec:
      schedulerName: default-scheduler
      priorityClassName: system-node-critical
      hostPID: true
      hostIPC: true
      containers:
      - name: config-updater
        image: {{ registry }}/yc/mk8s-openssl:stable
        command:
          - sh
          - -c
          - |
             cp /tmp/config.toml /host/etc/containerd/config.toml &&
             ps -x -o pid= -o comm= | awk '$2 ~ "^(containerd|dockerd)$" { print $1 }' | xargs kill
             sleep infinity
        imagePullPolicy: IfNotPresent
        securityContext:
          privileged: true
        resources:
          limits:
            memory: 200Mi
          requests:
            cpu: 100m
            memory: 200Mi
        volumeMounts:
        - name: containerd-config
          mountPath: /host/etc/containerd
        - name: config
          mountPath: /tmp
      volumes:
      - name: containerd-config
        hostPath:
          path: /etc/containerd
      - name: config
        configMap:
          name: configtoml
```