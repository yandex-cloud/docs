The [Jaeger](https://github.com/jaegertracing/jaeger) distributed tracing platform helps monitor request status in distributed microservice application systems.

In this article, you will learn how to install the Jaeger platform in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and configure it to work with [{{ ydb-full-name }}](../../ydb/):
1. [Install and configure Jaeger](#jaeger-install).
1. [Install a test application](#hotrod-install) to create load on a {{ k8s }} cluster.
1. [Test Jaeger](#jaeger-test) by making a few test requests.

## Before you start {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration with {{ k8s }} version 1.21 or higher.
1. [Install kubectl]{% if lang == "ru" %}(https://kubernetes.io/ru/docs/tasks/tools/install-kubectl){% endif %}{% if lang == "en" %}(https://kubernetes.io/docs/tasks/tools/install-kubectl){% endif %} and [configure it to work with the created cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-get-credetials.md).

## Install and configure Jaeger {#jaeger-install}

1. [Install Jaeger over YDB](../../managed-kubernetes/operations/applications/jaeger.md#marketplace-install) from the {{ marketplace-full-name }} application catalog. When installing the application, select the default [namespace](../../managed-kubernetes/concepts/index.md#namespace) (`default`).
1. Make sure that all the Jaeger [pods](../../managed-kubernetes/concepts/index.md#pod) have changed their state to `Running`:

   ```bash
   kubectl get pods | grep jaeger
   ```

1. Retrieve the [service](../../managed-kubernetes/concepts/service.md) name for `jaeger-ydb-store-agent`:

   ```bash
   kubectl get svc | grep ydb-store-agent
   ```

   Expected output:

   ```text
   <jaeger-ydb-store-agent application name> ClusterIP 10.2.238.190 ...
   ```

## Install a test application {#hotrod-install}

To test Jaeger, use the [HotROD](https://github.com/jaegertracing/jaeger/tree/9f067714451068c2ba136f5899077346abbc4c6c/examples/hotrod) application that simulates {{ k8s }} cluster load with several microservices.
1. Create a manifest called `hotrod.yaml` with the application description:

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
         value: "<jaeger-ydb-store-agent application name>.default.svc.cluster.local"
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

1. Make sure that the `hotrod` pod has changed its state to `Running`:

   ```bash
   kubectl get pods | grep hotrod
   ```

## Test Jaeger {#jaeger-test}

1. Retrieve the service name for `jaeger-ydb-store-query`:

   ```bash
   kubectl get svc | grep jaeger-ydb-store-query
   ```

   Expected output:

   ```text
   <jaeger-ydb-store-query application name>  LoadBalancer  10.2.222.155  130.133.51.247  16686:31189/TCP ...
   ```

1. Configure port forwarding for the `jaeger-ydb-store-query` service to redirect to the local machine:

   ```bash
   kubectl port-forward service/<jaeger-ydb-store-query application name> 16686:16686
   ```

1. In a different console window, configure port forwarding for the `hotrod` application to redirect to the local machine:

   ```bash
   kubectl port-forward hotrod 8080:8080
   ```

1. Open the `hotrod` [application URI](https://localhost:8080) in your browser:

   Make a few test requests to the Jaeger service.
1. Open the [Jaeger URI](https://localhost:16686) in your browser:

   Make sure that the test requests have been transmitted successfully and have been included in the trace.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:
1. [Delete the database {{ ydb-name }}](../../ydb/operations/manage-database.md#delete-db).
1. [Delete a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. If you reserved a public static IP address for the cluster, [delete it](../../vpc/operations/address-delete.md).