

The [Jaeger](https://github.com/jaegertracing/jaeger) distributed tracing platform helps monitor request status in distributed microservice application systems.

In this article, you will learn how to install the Jaeger platform in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and configure it to work with [{{ ydb-full-name }}](../../ydb/):
1. [Install and configure Jaeger](#jaeger-install).
1. [Install a test application](#hotrod-install) to create load on a {{ k8s }} cluster.
1. [Test Jaeger](#jaeger-test) by making several test requests.


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to cluster nodes (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for a {{ ydb-name }} database in Dedicated mode: using computing resources allocated to the database and disk space (see [{{ ydb-name }} pricing](../../ydb/pricing/dedicated.md)).


## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install and configure Jaeger {#jaeger-install}

1. [Install](../../managed-kubernetes/operations/applications/jaeger.md#marketplace-install) [Jaeger over {{ ydb-short-name }}](/marketplace/products/yc/jaeger-ydb-store) from the {{ marketplace-full-name }} application catalog. When installing the application, select the default [namespace](../../managed-kubernetes/concepts/index.md#namespace) (`default`).
1. Make sure that all the Jaeger [pods](../../managed-kubernetes/concepts/index.md#pod) have entered the `Running` state:

   ```bash
   kubectl get pods | grep jaeger
   ```

1. Find out the name of the `jaeger-ydb-store-agent` [service](../../managed-kubernetes/concepts/service.md):

   ```bash
   kubectl get svc | grep ydb-store-agent
   ```

   Result:

   ```text
   <jaeger-ydb-store-agent_application_name> ClusterIP 10.2.238.190 ...
   ```

## Install a test application {#hotrod-install}

To test Jaeger, use the [HotROD](https://github.com/jaegertracing/jaeger/tree/9f067714451068c2ba136f5899077346abbc4c6c/examples/hotrod) application that simulates {{ k8s }} cluster load with several microservices.

1. Create a manifest named `hotrod.yaml` containing a description of the application:

   ```yaml
   ---
   apiVersion: v1
   kind: Pod
   metadata:
     name: hotrod
   spec:
     containers:
     - name: hotrod
       image: jaegertracing/example-hotrod:latest
       env:
       - name: JAEGER_AGENT_HOST
         value: "<jaeger-ydb-store-agent_application_name>.default.svc.cluster.local"
       - name: JAEGER_AGENT_PORT
         value: "6831"
       ports:
       - containerPort: 8080
       - containerPort: 8081
       - containerPort: 8082
       - containerPort: 8083
   ```

1. Create a pod with the `hotrod` application:

   ```bash
   kubectl apply -f hotrod.yaml
   ```

1. Make sure the `hotrod` pods have entered the `Running` state:

   ```bash
   kubectl get pods | grep hotrod
   ```

## Test Jaeger {#jaeger-test}

1. Find out the name of the `jaeger-ydb-store-query` service:

   ```bash
   kubectl get svc | grep jaeger-ydb-store-query
   ```

   Result:

   ```text
   <name_of_jaeger-ydb-store-query_application>  LoadBalancer  10.2.222.155  130.133.51.247  16686:31189/TCP ...
   ```

1. Configure `jaeger-ydb-store-query` port forwarding to the local computer:

   ```bash
   kubectl port-forward service/<name_of_jaeger-ydb-store-query_application> 16686:16686
   ```

1. In a different console window, configure port forwarding for the `hotrod` application to the local computer:

   ```bash
   kubectl port-forward hotrod 8080:8080
   ```

1. Open the [URI](https://localhost:8080) of the `hotrod` application in your browser and make several test requests to Jaeger.

    {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. Open [Jaeger's URI](https://localhost:16686) in your browser.

   Make sure that the test requests have been transmitted successfully and have been included in the trace.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ ydb-name }} database](../../ydb/operations/manage-databases.md#delete-db).
1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete](../../vpc/operations/address-delete.md) the cluster public static IP address if you reserved one.
