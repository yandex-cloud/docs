# Health checking your apps in a {{ managed-k8s-full-name }} cluster using a {{ alb-full-name }} L7 load balancer


You can use an [{{ alb-name }} Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md) to automatically health check your applications deployed in a {{ managed-k8s-name }} cluster.

An Ingress controller installed in the cluster deploys an [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) with all the required {{ alb-name }} resources based on the configuration of the [Ingress](../../managed-kubernetes/alb-ref/ingress.md) and [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) resources you created.

The L7 load balancer automatically health checks the application in this cluster. Depending on the results, the L7 load balancer allows or denies external traffic to the backend ([Service](../../managed-kubernetes/alb-ref/service-for-ingress.md) resource). For more information, see [Health checks](../../application-load-balancer/concepts/backend-group.md#health-checks).

By default, the {{ alb-name }} Ingress controller receives application health check requests from the L7 load balancer on TCP port `10501` and health checks the [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) pods on each cluster node. If kube-proxy is healthy, then, even if an application in a particular pod does not respond, {{ k8s }} will redirect traffic to a different pod with that application or to a different node.

In this tutorial, you will configure your own application health checks using the [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) resource parameters and open a dedicated port on cluster nodes for these checks in the `NodePort` type [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md) resource parameters.

You can view health check results in the [management console]({{ link-console-main }}).

{% include [alb-custom-hc-enabling](../../_includes/managed-kubernetes/alb-custom-hc-enabling.md) %}

To deploy an application in a {{ managed-k8s-name }} cluster and configure access to it and health checks via an {{ alb-name }} L7 load balancer:

1. [Get your cloud ready](#before-begin).
1. [Create a Docker image](#docker-image).
1. [Deploy a test application](#test-app).
1. [Prepare an address for the L7 load balancer](#prepare-address).
1. [Create the Ingress and HttpBackendGroup resources](#create-ingress).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using the computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for public IP addresses for cluster nodes and L7 load balancer (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for {{ container-registry-name }} [storage](../../container-registry/pricing).


## Get your cloud ready {#before-begin}

### Set up your infrastructure {#infra}

{% list tabs group=instructions %}

- Manually {#manual}

   1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

      {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

      The application will be available on the {{ managed-k8s-name }} cluster nodes on port `30080`. Application health checks will be available on port `30081`. Make sure these ports are open for the L7 load balancer in the node group's security group. You can also [make these ports internet-accessible](../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes).

      {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

   1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}
   1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}
   1. [Create a registry](../../container-registry/operations/registry/registry-create.md) in {{ container-registry-full-name }}.

- {{ TF }} {#tf}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}
   1. Download the [k8s-custom-health-checks.tf](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/terraform-manifests/k8s-custom-health-checks.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) required for the {{ managed-k8s-name }} cluster, node group, and the {{ alb-name }} load balancer.
      * Service account required for the {{ k8s }} cluster.
      * {{ k8s }} cluster.
      * {{ k8s }} node group.
      * Registry in {{ container-registry-full-name }}.

   1. Specify the following in the `k8s-custom-health-checks.tf` file:

      * `folder_id`: Cloud folder ID, same as in the provider settings.
      * `k8s_version`: {{ k8s }} version. Available versions are listed in [{#T}](../../managed-kubernetes/concepts/release-channels-and-updates.md).

   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Install the {{ alb-name }} Ingress controller {#install-alb-ingress-controller}

Use this [guide](../../managed-kubernetes/operations/applications/alb-ingress-controller.md) to install the [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) application in a separate `yc-alb` namespace. Later on, all the required {{ k8s }} resources will be created in this namespace.

### Install additional dependencies {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [Run kubectl cluster-info](../../_includes/managed-kubernetes/kubectl-info.md) %}

1. [Install Docker](https://docs.docker.com/get-docker/).
1. [Authenticate in {{ container-registry-full-name }}](../../container-registry/operations/authentication.md#cred-helper) using a Docker credential helper.

## Create a Docker image {#docker-image}

The source files for a Docker image reside in the [yc-mk8s-alb-ingress-health-checks](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks) repository.

The Docker image will be created from `app/Dockerfile` and will contain test application code from the `app/healthchecktest.go` file. You will use this Docker image to [deploy the application in your {{ managed-k8s-name }} cluster](#test-app).

The application will respond to HTTP requests as follows depending on the pod port:
* `80`: Return request path parameters in the response body, e.g., `/test-path`. This is the main functionality of the application that will be available via the L7 load balancer.
* `8080`: Return an `OK` message in the response body. This functionality will be used to perform application health checks.

Successful requests will return the `200 OK` HTTP code.

To create a Docker image:
1. Clone the `yc-mk8s-alb-ingress-health-checks` repository:

   ```bash
   git clone git@github.com:yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks.git
   ```

1. In the terminal, go to the root of the repository directory.
1. Get the {{ container-registry-name }} registry ID. You can [request it with a list of registries](../../container-registry/operations/registry/registry-list.md#registry-list) in the folder.
1. In the environment variable, add the name of the Docker image to create:

   ```bash
   export TEST_IMG={{ registry }}/<registry_ID>/example-app1:latest
   ```

1. Build the Docker image:

   ```bash
   docker build -t ${TEST_IMG} -f ./app/Dockerfile .
   ```

   The command specifies the path for the repository's root directory.

1. Push the Docker image to the registry:

   ```bash
   docker push ${TEST_IMG}
   ```

   If you fail to push the image, follow these steps:

   * Make sure you [authenticate in {{ container-registry-name }}](../../container-registry/operations/authentication.md#cred-helper) using a Docker credential helper.
   * [Configure registry access](../../container-registry/operations/registry/registry-access.md). Grant the PUSH permission for your computer's IP address to allow pushing Docker-images.

## Deploy a test application {#test-app}

Build a test application from the created Docker image and the [app/testapp.yaml](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/app/testapp.yaml) configuration file.

The file contains the description of {{ k8s }} resources: `Deployment` and `Service` of the `NodePort` type.

The `Service` resource contains the description of ports used to access the application on your cluster's nodes:
* `spec.ports.name: http`: Port to access the main functionality of the application, `80` on the pod and `30080` on the host.
* `spec.ports.name: health`: Port for application health checks, `8080` on the pod and `30081` on the host.

To build a test application:

1. Specify the value of the `TEST_IMG` environment variable in the `spec.template.spec.containers.image` field in the `app/testapp.yaml` file. To get this value, run:

   ```bash
   printenv TEST_IMG
   ```

1. Create the application from the `app/testapp.yaml` file:

   ```bash
   kubectl apply -f ./app/testapp.yaml --namespace=yc-alb
   ```

   The command specifies the path for the repository's root directory.

1. Make sure the pods with the application are running:

   ```bash
   kubectl get po --namespace=yc-alb
   ```

   Result:

   ```text
   NAME                               READY   STATUS    RESTARTS   AGE
   alb-demo-1-54b95979b4-***          1/1     Running   0          71s
   alb-demo-1-54b95979b4-***          1/1     Running   0          71s
   yc-alb-ingress-controller-***      1/1     Running   0          11m
   yc-alb-ingress-controller-hc-***   1/1     Running   0          11m
   ```

1. Test the application by specifying the IP address of the {{ managed-k8s-name }} cluster node in the request. You can find out the IP address of the node in the [management console]({{ link-console-main }}).

   * Main functionality:

     ```bash
     curl --include http://<node_IP_address>:30080/test-path
     ```

     Result:

     ```bash
     HTTP/1.1 200 OK
     Date: Thu, 18 Jul 2024 11:55:52 GMT
     Content-Length: 10
     Content-Type: text/plain; charset=utf-8

     /test-path%
     ```

   * Application health check:

     ```bash
     curl --include http://<node_IP_address>:30081
     ```

     Result:

     ```bash
     HTTP/1.1 200 OK
     Date: Thu, 18 Jul 2024 12:00:57 GMT
     Content-Length: 2
     Content-Type: text/plain; charset=utf-8

     OK%
     ```

## Prepare an address for the L7 load balancer {#prepare-address}

This address will be used to access the application from the internet.

To prepare an address for the load balancer:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Reserve a static public IP address](../../vpc/operations/get-static-ip.md) for the {{ alb-name }} load balancer.
   1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).
   1. To bind the address to the domain, [create an A record](../../dns/operations/resource-record-create.md) for the delegated domain. Specify the reserved IP address as the record value.
   1. Make sure the A record is added:

      ```bash
      host <domain>
      ```

      Result:

      ```text
      <domain> has address <IP_address>
      ```

- {{ TF }} {#tf}

   1. Place the [address-for-k8s-health-checks.tf](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks/blob/main/terraform-manifests/address-for-k8s-health-checks.tf) configuration file in the same working directory as the `k8s-custom-health-checks.tf` file.

      The `address-for-k8s-health-checks.tf` file describes:

      
      * [Static public IP address](../../vpc/concepts/address.md#public-addresses).
      * [Public DNS zone](../../dns/concepts/dns-zone.md#public-zones).
      * [Type A record](../../dns/concepts/resource-record.md#a) for this zone to bind the reserved IP address to the delegated domain.


   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   1. Make sure the A record is added:

      ```bash
      host <domain>
      ```

      Result:

      ```text
      <domain> has address <IP_address>
      ```

{% endlist %}

## Create the Ingress and HttpBackendGroup resources {#create-ingress}

Based on the [Ingress](../../managed-kubernetes/alb-ref/ingress.md) and [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md) resources, the Ingress controller will deploy the [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) with all the required {{ alb-name }} resources.

The `ingress.yaml` and `httpbackendgroup.yaml` configuration files for the specified resources are located in the [yc-mk8s-alb-ingress-health-checks](https://github.com/yandex-cloud-examples/yc-mk8s-alb-ingress-health-checks) repository.

You can specify the settings for custom application health checks in the `HttpBackendGroup` resource in the `spec.backends.healthChecks` parameter.

To create resources:

1. In the `ingress.yaml` file, specify the following values for annotations:

   * `ingress.alb.yc.io/subnets`: One or more subnets to host the {{ alb-name }} L7 load balancer.
   * `ingress.alb.yc.io/security-groups`: One or more [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) for the load balancer. If you skip this parameter, the default security group will be used. At least one of the security groups must allow an outgoing TCP connection to port `10501` in the {{ managed-k8s-name }} node group subnet or to its security group.
   * `ingress.alb.yc.io/external-ipv4-address`: Public access to the load balancer from the internet. Specify the previously reserved static public IP address.

1. In the same `ingress.yaml` file, specify the delegated domain in the `spec.rules.host` parameter.
1. To create the `Ingress` and `HttpBackendGroup` resources, run the following command from the root of the repository directory:

   ```bash
   kubectl apply -f ingress.yaml --namespace=yc-alb &&
   kubectl apply -f httpbackendgroup.yaml --namespace=yc-alb
   ```

1. Wait until the resources are created and the load balancer is deployed and assigned a public IP address. This may take a few minutes.

   To follow the load balancer's creation and make sure it is error-free, open the logs of the pod the creation process was run in:

   1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
   1. Click your cluster's name and select **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
   1. Select the `yc-alb-ingress-controller-*` pod (not `yc-alb-ingress-controller-hc-*`) where the resource creation process is running.
   1. Go to the **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}** tab on the pod page.

      The load balancer's creation logs are generated and displayed in real time. Any errors that occur will also be logged.

## Check the result {#check-result}

1. Make sure the load balancer was created. To do this, run the appropriate command and check that the command output shows the following value in the `ADDRESS` field:

   ```bash
   kubectl get ingress alb-demo --namespace=yc-alb
   ```

   Result:

   ```bash
   NAME       CLASS    HOSTS     ADDRESS      PORTS   AGE
   alb-demo   <none>   <domain>   <IP_address>   80      15h
   ```

1. Check that the deployed application is available via the L7 load balancer:

   ```bash
   curl --include http://<domain>/test-path
   ```

   Result:

   ```bash
   HTTP/1.1 200 OK
   date: Thu, 18 Jul 2024 12:23:51 GMT
   content-length: 10
   content-type: text/plain; charset=utf-8
   server: ycalb

   /test-path%
   ```

   {% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

1. Make sure the app health checks are working correctly:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_application-load-balancer }}**.
      1. Click the load balancer name and select **{{ ui-key.yacloud.alb.label_healthchecks }}** in the left-hand panel.
      1. Check the target health statuses. The `HEALTHY` status indicates the application is up and running.

   {% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. {{ alb-name }} [L7 load balancer](../../application-load-balancer/operations/application-load-balancer-delete.md)
1. {{ alb-name }} [HTTP router](../../application-load-balancer/operations/http-router-delete.md)
1. {{ alb-name }} [backend groups](../../application-load-balancer/operations/backend-group-delete.md)
1. {{ alb-name }} [target group](../../application-load-balancer/operations/target-group-delete.md)
1. {{ managed-k8s-name }} [node group](../../managed-kubernetes/operations/node-group/node-group-delete.md)
1. {{ managed-k8s-name }} [cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md)
1. [Registry](../../container-registry/operations/registry/registry-delete.md) in {{ container-registry-name }}
1. {{ dns-name }} [public domain zone](../../dns/operations/zone-delete.md)
1. {{ vpc-name }} [security groups](../../vpc/operations/security-group-delete.md)
1. {{ vpc-name }} [static public IP address](../../vpc/operations/address-delete.md)
