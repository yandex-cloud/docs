# Constant restarts of the kube-dns-autoscaler pod


## Issue description {#issue-description}

After updating Kubernetes and node groups from version 1.21 to version 1.22, `kube-dns-autoscaler` began restarting constantly.

## Solution {#issue-resolution}

We have updated `coredns` and `cluster-proportional-autoscaler`: the notation has changed in them, and the previous `ConfigMap` version is no longer supported.

To resolve this issue:

1. Reduce the number of `kube-dns-autoscaler` replicas to `0`:

```text
kubectl scale -n kube-system deploy kube-dns-autoscaler --replicas=0
```

2. [Add the official `cluster-proportional-autoscaler` repository to your deployment](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/tree/master):

```text
helm repo add cluster-proportional-autoscaler [https://kubernetes-sigs.github.io/cluster-proportional-autoscaler](https://kubernetes-sigs.github.io/cluster-proportional-autoscaler "External link (will open in a new window)")\
helm repo update
```

3. Using our adapted `values`, install `cluster-proportional-autoscaler`:

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

```text
helm upgrade --install cluster-proportional-autoscaler\
cluster-proportional-autoscaler/cluster-proportional-autoscaler --values values-cpa-dns.yaml
```
