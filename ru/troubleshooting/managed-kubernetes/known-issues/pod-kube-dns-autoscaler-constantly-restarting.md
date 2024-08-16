# Под `kube-dns-autoscaler` постоянно перезапускается


## Описание проблемы {#issue-description}

После обновления {{ k8s }} и группы узлов с версии 1.21 до версии 1.22 под `kube-dns-autoscaler` начал постоянно перезапускаться.

## Решение {#issue-resolution}

Мы обновили `coredns` и `cluster-proportional-autoscaler` – в них изменилась нотация, и предыдущая версия `ConfigMap` перестала подходить. 

Для решения этой проблемы выполните следующие действия:

1. Снизьте количество реплик `kube-dns-autoscaler` до `0`:
  ```
  kubectl scale -n kube-system deploy kube-dns-autoscaler --replicas=0
  ```

1. [Добавьте к себе официальный репозиторий `cluster-proportional-autoscaler`](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/tree/master):
  ```
  helm repo add cluster-proportional-autoscaler [https://kubernetes-sigs.github.io/cluster-proportional-autoscaler](https://kubernetes-sigs.github.io/cluster-proportional-autoscaler "Внешняя ссылка (откроется в новом окне)")\
  helm repo update
  ```

1. Пользуясь нашими адаптированными `values`, установите `cluster-proportional-autoscaler`.
   
{% cut "Установка `cluster-proportional-autoscaler`" %}

  ```
  affinity: {}
  config:
  ladder:
    coresToReplicas:
      - [ 1, 1 ]
      - [ 64, 3 ]
      - [ 512, 5 ]
      - [ 1024, 7 ]
      - [ 2048, 10 ]
      - [ 4096, 15 ]
    nodesToReplicas:
      - [ 1, 1 ]
      - [ 2, 2 ]
  image:
    repository: registry.k8s.io/cpa/cluster-proportional-autoscaler
    pullPolicy: IfNotPresent
    tag:
  imagePullSecrets: []
  fullnameOverride:
  nameOverride:
  nodeSelector: {}
  options:
    alsoLogToStdErr:
    logBacktraceAt:
    logDir: {}
    logLevel:
    --v=6
    # Defaulting to true limits use of ephemeral storage
    logToStdErr: true
    maxSyncFailures:
    namespace: kube-system
    nodeLabels: {}
    #  label1: value1
    #  label2: value2
    pollPeriodSeconds:
    stdErrThreshold:
    target: deployment/coredns
    vmodule:
  podAnnotations: {}
  podSecurityContext:
    fsGroup: 65534
  replicaCount: 1
  resources:
    # We usually recommend not to specify default resources and to leave this as a conscious
    # choice for the user. This also increases chances charts run on environments with little
    # resources, such as Minikube. If you do want to specify resources, uncomment the following
    # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
    limits:
      cpu: 100m
      memory: 128Mi
    requests:
      cpu: 100m
      memory: 128Mi
  securityContext: {}
    # capabilities:
    #   drop:
    #   - ALL
    # readOnlyRootFilesystem: true
    # runAsNonRoot: true
    # runAsUser: 1000
  serviceAccount:
    create: true
    annotations: {}
    # The name of the service account to use.
    # If not set and create is true, a name is generated using the fullname template
    # If set and create is false, no service account will be created and the expectation is that the provided service account already exists or it will use the "default" service account
    name:
  tolerations: []
  priorityClassName: ""
  ```

  ```
  helm upgrade --install cluster-proportional-autoscaler\
  cluster-proportional-autoscaler/cluster-proportional-autoscaler --values values-cpa-dns.yaml
  ```

{% endcut %}