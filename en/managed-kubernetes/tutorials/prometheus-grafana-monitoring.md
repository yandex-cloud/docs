# Monitoring a cluster using {{ prometheus-name }} and {{ grafana-name }}

{{ managed-k8s-name }} enables you to upload cluster object metrics to monitoring systems.

In this article, you will learn how to set up the [{{ prometheus-name }}](https://prometheus.io/) metrics collection system and [{{ grafana-name }}](https://grafana.com/) visualization system in a {{ managed-k8s-name }} [cluster](../concepts/index.md#kubernetes-cluster). The [trickster caching proxy](https://github.com/trickstercache/trickster) will be installed to speed up the transfer of metrics.

To set up the {{ k8s }} cluster monitoring system:
* [{#T}](#install-prometheus).
* [{#T}](#install-trickster).
* [{#T}](#install-grafana).
* [{#T}](#configure-grafana).

## Before you begin {#before-you-begin}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with internet access.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. {% include [Install Helm](../../_includes/managed-kubernetes/helm-install.md) %}

## Install {{ prometheus-name }} {#install-prometheus}

The {{ prometheus-name }} monitoring system scans {{ k8s }} cluster objects and collects their metrics into its own database. The collected metrics are available within the cluster over HTTP.
1. Add a repository containing the {{ prometheus-name }} distribution:

   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
   helm repo update
   ```

1. Install {{ prometheus-name }}:

   ```bash
   helm install my-prom prometheus-community/prometheus
   ```

1. Make sure that all the pods changed their status to `Running`:

   ```bash
   kubectl get pods -l "app=prometheus"
   ```

   Command result:

   ```text
   NAME                                              READY  STATUS   RESTARTS  AGE
   my-prom-prometheus-alertmanager-7b8f48b99d-xt6ws  2/2    Running  0         81s
   my-prom-prometheus-node-exporter-pxpwg            1/1    Running  0         81s
   my-prom-prometheus-pushgateway-69f47c5f55-swrfb   1/1    Running  0         81s
   my-prom-prometheus-server-7b4c958476-m4v78        2/2    Running  0         81s
   ```

## Install the trickster caching proxy {#install-trickster}

Trickster [speeds up reading](https://github.com/trickstercache/trickster#time-series-database-accelerator) from a {{ prometheus-name }} database, which enables the display of near real-time {{ grafana-name }} metrics and reduces the load on {{ prometheus-name }}.
1. Add a repository containing the trickster distribution:

   ```bash
   helm repo add tricksterproxy https://helm.tricksterproxy.io && \
   helm repo update
   ```

1. Create a `trickster.yaml` configuration file with the following trickster settings:

   {% cut "trickster.yaml" %}

   ```yaml
   frontend:
     listenAddress: ""
     tlsListenAddress: ""
     tlsListenPort: ""
     connectionsLimit: "0"
   origins:
     - name: default
       originType: prometheus
       originURL: http://my-prom-prometheus-server:80
   profiler:
     enabled: false
     port: 6060
   prometheusScrape: false
   prometheus:
     serviceMonitor:
       enabled: false
       interval: 30s
       labels: {}
   replicaCount: 1
   image:
     repository: tricksterproxy/trickster
     tag: "1.1"
     pullPolicy: IfNotPresent
   service:
     annotations: {}
     labels: {}
     clusterIP: ""
     externalIPs: []
     loadBalancerIP: ""
     loadBalancerSourceRanges: []
     metricsPort: 8481
     servicePort: 8480
     type: ClusterIP
   ingress:
     enabled: false
     annotations: {}
     extraLabels: {}
     hosts: []
     tls: []
   volumes:
     persistent:
       type: "persistentVolume"
       enabled: false
       mountPath: "/tmp/trickster"
       accessModes:
         - ReadWriteOnce
       annotations: {}
       existingClaim: ""
       size: 15Gi
     generic:
       type: "generic"
       enabled: true
       mountPath: "/tmp/trickster"
   podAnnotations: {}
   resources: {}
   securityContext: {}
   ```

   {% endcut %}

   You can change the size of the storage allocated to the caching proxy. Specify the desired storage size in the `volumes.persistent.size` parameter.
1. Install Trickster:

   ```bash
   helm install trickster tricksterproxy/trickster --namespace default -f trickster.yaml
   ```

1. Make sure the trickster pod status changed to `Running`:

   ```bash
   kubectl get pods -l "app=trickster"
   ```

The caching proxy is available in the cluster at `http://trickster:8480`. {{ grafana-name }} will use this URL to collect metrics.

## Install {{ grafana-name }} {#install-grafana}

When deploying the application, the following will be created:
* {{ grafana-name }} application `Deployment`.
* [PersistentVolumeClaim](../concepts/volume.md#persistent-volume) to reserve internal storage.
* `LoadBalancer` `Service` to enable network access to the {{ grafana-name }} management console.

To install {{ grafana-name }}:
1. Create a `grafana.yaml` configuration file.

   {% cut "grafana.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: PersistentVolumeClaim
   metadata:
     name: grafana-pvc
   spec:
     accessModes:
       - ReadWriteOnce
     resources:
       requests:
         storage: 1Gi
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     labels:
       app: grafana
     name: grafana
   spec:
     selector:
       matchLabels:
         app: grafana
     template:
       metadata:
         labels:
           app: grafana
       spec:
         securityContext:
           fsGroup: 472
           supplementalGroups:
             - 0
         containers:
           - name: grafana
             image: grafana/grafana:latest
             imagePullPolicy: IfNotPresent
             ports:
               - containerPort: 3000
                 name: http-grafana
                 protocol: TCP
             readinessProbe:
               failureThreshold: 3
               httpGet:
                 path: /robots.txt
                 port: 3000
                 scheme: HTTP
               initialDelaySeconds: 10
               periodSeconds: 30
               successThreshold: 1
               timeoutSeconds: 2
             livenessProbe:
               failureThreshold: 3
               initialDelaySeconds: 30
               periodSeconds: 10
               successThreshold: 1
               tcpSocket:
                 port: 3000
               timeoutSeconds: 1
             resources:
               requests:
                 cpu: 250m
                 memory: 750Mi
             volumeMounts:
               - mountPath: /var/lib/grafana
                 name: grafana-pv
         volumes:
           - name: grafana-pv
             persistentVolumeClaim:
               claimName: grafana-pvc
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: grafana
   spec:
     ports:
       - port: 3000
         protocol: TCP
         targetPort: http-grafana
     selector:
       app: grafana
     sessionAffinity: None
     type: LoadBalancer
   ```

   {% endcut %}

   If required, change:
   * The size of the storage allocated for {{ grafana-name }} in the `spec.resources.requests.storage` parameter for `kind: PersistentVolumeClaim`.
   * Computing resources allocated to the {{ grafana-name }} pod in the `spec.containers.resources` parameters for `kind: Deployment`.
1. Install {{ grafana-name }}:

   ```bash
   kubectl apply -f grafana.yaml
   ```

1. Make sure that the {{ grafana-name }} pod status changed to `Running`:

   ```bash
   kubectl get pods -l "app=grafana"
   ```

## Set up and check {{ grafana-name }} {#configure-grafana}

1. Find the address where {{ grafana-name }} is available and go to it:

   ```bash
   export GRAFANA_IP=$(kubectl get service/grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}') && \
   export GRAFANA_PORT=$(kubectl get service/grafana -o jsonpath='{.spec.ports[0].port}') && \
   echo http://$GRAFANA_IP:$GRAFANA_PORT
   ```

1. In the browser window that opens, enter your `admin/admin` username and password and then set a new password for the `admin` user.
1. [Add a data source](https://grafana.com/docs/grafana/latest/datasources/add-a-data-source/) with the `{{ prometheus-name }}` type and the following settings:
   * **Name**: `{{ prometheus-name }}`.
   * **URL**: `http://trickster:8480`.
1. Click **Save & test** and make sure that the data source was successfully connected (`Data source is working`).
1. [Import the `{{ k8s }} Deployment Statefulset Daemonset metrics` dashboard](https://grafana.com/docs/grafana/latest/dashboards/export-import/#import-dashboard), which contains basic {{ k8s }} metrics. Specify the [dashboard ID](https://grafana.com/grafana/dashboards/8588) (`8588`) when importing.

   {% note tip %}

   To check the scenario, you can use any suitable dashboard from the [{{ grafana-name }} catalog](https://grafana.com/grafana/dashboards/?search=kubernetes).

   {% endnote %}

1. Open the dashboard and make sure that {{ grafana-name }} receives metrics from the {{ managed-k8s-name }} cluster.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved a [public static IP address](../../vpc/concepts/address.md#public-addresses) for the cluster, [delete it](../../vpc/operations/address-delete.md).