
# Setting up the Gateway API


The [Gateway API](https://github.com/kubernetes-sigs/gateway-api) is a collection of API resources that model networking in a [{{ k8s }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

In this tutorial, you will learn how to enable access to the applications deployed in two test environments, `dev` and `prod`, by running [{{ alb-full-name }}](../../application-load-balancer/) with the Gateway API. For this, you will need to create a [public domain zone](../../dns/concepts/dns-zone.md#public-zones) and delegate the domain to [{{ dns-full-name }}](../../dns).

To integrate the Gateway API and {{ alb-name }}:
1. [Create {{ managed-k8s-name }} resources](#k8s-create).
1. [Install the Gateway API and set up the domain zones](#install-gateway-api).
1. [Prepare test applications](#prepare-apps).
1. [Create test applications](#install-apps).
1. [Test the Gateway API](#check-apps).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).

## Create {{ managed-k8s-name }} resources {#k8s-create}

1. Create a {{ k8s }} cluster and a [group of nodes](../../managed-kubernetes/concepts/index.md#node-group).

   {% list tabs group=instructions %}

   - Manually {#manual}

      1. If you do not have a [network](../../vpc/concepts/network.md#network) yet, [create one](../../vpc/operations/network-create.md).
      1. If you do not have any [subnets](../../vpc/concepts/network.md#subnet), [create them](../../vpc/operations/subnet-create.md) in the [availability zones](../../overview/concepts/geo-scope.md) where your {{ k8s }} cluster and node group will be created.
      1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

         {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

      1. [Create a {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) and a [node group](../../managed-kubernetes/operations/node-group/node-group-create.md) in any suitable configuration. When creating them, specify the security groups prepared in advance.

   - {{ TF }} {#tf}

      1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
      1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
      1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
      1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

      1. Download the [k8s-gateway-api.tf](https://github.com/yandex-cloud-examples/yc-mk8s-gateway-api/blob/main/k8s-gateway-api.tf) cluster configuration file to the same working directory. The file describes:
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

1. [Create a service account](../../iam/operations/sa/create.md) required for the Gateway API:
1. [Assign it the roles](../../iam/operations/sa/assign-role-for-sa.md):
   * `alb.editor`: To create the required resources.
   * `certificate-manager.admin`: To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
   * `compute.viewer`: To use {{ managed-k8s-name }} cluster nodes in the [load balancer](../../application-load-balancer/concepts/application-load-balancer.md) [target groups](../../application-load-balancer/concepts/target-group.md).
   * `vpc.publicAdmin`: To manage [external connectivity](../../vpc/security/index.md#vpc-public-admin).
1. Create a [static key](../../iam/operations/sa/create-access-key.md) and save it to a file named `sa-key.json`:

   ```bash
   yc iam key create \
     --service-account-name <name_of_service_account_for_Gateway_API> \
     --output sa-key.json
   ```

## Install the Gateway API and set up the domain zones {#install-gateway-api}

1. Install the [Gateway API application](/marketplace/products/yc/gateway-api) [by following this guide](../../managed-kubernetes/operations/applications/gateway-api.md). During the installation, use the service account key [issued previously](#k8s-create).
1. Reserve the [public IP addresses](../../vpc/concepts/address.md#public-addresses) for the `prod` and `dev` test environments:

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

   Where `availability_zone` is the [availability zone](../../overview/concepts/geo-scope.md) hosting your {{ k8s }} cluster.

   Save the public IP addresses: you will need them to continue the setup.
1. Add [resource records](../../dns/concepts/resource-record.md) for your public DNS zone:

   ```bash
   yc dns zone add-records \
     --name <name_of_your_DNS_zone> \
     --record '*.prod.<name_of_your_DNS_zone> 60 A <prod_environment_IP_address>' && \
   yc dns zone add-records \
     --name <name_of_your_DNS_zone> \
     --record '*.dev.<name_of_your_DNS_zone> 60 A <dev_environment_IP_address>'
   ```

   > Example of a valid command:
   >
   > ```bash
   > yc dns zone add-records \
   >  --name my-test-domain.com \
   >  --record '*.dev.my-test-domain.com 60 A 171.154.241.41'
   > ```

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
     -subj '/CN=*.prod.<name_of_your_DNS_zone>' && \
   openssl req -x509 \
      -newkey rsa:4096 \
      -keyout gateway-key-dev.pem \
      -out gateway-cert-dev.pem \
      -nodes \
      -days 365 \
      -subj '/CN=*.dev.<name_of_your_DNS_zone>'
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

## Prepare test applications {#prepare-apps}

Two applications will be created to test the Gateway API: `tutum/hello-world` and `nginxdemos/hello`. For each application, you will need to configure and run three YAML files:
* `dev-gw.yaml` and `prod-gw.yaml`: Settings for the Gateway. In these manifest files, specify:
   * [Security group](../../managed-kubernetes/operations/connect/security-groups.md) in which your {{ k8s }} cluster is deployed, in the `metadata.annotations.gateway.alb.yc.io/security-groups` parameter.
   * Name of your DNS zone, with the `*.dev` and `*.prod` prefixes, in the `hostname` parameters.
   * IP addresses for the `dev` and `prod` environments, in the `spec.addresses.value` parameter.
* `dev-route.yaml` and `prod-route.yaml`: Routing settings for the applications. In these manifests, you need to specify the name of your DNS zone with the `app.dev` and `app.prod` prefixes in the `spec.hostnames` parameter.
* `dev-app.yaml` and `prod-app.yaml`: Settings for the applications. These manifests will be used to create:
   * Namespace (unique for each application)
   * [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) for the application
   * [Service](../../managed-kubernetes/concepts/index.md#service)

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
       gateway.alb.yc.io/security-groups: <security_group_in_the_cluster>
    spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-dev
       protocol: HTTP
       port: 80
       hostname: "*.dev.<name_of_your_DNS_zone>"
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
       hostname: "*.dev.<name_of_your_DNS_zone>"
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
         value: <IP_address_for_the_dev_environment>
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
     - "app.dev.<your_DNS_zone_name>"
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
       gateway.alb.yc.io/security-groups: <security_group_in_the_cluster>
   spec:
     gatewayClassName: yc-df-class
     listeners:
     - name: gateway-api-prod
       protocol: HTTP
       port: 80
       hostname: "*.prod.<name_of_your_DNS_zone>"
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
       hostname: "*.prod.<name_of_your_DNS_zone>"
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
         value: <IP_address_for_the_dev_environment>
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
     - "app.prod.<name_of_your_DNS_zone>"
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

1. To install the applications, run this command:

   ```bash
   kubectl apply -f prod-gw.yaml && \
   kubectl apply -f prod-app.yaml && \
   kubectl apply -f prod-route.yaml && \
   kubectl apply -f dev-gw.yaml && \
   kubectl apply -f dev-app.yaml && \
   kubectl apply -f dev-route.yaml
   ```

1. Make sure that the [pods](../../managed-kubernetes/concepts/index.md#pod) of your applications have changed their status to `Running`:

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

To test your Gateway API operation, follow these links in your browser:
* `app.prod.<name_of_your_DNS_zone>`
* `dev.prod.<name_of_your_DNS_zone>`

{% include [check-sg-if-url-unavailable-lvl3](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

   1. [Delete the {{ k8s }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. [Delete the created subnets](../../vpc/operations/subnet-delete.md) and [networks](../../vpc/operations/network-delete.md).
   1. [Delete the created service account](../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

   1. In the command line, go to the directory with the current {{ TF }} configuration file with an infrastructure plan.
   1. Delete the `k8s-gateway-api.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.
   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the `k8s-gateway-api.tf` configuration file will be deleted.

{% endlist %}
