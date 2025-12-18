# How to set up autodeletion of old images from {{ managed-k8s-name }} nodes


## Case description {#case-description}

When using a {{ managed-k8s-name }} cluster, you see that the cluster nodes are running low on disk space. Cluster nodes periodically run out of available disk space.

To free up disk space, you need to set up autodeletion of old images from your {{ managed-k8s-name }} nodes.
You need to change the garbage collection configuration in {{ k8s }} to clean up old images, e.g., by setting the `image-gc-low-threshold` and `image-gc-high-threshold` values.

## Solution {#case-resolution}

The garbage collection in {{ managed-k8s-name }} has these standard settings:

* `--image-gc-high-threshold (85%)`: Disk usage percentage. Reaching the specified value triggers image garbage collection.
* `--image-gc-low-threshold (80%)`: Disk usage percentage below which the image garbage collection is not triggered.

The setting values are specified in accordance with the [{{ k8s }} developer guide](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet).

Old images are cleaned up automatically. Therefore, when the disk usage reaches 85%, kubelet will try to clean up the garbage to 80%.

For autodeletion of old images from cluster nodes, you can also use these specifications:

{% cut "Specification for Docker Engine" %}

```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: docker-image-cleanup
spec:
  schedule: "0 0 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: docker-image-cleanup
            image: alpine:latest
            command:
            - /bin/sh
            - -c
            - >
              echo y | docker image prune -f
            volumeMounts:
            - name: docker-socket
              mountPath: /var/run/docker.sock
          volumes:
          - name: docker-socket
            hostPath:
              path: /var/run/docker.sock
          restartPolicy: OnFailure
```

{% endcut %}

{% cut "Specification for Containerd" %}

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: imagecleanupconfig
  namespace: default
  labels:
    component: imagecleanup
data:
  # removes all images unused by a running container
  cronjobs: 0 0 * * * crictl rmi --prune 2>&1
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: imagecleanup
  namespace: default
spec:
  selector:
    matchLabels:
      component: imagecleanup
  template:
    metadata:
      labels:
        component: imagecleanup
    spec:
      volumes:
        - name: containerd
          hostPath:
            path: /var/run/containerd/containerd.sock
            type: Socket
        - name: imagecleanupconfig
          configMap:
            name: imagecleanupconfig
      containers:
        - name: imagecleanup
          image: alpine:latest
          imagePullPolicy: Always
          env:
            - name: CRICTL_VERSION
              value: v1.20.0
            - name: CONTAINER_RUNTIME_ENDPOINT
              value: unix:///var/run/containerd/containerd.sock
            - name: IMAGE_SERVICE_ENDPOINT
              value: unix:///var/run/containerd/containerd.sock
          # details of the command:
          # - install crictl
          # - add a cron job from the config map
          # - execute crond in the foregroud
          command:
            [
              "sh",
              "-c",
              "wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$CRICTL_VERSION/crictl-$CRICTL_VERSION-linux-amd64.tar.gz && tar zxvf crictl-$CRICTL_VERSION-linux-amd64.tar.gz -C /usr/local/bin && crontab /config/cronjobs && crond -f -d 8",
            ]
          resources:
            requests:
              cpu: 100m
              memory: 50Mi
          volumeMounts:
            - name: containerd
              mountPath: /var/run/containerd/containerd.sock
            - name: imagecleanupconfig
              mountPath: /config
---
```

{% endcut %}

## If nothing helped {#if-nothing-worked}

If the above actions did not help, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. {{ managed-k8s-name }} cluster ID.
1. Issue description.
