# Setting up Gateway API

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ k8s }} cluster](../../concepts/index.md#kubernetes-cluster).

In this tutorial, you'll learn how to enable access to the applications deployed in two test environments, `dev` and `prod`, by running [{{ alb-full-name }}](../../../application-load-balancer/) through the API Gateway. For this, you will need to create a [public domain zone](../../../dns/concepts/dns-zone.md#public-zones) and delegate the domain to [{{ dns-full-name }}](../../../dns).

To integrate the Gateway API and {{ alb-name }}:
1. [{#T}](#k8s-create).
1. [{#T}](#install-gateway-api).
1. [{#T}](#prepare-apps).
1. [{#T}](#install-apps).
1. [{#T}](#check-apps).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. [Register a public domain zone and delegate your domain](../../../dns/operations/zone-create-public.md).

## Create {{ managed-k8s-name }} resources {#k8s-create}

1. Create a {{ k8s }} cluster and a [group of nodes](../../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs %}

   - Manually

     1. If you don't have a [network](../../../vpc/concepts/network.md#network), [create one](../../../vpc/operations/network-create.md).
     1. If you don't have any [subnets](../../../vpc/concepts/network.md#subnet), [create them](../../../vpc/operations/subnet-create.md) in the [availability zones](../../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
     1. [Create a {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration.
     1. [Create a rule for connecting to the services from the internet](../../../managed-kubernetes/operations/connect/security-groups.md#rules-nodes), then apply it to the cluster's node group.

   - Using {{ TF }}

     1. If you don't have {{ TF }}, [install it](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
     1. Download the [k8s-gateway-api.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-gateway-api.tf) cluster configuration file to the same working directory. The file describes:
        * Network.
        * Subnet.
        * [Security group](../../operations/connect/security-groups.md) and rules required for the cluster, node group, and {{ k8s }} instance to run:
          * Rules for service traffic.
          * Rules for accessing the {{ k8s }} API and managing the cluster with `kubectl` through ports 443 and 6443.
          * Rules for connecting to services from the internet.
        * {{ k8s }} cluster.
        * Service account required to use the {{ k8s }} cluster and node group.
     1. Specify the following in the configuration file:
        * [Folder ID](../../../resource-manager/operations/folder/get-id.md).
        * {{ k8s }} version for the {{ k8s }} cluster and node groups.
        * {{ k8s }} cluster CIDR.
     1. Run the `terraform init` command in the directory with the configuration files. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
     1. Make sure the {{ TF }} configuration files are correct using the command:

        ```bash
        terraform validate
        ```

        If there are errors in the configuration files, {{ TF }} will point to them.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Create a service account](../../../iam/operations/sa/create.md), which is required for Gateway API:
1. [Assign it the roles](../../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `certificate-manager.admin`: To use certificates registered in [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in the [load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) [target groups](../../../application-load-balancer/concepts/target-group.md).
   * `vpc.publicAdmin`: To manage [external connectivity](../../../iam/concepts/access-control/roles.md#vpc-public-admin).
1. Create a [static key](../../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name of service account for Gateway API> \
     --output sa-key.json
   ```

## Install the Gateway API and set up the {#install-gateway-api} domain zones

1. Install the [Gateway API application](/marketplace/products/yc/gateway-api) [by following the instructions](../../operations/applications/gateway-api.md). During the installation, use the service account key [issued previously](#k8s-create).
1. Reserve the [public IP addresses](../../../vpc/concepts/address.md#public-addresses) for the `prod` and `dev` test environments:

   ```bash
   yc vpc address create \
     --name=prod \
     --labels reserved=true \
     --external-ipv4 \
     zone=<availability zone> && \
   yc vpc address create \
     --name=dev \
     --labels reserved=true \
     --external-ipv4 \
     zone=<availability zone>
   ```

   Where the `availability zone` is the [availability zone](../../../overview/concepts/geo-scope.md) that hosts your {{ k8s }} cluster.

   Save the public IP addresses: you will need them to continue the setup.
1. Add [resource records](../../../dns/concepts/resource-record.md) for your public DNS zone:

   ```bash
   yc dns zone add-records \
     --name <name of your DNS zone> \
     --record '*.prod.<name of your DNS zone> 60 A <IP address for the prod environment>' && \
   yc dns zone add-records \
     --name <name of your DNS zone> \
     --record '*.dev.<name of your DNS zone> 60 A <IP address for the dev environment>'
   ```

   > Example of a valid command:
   >
   > ```bash
   > yc dns zone add-records \
   >  --name my-test-domain.com \
   >  --record '*.dev.my-test-domain.com 60 A 171.154.241.41'
   > ```

1. Create a [namespace](../../concepts/index.md#namespace) for TLS secrets:

   ```bash
   kubectl create namespace gateway-api-tls-secrets
   ```

1. Create OpenSSL certificates:

   ```bash
   openssl req -x509 \
     -newkey rsa:4096 \
     -keyout gateway-key-prod.pem \
     -out gateway-cert-prod.pem \
     -nodes \
     -days 365 \
     -subj '/CN=*.prod.<name of your DNS zone>' && \
   openssl req -x509 \
      -newkey rsa:4096 \
      -keyout gateway-key-dev.pem \
      -out gateway-cert-dev.pem \
      -nodes \
      -days 365 \
      -subj '/CN=*.dev.<name of your DNS zone>'
   ```

   Based on these certificates, secrets will be created for the `prod` and `dev` test environments in the {{ k8s }} cluster.
1. Create the secrets:

   ```bash
   kubectl create -n gateway-api-tls-secrets secret tls gateway-prod-tls \
     --cert=gateway-cert-prod.pem \
     --key=gateway-key-prod.pem && \
   kubectl create -n gateway-api-tls-secrets secret tls gateway-dev-tls \
     --cert=gateway-cert-dev.pem \
     --key=gateway-key-dev.pem
   ```

## Provision the test applications {#prepare-apps}

Two applications will be created to test the Gateway API (`tutum/hello-world` and `nginxdemos/hello`). For each application, you'll need to configure and run three YAML files.
* `dev-gw.yaml` and `prod-gw.yaml` are the settings for the Gateway. In these manifest files, specify:
  * The [security group](../../operations/connect/security-groups.md) in which your {{ k8s }} cluster is deployed, in the `metadata.annotations.gateway.alb.yc.io/security-groups` parameter.
  * The name of your DNS zone, with the prefixes `*.dev` and `*.prod`, in the `hostname` parameters.
  * IP addresses for the `dev` and `prod` environments `spec.addresses.value`.
* `dev-route.yaml` and `prod-route.yaml`: Routing setup for the applications. In these manifests, you need to specify the name of your DNS zone with the `app.dev` and `app.prod` prefixes in the `spec.hostnames` parameter.
* `dev-app.yaml` and `prod-app.yaml`: Settings for the applications. These manifests will be used to create:
  * A namespace (it's unique for each application).
  * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) for the application.
  * [Service](../../concepts/index.md#service).

### Configure the application for the dev environment {#configure-dev}

1. Create the `dev-gw.yaml` manifest file:

   {% cut "dev-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: Gateway
   metadata:
     name: gateway-api-dev
     annotations:
       gateway.alb.yc.io/security-groups: <security group in the cluster>
    spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-dev
       protocol: HTTP
       port: 80
       hostname: "*.dev.<name of your DNS zone>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - dev-app
     - name: gateway-api-dev-tls
       protocol: HTTPS
       port: 443
       hostname: "*.dev.<name of your DNS zone>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - dev-app
       tls:
         certificateRefs:
         - group: ""
           kind: Secret
           name: gateway-dev-tls
           namespace: gateway-api-tls-secrets
         mode: Terminate
     addresses:
      - type: IPAddress
         value: <IP address for the dev environment>
   ```

   {% endcut %}

1. Create the `dev-route.yaml` file:

   {% cut "dev-route.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: HTTPRoute
   metadata:
     name: dev-app-http-route
     namespace: dev-app
   spec:
     hostnames:
     - "app.dev.<имя вашей DNS-зоны>"
     parentRefs:
     - name: gateway-api-dev
       namespace: default
     rules:
     - matches:
       - path:
           value: /
       backendRefs:
       - name: app
         port: 80
   ```

   {% endcut %}

1. Create the `dev-app.yaml` manifest file:

   {% cut "dev-app.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Namespace
   metadata:
     name: dev-app
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: app
     namespace: dev-app
   spec:
     selector:
       matchLabels:
         app: app
     template:
       metadata:
         labels:
           app: app
       spec:
         containers:
         - name: app
           image: tutum/hello-world
           resources:
             limits:
               memory: "128Mi"
               cpu: "500m"
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: app
     namespace: dev-app
   spec:
     type: NodePort
     selector:
       app: app
     ports:
     - port: 80
       targetPort: 80
   ```

   {% endcut %}

### Configure the application for the prod environment {#configure-prod}

1. Create the `dev-prod.yaml` manifest file:

   {% cut "prod-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: Gateway
   metadata:
     name: gateway-api-prod
     annotations:
       gateway.alb.yc.io/security-groups: <security group in the cluster>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-prod
       protocol: HTTP
       port: 80
       hostname: "*.prod.<name of your DNS zone>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - prod-app
     - name: gateway-api-prod-tls
       protocol: HTTPS
       port: 443
       hostname: "*.prod.<name of your DNS zone>"
       allowedRoutes:
         namespaces:
           from: Selector
           selector:
             matchExpressions:
             - key: kubernetes.io/metadata.name
               operator: In
               values:
               - prod-app
       tls:
         certificateRefs:
         - group: ""
           kind: Secret
           name: gateway-prod-tls
           namespace: gateway-api-tls-secrets
         mode: Terminate
     addresses:
       - type: IPAddress
         value: <IP address for the prod environment>
   ```

   {% endcut %}

1. Create the `prod-route.yaml` manifest file:

   {% cut "prod-route.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: HTTPRoute
   metadata:
     name: prod-app-http-route
     namespace: prod-app
   spec:
     hostnames:
     - "app.prod.<name of your DNS zone>"
     parentRefs:
     - name: gateway-api-prod
       namespace: default
     rules:
     - matches:
       - path:
           value: /
       backendRefs:
       - name: app
         port: 80
   ```

   {% endcut %}

1. Create the `prod-app.yaml` manifest file:

   {% cut "prod-app.yaml" %}

   ```yaml
   ---
   apiVersion: v1
   kind: Namespace
   metadata:
     name: prod-app
   ---
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: app
     namespace: prod-app
   spec:
     selector:
       matchLabels:
         app: app
     template:
       metadata:
         labels:
           app: app
       spec:
         containers:
         - name: app
           image: tutum/hello-world
           resources:
             limits:
               memory: "128Mi"
               cpu: "500m"
           ports:
           - containerPort: 80
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: app
     namespace: prod-app
   spec:
     type: NodePort
     selector:
       app: app
     ports:
     - port: 80
       targetPort: 80
   ```

   {% endcut %}

### Create test applications {#install-apps}

1. To install the applications, run the command:

   ```bash
   kubectl apply -f prod-gw.yaml && \
   kubectl apply -f prod-app.yaml && \
   kubectl apply -f prod-route.yaml && \
   kubectl apply -f dev-gw.yaml && \
   kubectl apply -f dev-app.yaml && \
   kubectl apply -f dev-route.yaml
   ```

1. Make sure that the [pods](../../concepts/index.md#pod) of your applications have changed their status to `Running`:

   ```bash
   kubectl get pods --namespace dev-app && \
   kubectl get pods --namespace prod-app
   ```

1. Make sure that a load balancer has been created for the Gateway API:

   ```bash
   yc application-load-balancer load-balancer list
   ```

   {% note info %}

   It may take several minutes to create the load balancer.

   {% endnote %}

## Test the Gateway API {#check-apps}

To test your Gateway API operation, follow the links in the browser:
* `app.prod.<name of your DNS zone>`.
* `dev.prod.<name of your DNS zone>`.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

{% list tabs %}

- Manually

  1. [Delete a {{ k8s }} cluster](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Delete the created subnets](../../../vpc/operations/subnet-delete.md) and [networks](../../../vpc/operations/network-delete.md).
  1. [Delete the created service account](../../../iam/operations/sa/delete.md).

- Using {{ TF }}

  1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
  1. Delete the `k8s-gateway-api.tf` configuration file.
  1. Make sure the {{ TF }} configuration files are correct using the command:

     ```bash
     terraform validate
     ```

     If there are errors in the configuration files, {{ TF }} will point to them.
  1. Confirm the update of resources.

     {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

     All the resources described in the `k8s-gateway-api.tf` configuration file will be deleted.

{% endlist %}