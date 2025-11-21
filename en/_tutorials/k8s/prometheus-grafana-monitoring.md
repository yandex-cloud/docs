# Cluster monitoring with {{ prometheus-name }} and {{ grafana-name }}

{{ managed-k8s-name }} enables you to export cluster object metrics to monitoring systems.

In this tutorial, you will learn how to configure the [{{ prometheus-name }}](https://prometheus.io/) monitoring system and the [{{ grafana-name }}](https://grafana.com/) visualization system in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster). To speed up metric delivery, you will install [Trickster](https://github.com/trickstercache/trickster), a reverse proxy cache.

To set up the monitoring system for your {{ managed-k8s-name }} cluster:

* [Install {{ prometheus-name }}](#install-prometheus).
* [Install Trickster](#install-trickster).
* [Install {{ grafana-name }}](#install-grafana).
* [Configure and test {{ grafana-name }}](#configure-grafana).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost for this solution includes:

* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address for cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with internet access and the security groups you set up earlier.
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. {% include [Install Helm](../../_includes/managed-kubernetes/helm-install.md) %}

## Install {{ prometheus-name }} {#install-prometheus}

{{ prometheus-name }} scans {{ managed-k8s-name }} cluster objects and saves their metrics to its own database. These metrics are available within the {{ managed-k8s-name }} cluster over HTTP.
1. Add the repository that contains the {{ prometheus-name }} distribution:

   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts && \
   helm repo update
   ```

1. Install {{ prometheus-name }}:

   ```bash
   helm install my-prom prometheus-community/prometheus
   ```

1. Make sure all [pods](../../managed-kubernetes/concepts/index.md#pod) switched to `Running`:

   ```bash
   kubectl get pods -l "app.kubernetes.io/instance=my-prom"
   ```

   Result:

   ```text
   NAME                                              READY  STATUS   RESTARTS  AGE
   my-prom-prometheus-alertmanager-7b********-xt6ws  2/2    Running  0         81s
   my-prom-prometheus-node-exporter-*****            1/1    Running  0         81s
   my-prom-prometheus-pushgateway-69********-swrfb   1/1    Running  0         81s
   my-prom-prometheus-server-7b********-m4v78        2/2    Running  0         81s
   ```

## Install Trickster {#install-trickster}

Trickster [accelerates data reads](https://github.com/trickstercache/trickster#time-series-database-accelerator) from the {{ prometheus-name }} database, which enables near real-time metric visualization in {{ grafana-name }} and reduces the load on {{ prometheus-name }}.

1. Create a configuration file named `trickster.yaml` that contains Trickster settings:

   {% cut "trickster.yaml" %}

   ```yaml
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: trickster-pvc
    spec:
      accessModes:
        - ReadWriteOnce
      storageClassName: yc-network-hdd
      resources:
        requests:
          storage: 15Gi
    
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: trickster-conf
      labels:
        name: trickster-conf
    
    data:
      trickster.conf: |-
        [frontend]
        listen_port = 8480
        tls_listener = false
        connections_limit = 0
        [logging]
        log_level = "info"
    
        [caching]
        cache_type = "filesystem"
        filesystem_path = "/tmp/trickster"
    
        [proxy]
        origin = "default"
    
        [origins.default]
        origin_type = "prometheus"
        origin_url = "http://my-prom-prometheus-server:80"
        is_default = true
    
        [metrics]
        listen_port = 8481
        listen_address = ""
    
        [health]
        listen_port = 8481
        listen_address = ""
    
        [telemetry]
        prometheus_metrics = false
    
        [logging.profiler]
        enabled = false
        port = 6060
    
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: trickster
      labels:
        app: trickster
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: trickster
      template:
        metadata:
          labels:
            app: trickster
        spec:
          containers:
            - name: trickster
              image: tricksterproxy/trickster:1.1
              imagePullPolicy: IfNotPresent
              args:
                - -config
                - /etc/trickster/trickster.conf
              ports:
                - name: http
                  containerPort: 8480
                  protocol: TCP
                - name: metrics
                  containerPort: 8481
                  protocol: TCP
              volumeMounts:
                - name: config-volume
                  mountPath: /etc/trickster
                  readOnly: true
                - name: cache-volume
                  mountPath: /tmp/trickster
              env:
                - name: NAMESPACE
                  valueFrom:
                    fieldRef:
                      fieldPath: metadata.namespace
          volumes:
            - name: config-volume
              configMap:
                name: trickster-conf
                items:
                  - key: trickster.conf
                    path: trickster.conf
            - name: cache-volume
              persistentVolumeClaim:
                claimName: trickster-pvc
    
    ---
    apiVersion: v1
    kind: Service
    metadata:
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "8481"
        prometheus.io/path: "/metrics"
      name: trickster
    spec:
      ports:
        - name: http
          port: 8480
          targetPort: http
        - name: metrics
          port: 8481
          targetPort: metrics
      selector:
        app: trickster
   ```

   {% endcut %}

   You can change the size of the storage allocated to the caching proxy. Specify the storage size you need in the `PersistentVolumeClaim.spec.resources.requests.storage` parameter.
1. Install Trickster:

   ```bash
   kubectl apply -f trickster.yaml
   ```

1. Make sure the Trickster pod status changed to `Running`:

   ```bash
   kubectl get pods -l "app=trickster"
   ```

The caching proxy is available in the {{ managed-k8s-name }} cluster at `http://trickster:8480`. {{ grafana-name }} will use this URL to retrieve metrics.

## Install {{ grafana-name }} {#install-grafana}

When installing the app, the system will create:
* {{ grafana-name }} `Deployment`.
* [PersistentVolumeClaim](../../managed-kubernetes/concepts/volume.md#persistent-volume) to reserve internal storage.
* `Service` of the `LoadBalancer` type to enable network access to the {{ grafana-name }} management console.

To install {{ grafana-name }}:
1. Create a configuration file named `grafana.yaml`.

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

   Change the following as needed:
   * Storage size allocated for {{ grafana-name }} in the `spec.resources.requests.storage` parameter for `kind: PersistentVolumeClaim`.
   * Computing resources allocated to the {{ grafana-name }} pod in the `spec.containers.resources` parameters for `kind: Deployment`.
1. Install {{ grafana-name }}:

   ```bash
   kubectl apply -f grafana.yaml
   ```

1. Make sure the {{ grafana-name }} pod status changed to `Running`:

   ```bash
   kubectl get pods -l "app=grafana"
   ```

## Configure and test {{ grafana-name }} {#configure-grafana}

1. Get the current {{ grafana-name }} address and open it in your browser:

   ```bash
   export GRAFANA_IP=$(kubectl get service/grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}') && \
   export GRAFANA_PORT=$(kubectl get service/grafana -o jsonpath='{.spec.ports[0].port}') && \
   echo http://$GRAFANA_IP:$GRAFANA_PORT
   ```

   {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. In the browser window that opens, enter your `admin/admin` username and password, and then set a new password for `admin`.
1. [Add a data source](https://grafana.com/docs/grafana/latest/datasources/add-a-data-source/) of the `{{ prometheus-name }}` type configured as follows:
   * **Name**: `{{ prometheus-name }}`.
   * **URL**: `http://trickster:8480`.
1. Click **Save & test** and make sure the data source was successfully connected (`Data source is working`).
1. [Import](https://grafana.com/docs/grafana/latest/dashboards/export-import/#import-dashboard) the `{{ k8s }} Deployment Statefulset Daemonset metrics` dashboard containing the basic {{ k8s }} metrics. Specify the [dashboard ID](https://grafana.com/grafana/dashboards/8588) (`8588`) when importing.

   {% note tip %}

   To test the scenario, you can use any suitable dashboard from the [{{ grafana-name }} library](https://grafana.com/grafana/dashboards/?search=kubernetes).

   {% endnote %}

1. Open the dashboard and make sure {{ grafana-name }} is receiving metrics from the {{ managed-k8s-name }} cluster.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete](../../vpc/operations/address-delete.md) the [public static IP address](../../vpc/concepts/address.md#public-addresses) for your {{ managed-k8s-name }} cluster if you reserved one.
1. [Delete the disk](../../compute/operations/disk-control/delete.md) created for the `trickster` storage. You can identify it by the label in the disk description. To get the label, use the `kubectl describe pvc trickster-pvc` command: the label will match the value in the `Volume` field.
