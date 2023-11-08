# Как настроить автоматическое удаление старых образов с узлов {{ managed-k8s-name }}


## Описание сценария {#case-description}

Во время эксплуатации кластера {{ managed-k8s-name }} замечено повышенное потребление дискового пространства на узлах кластера.
Свободное место на дисках узлов кластера периодически заканчивается.

Чтобы освободить место на диске, необходимо настроить автоматическое удаление старых образов с узлов {{ managed-k8s-name }}.
Требуется изменение конфигурации Garbage Collection в Kubernetes для очистки старых образов с нод (например, задать значения `image-gc-low-threshold` и `image-gc-high-threshold`).

## Решение {#case-resolution}

В конфигурации Garbage Collection у {{ managed-k8s-name }} установлены следующие стандартные значения :

* `--image-gc-high-threshold (85%)` — Отвечает за процент использования диска. При достижении заданного значения всегда выполняется сборка мусора образа.

* `--image-gc-low-threshold (80%)` — Отвечает за процент использования диска, до которого сборка мусора образа никогда не выполняется.

Значения параметров указаны в соответствии [с рекомендациями разработчиков Kubernetes](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet).
Очистка старых образов происходит автоматически. Поэтому, когда уровень использования диска достигает 85%, kubelet попытается уменьшить объём мусора до 80%.

Для автоматического удаления с нод старых образов сервисов кластера вы также можете использовать следующие спецификации:

{% cut "Спецификация для Docker Engine" %}

```(yaml)

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
            image:
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

{% cut "Спецификация для Containerd" %}

```(yaml)

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

## Если ничего не получилось {#if-issue-still-persists}

Если вышеописанные действия не помогли решить задачу, [создайте запрос в техническую поддержку]({{ link-console-support }}).
При создании запроса укажите следующую информацию:

1. Идентификатор кластера {{ managed-k8s-name }}.
2. Описание проблемы.
