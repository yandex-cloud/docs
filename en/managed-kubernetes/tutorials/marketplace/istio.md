---
title: Using Istio
description: In this tutorial, you will learn how to use Istio.
---

# Using Istio


[Istio](https://istio.io/latest/about/service-mesh/) implements a _service mesh_, a low-latency infrastructure layer used to process a massive volume of network communications between services in a {{ managed-k8s-name }} cluster.

To view Istio usage options:

1. [Install Istio](#istio-install).
1. [Install a test application](#test-application).
1. [View a service network diagram on the Kiali dashboard](#visualization-service-network).
1. [Route requests](#request-routing).
1. [Simulate a service failure](#injection-failures).
1. [Redistribute traffic](#traffic-redistribution).
1. [Set up mutual TLS authentication](#mutual-tls).
1. [View Istio metrics on the {{ prometheus-name }} dashboard](#viewing-metrics-prometheus).
1. [View Istio metrics on the {{ grafana-name }} dashboard](#viewing-metrics-grafana).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create a {{ k8s }} cluster and [node group](../../../managed-kubernetes/concepts/index.md#node-group).

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. If you do not have a [network](../../../vpc/concepts/network.md#network) yet, [create one](../../../vpc/operations/network-create.md).
        1. If you do not have any [subnets](../../../vpc/concepts/network.md#subnet) yet, [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
        1. [Create service accounts](../../../iam/operations/sa/create.md):

            * Service account with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../security/index.md#yc-api) for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where the {{ k8s }} cluster is created. This service account will be used to create the resources required for the {{ k8s }} cluster.
            * Service account with the [{{ roles-cr-puller }}](../../../container-registry/security/index.md#container-registry-images-puller) [role](../../../iam/concepts/access-control/roles.md). Nodes will pull the required [Docker images](../../../container-registry/concepts/docker-image.md) from the [registry](../../../container-registry/concepts/registry.md) on behalf of this account.

            {% note tip %}

            You can use the same [service account](../../../iam/concepts/users/service-accounts.md) to manage your {{ k8s }} cluster and its node groups.

            {% endnote %}

        1. {% include [configure-sg-manual](../../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

            {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. [Create a {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../../managed-kubernetes/operations/node-group/node-group-create.md) with at least 6 GB of RAM and the security groups created earlier.

    - {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [k8s-cluster.tf](https://github.com/yandex-cloud-examples/yc-mk8s-cluster-infrastructure/blob/main/k8s-cluster.tf) cluster configuration file to the same working directory. The file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * {{ k8s }} cluster.
            * [Service account](../../../iam/concepts/users/service-accounts.md) required for the {{ managed-k8s-name }} cluster and node group to operate.
            * {% include [configure-sg-terraform](../../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

                {% include [sg-common-warning](../../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        1. Specify the following in the `k8s-cluster.tf` file:

            * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
            * {{ k8s }} version for the {{ k8s }} cluster and node groups.
            * At least 6 GB of RAM for your node group. The value must be a multiple of the number of vCPUs.
            * {{ k8s }} cluster CIDR.
            * Name of the {{ managed-k8s-name }} cluster service account.

        1. Check that the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. {% include [Install and configure kubectl](../../../_includes/managed-kubernetes/kubectl-install.md) %}

## Install Istio {#istio-install}

1. [Install](../../operations/applications/istio.md#marketplace-install) [Istio](/marketplace/products/yc/istio) from the {{ marketplace-full-name }} application catalog. When installing the application:

    1. Create a new [namespace](../../concepts/index.md#namespace) called `istio-system`.
    1. Install Istio add-ons: Kiali, {{ prometheus-name }}, {{ grafana-name }}, Loki, Jaeger.

1. Make sure all the [pods](../../concepts/index.md#pod) of Istio and its add-ons have changed their status to `Running`:

    ```bash
    kubectl get pods -n istio-system
    ```

    Result:

    ```text
    NAME                                    READY   STATUS    RESTARTS   AGE
    grafana-75c6d4fcf7-v4sfp                1/1     Running   0          2h
    istio-ingressgateway-6496999d57-hdbnf   1/1     Running   0          2h
    istiod-665dbb97c9-s6xxk                 1/1     Running   0          2h
    jaeger-5468d9c886-x2bq8                 1/1     Running   0          2h
    kiali-6854cc8574-26t65                  1/1     Running   0          2h
    loki-0                                  1/1     Running   0          2h
    prometheus-54f86f6676-vmqqr             2/2     Running   0          2h
    ```

## Install a test application {#test-application}

1. Create a new namespace called `todoapp`:

    ```bash
    kubectl create namespace todoapp
    ```

1. Add the `istio-injection` label to the `todoapp` namespace:

    ```bash
    kubectl label namespace todoapp istio-injection=enabled
    ```

1. Install the `todoapp` test application:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/todoapp.yaml -n todoapp
    ```

    Result:

    ```text
    deployment.apps/todoapp-v1 created
    deployment.apps/todoapp-v2 created
    deployment.apps/recommender-v1 created
    deployment.apps/todoapp-redis-v1 created
    service/todoapp created
    service/recommender created
    service/todoapp-redis created
    ```

1. Check the pod status:

    ```bash
    kubectl get pods -n todoapp
    ```

    Result:

    ```text
    NAME                                READY   STATUS    RESTARTS   AGE
    recommender-v1-7865c4cfbb-hsp2k     2/2     Running   0          60s
    recommender-v1-7865c4cfbb-vqt68     2/2     Running   0          59s
    todoapp-redis-v1-dbdf4d44-48952     2/2     Running   0          59s
    todoapp-v1-6d4b78b6c9-gfkxd         2/2     Running   0          60s
    todoapp-v1-6d4b78b6c9-jc962         2/2     Running   0          60s
    todoapp-v2-7dd69b445f-2rznm         2/2     Running   0          60s
    todoapp-v2-7dd69b445f-gr4vn         2/2     Running   0          60s
    ```

    Make sure all the pods have changed their status to `Running` and `READY=2/2`.

1. Check the status of services:

    ```bash
    kubectl get services -n todoapp
    ```

    Result:

    ```text
    NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    recommender     ClusterIP   10.96.255.93    <none>        80/TCP     80s
    todoapp         ClusterIP   10.96.232.143   <none>        80/TCP     80s
    todoapp-redis   ClusterIP   10.96.174.100   <none>        6379/TCP   80s
    ```

1. Make sure that the web app is up and running:

    ```bash
    kubectl exec "$(kubectl get pod -l app=recommender -n todoapp -o jsonpath='{.items[0].metadata.name}')" -n todoapp \
       -- curl --silent --show-error todoapp:80 | grep -o "<title>.*</title>"
    ```

    Result:

    ```text
    <title>Todoapp</title>
    ```

1. Publish the app:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/todoapp-gateway.yaml -n todoapp
    ```

    Result:

    ```text
    gateway.networking.istio.io/todoapp-gateway created
    virtualservice.networking.istio.io/todoapp-vs created
    ```

1. Get the Ingress gateway IP to access the app:

    ```bash
    kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
    ```

1. To run the web app, paste the obtained IP into the browser address bar.

    {% include [Configuring security groups if resource is unavailable](../../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

    Each time the page is refreshed, its content will be updated. Depending on the version of the pod processing your request, you will see:

    * Pod version `v1`: To-do list section.
    * Pod version `v2`: To-do list section and recommendations section.

## View a service network diagram on the Kiali dashboard {#visualization-service-network}

1. Make sure `kiali` is installed and available in the {{ managed-k8s-name }} cluster:

    ```bash
    kubectl get service kiali -n istio-system
    ```

    Result:

    ```text
    NAME    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)              AGE
    kiali   ClusterIP   10.96.207.108   <none>        20001/TCP,9090/TCP   15d
    ```

1. Configure `kiali` port forwarding to the local computer:

    ```bash
    kubectl port-forward service/kiali 8080:20001 -n istio-system
    ```

1. To open the Kiali dashboard, paste `http://localhost:8080` into the browser address bar.

    The Kiali dashboard provides various information, such as the service network diagram, Istio configuration, service configuration and status, as well as pod metrics, traces, and logs.

1. To generate traffic to your [test app](#test-application), play around with it. For example, add a to-do list.

1. Open the Kiali dashboard, go to **Graph**, and select the **todoapp** namespace. You will see a diagram with the test app components running in the Istio service network.

    {% note tip %}

    Use the Kiali dashboard to track changes in the next steps of this tutorial. For example, you can see how the display of services or traffic distribution changes.

    {% endnote %}

## Route service requests {#request-routing}

`todoapp` pods are deployed in versions `v1` and `v2` in parallel. When you refresh the [test app](#test-application) page, the recommendations panel is sometimes not displayed, as only the `todoapp` `v2` pods make requests to the service and show the results.

Use routing to route users to a specific service version:

1. Route all requests to `v1`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-route-v1.yaml -n todoapp
    ```

    Result:

    ```text
    destinationrule.networking.istio.io/todoapp-dr created
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Refresh the test app page several times. Now all requests are handled by the `v1` pods. The page only shows the to-do list.

1. Route all requests to `v2`:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-route-v2.yaml -n todoapp
    ```

    Result:

    ```text
    destinationrule.networking.istio.io/todoapp-dr unchanged
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Refresh the test app page several times. Now all requests are handled by the `v2` pods. The page shows the to-do list and recommendations sections.

To cancel routing, run the command below:

```bash
kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/todoapp-gateway.yaml -n todoapp
```

Result:

```text
gateway.networking.istio.io/todoapp-gateway unchanged
virtualservice.networking.istio.io/todoapp-vs configured
```

## Simulate a service failure {#injection-failures}

With Istio, you can test your app's reliability by simulating service failures.
When accessing `recommender`, there is a 3-second timeout. If the service does not respond within this time, the recommendations section is not displayed.

You can simulate a failure by specifying a timeout longer than 3 seconds in the `VirtualService` resource configuration. For example, this code block implements a 50-percent probability of a 5-second delay:

```yaml
fault:
  delay:
    percentage:
      value: 50.0
    fixedDelay: 5s
```

To simulate a failure of your [test app](#test-application):

1. Apply the `VirtualService` configuration:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-delay.yaml -n todoapp
    ```

    Result:

    ```text
    destinationrule.networking.istio.io/recommender-dr created
    virtualservice.networking.istio.io/recommender-vs created
    ```

1. Refresh the test app page several times. When there is a response delay, the recommendations section is not displayed, although the request is handled by the `v2` pod. The app handles a failure of `recommender` correctly.

To roll back the `VirtualService` configuration, run this command:

```bash
kubectl delete -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-delay.yaml -n todoapp
```

Result:

```text
destinationrule.networking.istio.io "recommender-dr" deleted
virtualservice.networking.istio.io "recommender-vs" deleted
```

## Redistribute traffic {#traffic-redistribution}

When upgrading the microservice version, you can redistribute traffic between its versions without affecting the number of application pods. You can manage traffic routes using the `weight` parameter of the `VirtualService` resource.

To redistribute traffic in your [test app](#test-application):

1. Set the weight for `v1` and `v2` to 50%:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-weight-v2-50.yaml -n todoapp
    ```

    Result:

    ```text
    destinationrule.networking.istio.io/todoapp-dr unchanged
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Refresh the test app page several times. The app is handled by the `v1` and `v2` pod versions in roughly equal proportions.

1. Increase the weight for `v2` to 100%:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/virtualservice-weight-v2-100.yaml -n todoapp
    ```

    Result:

    ```text
    destinationrule.networking.istio.io/todoapp-dr unchanged
    virtualservice.networking.istio.io/todoapp-vs configured
    ```

1. Refresh the test app page several times. The app is only handled by the `v2` pods.

## Set authentication mode using mutual TLS {#mutual-tls}

By default, applications running an Istio sidecar proxy exchange traffic with mutual TLS encryption.

You can configure a strict authentication policy by prohibiting unencrypted traffic from applications that use no Istio sidecar proxy.

To test how your [test app](#test-application) runs in different modes:

1. Create an authentication policy:

    ```bash
    kubectl apply -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/peerauthentication.yaml -n todoapp
    ```

    Result:

    ```text
    peerauthentication.security.istio.io/default created
    ```

1. Try creating a pod in the `default` namespace to test a connection to `todoapp`:

    ```bash
    kubectl run -i -n default \
       --rm \
       --restart=Never curl \
       --image=curlimages/curl \
       --command \
       -- sh -c 'curl --insecure http://todoapp.todoapp.svc.cluster.local'
    ```

    Result:

    ```text
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
      0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
    curl: (56) Recv failure: Connection reset by peer
    pod "curl" deleted
    pod default/curl terminated (Error)
    ```

1. Delete the authentication policy:

    ```bash
    kubectl delete -f https://raw.githubusercontent.com/yandex-cloud-examples/yc-mk8s-todo-app/main/kube/peerauthentication.yaml -n todoapp
    ```

    Result:

    ```text
    peerauthentication.security.istio.io "default" deleted
    ```

1. Try creating a pod once again:

    ```bash
    kubectl run -i -n default \
       --rm \
       --restart=Never curl \
       --image=curlimages/curl \
       --command \
       -- sh -c 'curl --insecure http://todoapp.todoapp.svc.cluster.local'
    ```

    Result:

    ```text
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  2658  100  2658    0     0   147k      0 --:--:-- --:--:-- --:--:--  152k
    <!DOCTYPE html>
    <html lang="ru">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Todoapp</title>
    ...
    ```

## View Istio metrics on the {{ prometheus-name }} dashboard {#viewing-metrics-prometheus}

1. Make sure `prometheus` is installed and available in the {{ managed-k8s-name }} cluster:

    ```bash
    kubectl get service prometheus -n istio-system
    ```

    Result:

    ```text
    NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
    prometheus   ClusterIP   10.96.147.249   <none>        9090/TCP   15d
    ```

1. Configure `prometheus` port forwarding to the local computer:

    ```bash
    kubectl port-forward service/prometheus 9090:9090 -n istio-system
    ```

1. To open the {{ prometheus-name }} dashboard, paste `http://localhost:9090` into the address bar of your browser.

1. Enter the following request in the **Expression** field:

    ```bash
    istio_requests_total{destination_service="recommender.todoapp.svc.cluster.local"}
    ```

1. Go to the **Graph** tab. It shows Istio metrics.

## View Istio metrics on the {{ grafana-name }} dashboard {#viewing-metrics-grafana}

1. Make sure `grafana` is installed and available in the {{ managed-k8s-name }} cluster:

    ```bash
    kubectl get service grafana -n istio-system
    ```

    Result:

    ```text
    NAME      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
    grafana   ClusterIP   10.96.205.86   <none>        3000/TCP   15d
    ```

1. Configure `grafana` port forwarding to the local computer:

    ```bash
    kubectl port-forward service/grafana 3000:3000 -n istio-system
    ```

1. To open the {{ grafana-name }} dashboard, paste `http://localhost:3000` into the address bar of your browser.

1. In the list of dashboards, find and open the **Istio Mesh Dashboard**. It shows the metrics of requests to your test app's services.

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. [Delete the created subnets](../../../vpc/operations/subnet-delete.md) and [networks](../../../vpc/operations/network-delete.md).
    1. [Delete service accounts you created](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
