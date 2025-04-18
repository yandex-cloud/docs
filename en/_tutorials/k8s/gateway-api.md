# Setting up Gateway API in {{ managed-k8s-full-name }}

[Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

In this tutorial, you will learn how to set up access to the applications deployed in two test environments, `dev` and `prod`, using [{{ alb-full-name }}](../../application-load-balancer/) via Gateway API. For this you will need to create a [public domain zone](../../dns/concepts/dns-zone.md#public-zones) and delegate the domain to [{{ dns-full-name }}](../../dns).

To integrate Gateway API and {{ alb-name }}:
1. [Create the {{ managed-k8s-name }} resources](#k8s-create).
1. [Install Gateway API and set up the domain zones](#install-gateway-api).
1. [Prepare test applications](#prepare-apps).
1. [Create test applications](#install-apps).
1. [Test Gateway API](#check-apps).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using the computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for public IP addresses (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).

## Create the {{ managed-k8s-name }} resources {#k8s-create}

1. Create a {{ k8s }} cluster and [node group](../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Manually {#manual}

     1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
     1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet) yet, [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.

     1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. [Create a {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared earlier.

   - {{ TF }} {#tf}

     1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
     1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
     1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
     1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

     1. Download the [k8s-gateway-api.tf](https://github.com/yandex-cloud-examples/yc-mk8s-gateway-api/blob/main/k8s-gateway-api.tf) cluster configuration file to the same working directory. This file describes:
        * Network.
        * Subnet.
        * {{ k8s }} cluster.
        * Service account required for the {{ k8s }} cluster and node group to operate.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

     1. Specify the following in the configuration file:
        * [Folder ID](../../resource-manager/operations/folder/get-id.md).
        * {{ k8s }} version for the {{ k8s }} cluster and node groups.
        * {{ k8s }} cluster CIDR.
     1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.
     1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

   {% endlist %}

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Create a service account](../../iam/operations/sa/create.md) required for Gateway API:
1. [Assign the following roles to it](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `certificate-manager.admin`: To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in the [load balancer](../../application-load-balancer/concepts/application-load-balancer.md) [target groups](../../application-load-balancer/concepts/target-group.md).
   * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#vpc-public-admin).
1. Create a [static key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name_of_service_account_for_Gateway_API> \
     --output sa-key.json
   ```

## Install Gateway API and set up the domain zones {#install-gateway-api}

1. Install the [Gateway API application](/marketplace/products/yc/gateway-api) [according to the instructions](../../managed-kubernetes/operations/applications/gateway-api.md). During the installation, use the service account key [issued previously](#k8s-create).
1. Reserve [public IP addresses](../../vpc/concepts/address.md#public-addresses) for the `prod` and `dev` test environments:

   ```bash
   yc vpc address create \
     --name=prod \
     --labels reserved=true \
     --external-ipv4 \
     zone=<availability_zone> && \
   yc vpc address create \
     --name=dev \
     --labels reserved=true \
     --external-ipv4 \
     zone=<availability_zone>
   ```

   Where `<availability_zone>` is the [availability zone](../../overview/concepts/geo-scope.md) hosting your {{ k8s }} cluster.

   Save the public IP addresses: you will need them to continue the setup.
1. Add [resource records](../../dns/concepts/resource-record.md) for your public DNS zone:

   ```bash
   yc dns zone add-records \
     --name <DNS_zone_name> \
     --record '*.prod 60 A <prod_environment_IP_address>' && \
   yc dns zone add-records \
     --name <DNS_zone_name> \
     --record '*.dev 60 A <dev_environment_IP_address>'
   ```

   >Example of a valid command:
   >
   >```bash
   >yc dns zone add-records \
   >  --name my-domain-name \
   >  --record '*.dev 60 A 171.154.241.41'
   >```

1. Create a [namespace](../../managed-kubernetes/concepts/index.md#namespace) for TLS secrets:

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
     -subj '/CN=*.prod.<domain_zone>' && \
   openssl req -x509 \
      -newkey rsa:4096 \
      -keyout gateway-key-dev.pem \
      -out gateway-cert-dev.pem \
      -nodes \
      -days 365 \
      -subj '/CN=*.dev.<domain_zone>'
   ```

   >Example of a valid command:
   >
   >```bash
   >openssl req -x509 \
   >  -newkey rsa:4096 \
   >  -keyout gateway-key-prod.pem \
   >  -out gateway-cert-prod.pem \
   >  -nodes \
   >  -days 365 \
   >  -subj '/CN=*.prod.my-test-domain.com'
   >```

   These certificates will be used to create secrets for the `prod` and `dev` test environments in the {{ k8s }} cluster.

1. Create the secrets:

   ```bash
   kubectl create -n gateway-api-tls-secrets secret tls gateway-prod-tls \
     --cert=gateway-cert-prod.pem \
     --key=gateway-key-prod.pem && \
   kubectl create -n gateway-api-tls-secrets secret tls gateway-dev-tls \
     --cert=gateway-cert-dev.pem \
     --key=gateway-key-dev.pem
   ```

## Prepare test applications {#prepare-apps}

To test Gateway API, we will create two applications, `tutum/hello-world` and `nginxdemos/hello`. For each application, you will need to configure and run three YAML files:
* `dev-gw.yaml` and `prod-gw.yaml` with Gateway settings. In these manifest files, specify:
  * [Security groups](../../managed-kubernetes/operations/connect/security-groups.md) in which your {{ k8s }} cluster is deployed in the `metadata.annotations.gateway.alb.yc.io/security-groups` parameter.
  * Domain zone with the `*.dev` and `*.prod` prefixes in the `hostname` parameters.
  * IP addresses for the `dev` and `prod` environments in the `spec.addresses.value` parameter.
* `dev-route.yaml` and `prod-route.yaml` to configure routing for the applications. In these manifests, you need to specify the domain zone with the `app.dev` and `app.prod` prefixes in the `spec.hostnames` parameter.
* `dev-app.yaml` and `prod-app.yaml` with the applications’ settings. These manifests will be used to create:
  * Namespace (unique for each application)
  * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) for the application
  * [Service](../../managed-kubernetes/concepts/index.md#service)

### Configure the application for the dev environment {#configure-dev}

1. Create a manifest named `dev-gw.yaml`:

   {% cut "dev-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: Gateway
   metadata:
     name: gateway-api-dev
     annotations:
       gateway.alb.yc.io/security-groups: <cluster_security_group_IDs>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-dev
       protocol: HTTP
       port: 80
       hostname: "*.dev.<domain_zone>"
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
       hostname: "*.dev.<domain_zone>"
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
        value: "<dev_environment_IP_address>"
   ```

   {% endcut %}

1. Create a file named `dev-route.yaml`:

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
     - "app.dev.<domain_zone>"
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

1. Create a manifest named `dev-app.yaml`:

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

1. Create a manifest named `prod-gw.yaml`:

   {% cut "prod-gw.yaml" %}

   ```yaml
   ---
   apiVersion: gateway.networking.k8s.io/v1alpha2
   kind: Gateway
   metadata:
     name: gateway-api-prod
     annotations:
       gateway.alb.yc.io/security-groups: <cluster_security_group_IDs>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-prod
       protocol: HTTP
       port: 80
       hostname: "*.prod.<domain_zone>"
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
       hostname: "*.prod.<domain_zone>"
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
         value: "<prod_environment_IP_address>"
   ```

   {% endcut %}

1. Create a manifest named `prod-route.yaml`:

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
     - "app.prod.<domain_zone>"
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

1. Create a manifest named `prod-app.yaml`:

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

1. To install the applications, run this command:

   ```bash
   kubectl apply -f prod-gw.yaml && \
   kubectl apply -f prod-app.yaml && \
   kubectl apply -f prod-route.yaml && \
   kubectl apply -f dev-gw.yaml && \
   kubectl apply -f dev-app.yaml && \
   kubectl apply -f dev-route.yaml
   ```

1. Make sure the app [pods](../../managed-kubernetes/concepts/index.md#pod) have entered the `Running` state:

   ```bash
   kubectl get pods --namespace dev-app && \
   kubectl get pods --namespace prod-app
   ```

1. Make sure that a load balancer has been created for Gateway API:

   ```bash
   yc application-load-balancer load-balancer list
   ```

   {% note info %}

   It may take several minutes to create the load balancer.

   {% endnote %}

## Test Gateway API {#check-apps}

To test Gateway API, open these links in your browser:
* `app.prod.<domain_zone>`.
* `app.dev.<domain_zone>`.

{% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

  1. [Delete the {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
  1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
  1. [Delete the created service account](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
