# Configuring logging for an {{ alb-full-name }} L7 load balancer using an Ingress controller

You can configure the logging settings for [L7 balancers](../../application-load-balancer/concepts/application-load-balancer.md) created with {{ alb-name }} [Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) within a {{ managed-k8s-name }} cluster.

This article explains how to create three L7 balancers with different logging settings:

* Save logs to the [default group](../../logging/concepts/log-group.md).
* Save logs to a custom group.
* No logging.

To configure L7 load balancers:

1. [Create a test application](#install-app).
1. [Create Ingress resources](#create-ingress).
1. [Specify the settings for the Ingress resource groups](#configure-group).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* Fee for using the master and outgoing traffic in a {{ managed-k8s-name }} cluster (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Fee for using computing resources, OS, and storage in cluster nodes (VMs) (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using the computing resources of each L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for public IP addresses for cluster nodes and L7 load balancers (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* Fee for writing and storing data in {{ cloud-logging-name }} (see [{{ cloud-logging-name }} pricing](../../logging/pricing.md)).


## Getting started {#before-begin}

### Set up your infrastructure {#deploy-infrastructure}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% list tabs group=instructions %}

- Manually {#manual}

    1. Create the following [service accounts](../../iam/operations/sa/create.md) for the {{ managed-k8s-name }} cluster:

        * Service account for the resources with the `k8s.clusters.agent` and `vpc.publicAdmin` [roles](../../managed-kubernetes/security/index.md#yc-api) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) is being created.
        * Service account for nodes with the [{{ roles-cr-puller }}](../../container-registry/security/index.md#container-registry-images-puller) role for the folder with the Docker image [registry](../../container-registry/concepts/registry.md). Nodes will pull the required Docker images from the registry on behalf of this account.
        * Service account for the operation of the {{ alb-name }} Ingress controller with the following roles:

            * [{{ roles-alb-editor }}](../../application-load-balancer/security/index.md#alb-editor): To create the required resources.
            * [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin): To manage [external connectivity](../../vpc/security/index.md#roles-list).
            * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader): To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
            * [compute.viewer](../../compute/security/index.md#compute-viewer): To use {{ managed-k8s-name }} cluster nodes in the load balancer’s [target groups](../../application-load-balancer/concepts/target-group.md).

        You can use the same service account for all operations.

    1. [Create an authorized key](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) for the Ingress controller's service account in JSON format and save it to a file named `key.json`:

        ```bash
        yc iam key create \
           --service-account-name <name_of_service_account_for_Ingress_controller> \
           --output key.json
        ```

        The key data is required for the [installation](#install-alb-ingress-controller) of the ALB Ingress Controller application.

    1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

        {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

        {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

    1. [Create a {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create). Use these settings:

        * Specify the previously created service account for resources as well as security groups.
        * If you intend to use your cluster within the {{ yandex-cloud }} network, there is no need to allocate a public IP address to it. To allow connections from outside the network, assign a public IP address to the cluster.

    1. [Create a node group](../../managed-kubernetes/operations/node-group/node-group-create.md). Use these settings:

        * Specify the previously created service account for nodes as well as security groups.
        * Allocate a public IP address to grant internet access to the node group and enable pulling Docker images and components.

    1. [Create a custom {{ cloud-logging-name }} log group](../../logging/operations/create-group.md).

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [k8s-and-registry-for-alb.tf](https://github.com/yandex-cloud-examples/yc-mk8s-ingress-controller-logging/blob/main/k8s-and-registry-for-alb.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * {{ managed-k8s-name }} cluster.
        * {% include [configure-sg-terraform](../../_includes/managed-kubernetes/security-groups/configure-sg-tf-lvl3.md) %}

            {% include [configure-sg-alb-tf](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-tf.md) %}

            {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

        * [Service account](../../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources and nodes.
        * Service account for the operation of the {{ alb-name }} Ingress controller.
        * [Custom {{ cloud-logging-name }} log group](../../logging/concepts/log-group.md).
        * [Authorized key](../../iam/concepts/authorization/key.md) for the service account of the Ingress controller.
        * Creating a local `key.json` file with the authorized key data. The key data is required for the [installation](#install-alb-ingress-controller) of the ALB Ingress Controller application.

    1. Specify the following in the `k8s-and-registry-for-alb.tf` file:

        * [Folder ID](../../resource-manager/operations/folder/get-id.md).
        * [{{ k8s }} version](../../managed-kubernetes/concepts/release-channels-and-updates.md) for the {{ managed-k8s-name }} cluster and node groups.
        * Name of the service account for {{ k8s }} resources and nodes.
        * Name of the service account for the operation of the {{ alb-name }} Ingress controller.
        * Name of the custom {{ cloud-logging-name }} log group.

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Get ready to use the {{ managed-k8s-name }} cluster {#prepare-k8s-cluster}

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [kubectl info](../../_includes/managed-kubernetes/kubectl-info.md) %}

1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).

### Register a domain zone {#register-domain}

[Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).

### Install the {{ alb-name }} Ingress controller {#install-alb-ingress-controller}

Install the [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) application by following [this guide](../../managed-kubernetes/operations/applications/alb-ingress-controller.md). During the installation, use the `key.json` key data you created when [setting up your infrastructure](#deploy-infrastructure).

## Create a test application {#install-app}

Create the [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) with NGINX, and [Service](https://kubernetes.io/docs/concepts/services-networking/service/) objects for the application.

1. Create the `app.yaml` file:

    {% cut "app.yaml" %}

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: alb-demo-1
    data:
      nginx.conf: |
        worker_processes auto;
        events {
        }
        http {
          server {
            listen 80 ;
            location = /_healthz {
              add_header Content-Type text/plain;
              return 200 'ok';
            }
            location / {
              add_header Content-Type text/plain;
              return 200 'Index';
            }
            location = /app1 {
              add_header Content-Type text/plain;
              return 200 'This is APP#1';
            }
          }
        }
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: alb-demo-1
      labels:
        app: alb-demo-1
        version: v1
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: alb-demo-1
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxSurge: 1
          maxUnavailable: 0
      template:
        metadata:
          labels:
            app: alb-demo-1
            version: v1
        spec:
          terminationGracePeriodSeconds: 5
          volumes:
            - name: alb-demo-1
              configMap:
                name: alb-demo-1
          containers:
            - name: alb-demo-1
              image: nginx:latest
              ports:
                - name: http
                  containerPort: 80
              livenessProbe:
                httpGet:
                  path: /_healthz
                  port: 80
                initialDelaySeconds: 3
                timeoutSeconds: 2
                failureThreshold: 2
              volumeMounts:
                - name: alb-demo-1
                  mountPath: /etc/nginx
                  readOnly: true
              resources:
                limits:
                  cpu: 250m
                  memory: 128Mi
                requests:
                  cpu: 100m
                  memory: 64Mi
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: alb-demo-1
    spec:
      selector:
        app: alb-demo-1
      type: NodePort
      ports:
        - name: http
          port: 80
          targetPort: 80
          protocol: TCP
          nodePort: 30081
    ```

    {% endcut %}

1. Create an app:

    ```bash
    kubectl apply -f app.yaml
    ```

    Result:

    ```text
    configmap/alb-demo-1 created
    deployment.apps/alb-demo-1 created
    service/alb-demo-1 created
    ```

## Create Ingress resources {#create-ingress}

Create three [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resources from which the {{ alb-name }} Ingress controller will create three load balancers with the required listeners and HTTP routers.

1. Create a file named `ingress.yaml` with the load balancer settings and domain name:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: logs-demo-nondefault
      annotations:
        ingress.alb.yc.io/group-name: non-default
        ingress.alb.yc.io/subnets: <list_of_subnet_IDs>
        ingress.alb.yc.io/security-groups: <list_of_security_group_IDs>
        ingress.alb.yc.io/group-settings-name: non-default-settings
        ingress.alb.yc.io/external-ipv4-address: auto
    spec:
      rules:
        - host: <domain_name>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-1
                    port: 
                      name: http
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: logs-demo-disabled
      annotations:
        ingress.alb.yc.io/group-name: logs-disabled
        ingress.alb.yc.io/subnets: <list_of_subnet_IDs>
        ingress.alb.yc.io/security-groups: <list_of_security_group_IDs>
        ingress.alb.yc.io/group-settings-name: logs-disabled-settings
        ingress.alb.yc.io/external-ipv4-address: auto
    spec:
      rules:
        - host: <domain_name>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-1
                    port:
                      name: http
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: logs-demo-default
      annotations:
        ingress.alb.yc.io/group-name: default
        ingress.alb.yc.io/subnets: <list_of_subnet_IDs>
        ingress.alb.yc.io/security-groups: <list_of_security_group_IDs>
        ingress.alb.yc.io/external-ipv4-address: auto
    spec:
      rules:
        - host: <domain_name>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-1
                    port:
                      name: http
    ```

    Where:

    * `ingress.alb.yc.io/group-name`: Group name. Ingress resources are grouped so that a separate {{ alb-name }} load balancer serves each group.
    * `ingress.alb.yc.io/subnets`: One or more [subnets](../../vpc/concepts/network.md#subnet) to host the load balancer.
    * `ingress.alb.yc.io/security-groups`: One or more [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) for the load balancer. If you skip this parameter, the default security group will be used.
    * `ingress.alb.yc.io/external-ipv4-address`: Public access to the load balancer from the internet. Enter the [IP address you got earlier](../../vpc/operations/get-static-ip.md) or set `auto` to get a new IP address automatically.

       If you set `auto`, deleting the load balancer from the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) will also delete its [IP address](../../vpc/concepts/address.md). To avoid this, use a reserved IP address.

    * `ingress.alb.yc.io/group-settings-name`: Name for the Ingress resource group settings to describe in the `IngressGroupSettings` optional resource.

    Optionally, enter advanced controller settings.

    {% include [alb-ingress-balancer-additional-settings](../_tutorials_includes/alb-ingress-balancer-additional-settings.md) %}

    * `ingress.alb.yc.io/internal-ipv4-address`: Provide internal access to the load balancer. Enter the internal IP address or use `auto` to get the IP address automatically.

        {% note info %}

        You can only use one type of access to the load balancer at a time: `ingress.alb.yc.io/external-ipv4-address` or `ingress.alb.yc.io/internal-ipv4-address`.

        {% endnote %}

    * `ingress.alb.yc.io/internal-alb-subnet`: Subnet to host the load balancer. This parameter is required if the `ingress.alb.yc.io/internal-ipv4-address` parameter is selected.
    * `ingress.alb.yc.io/protocol`: Connection protocol used between the load balancer and backends:

        * `http`: HTTP/1.1. Default value.
        * `http2`: HTTP/2.
        * `grpc`: gRPC.

    * `ingress.alb.yc.io/transport-security`: Encryption protocol for connections between the load balancer and backends.

        {% note warning %}

        For [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) version 0.2.0 and later, you can only use this annotation in the [Service](../../application-load-balancer/k8s-ref/service-for-ingress.md#metadata) object.

        Annotations applied to `Ingress` resources sharing the same service and backend group settings will be processed correctly. However, this mechanism is obsolete and will not be supported going forward.

        {% endnote %}

        The acceptable value is `tls`: TLS without certificate validation.

        If this annotation is not specified, the load balancer will connect to the backends without encryption.

    * `ingress.alb.yc.io/prefix-rewrite`: Replace the path for the specified value.
    * `ingress.alb.yc.io/upgrade-types`: Valid values of the `Upgrade` HTTP header, e.g., `websocket`.
    * `ingress.alb.yc.io/request-timeout`: Maximum connection request timeout.
    * `ingress.alb.yc.io/idle-timeout`: Maximum connection idle timeout.

        The `request-timeout` and `idle-timeout` values must be specified with units of measurement, e.g., `300ms` or `1.5h`. Acceptable units of measurement include:
        * `ns`, nanoseconds
        * `us`, microseconds
        * `ms`, milliseconds
        * `s`, seconds
        * `m`, minutes
        * `h`, hours

    For more information about the Ingress resource settings, see [{#T}](../../managed-kubernetes/alb-ref/ingress.md).

1. Create Ingress resources:

    ```bash
    kubectl apply -f ingress.yaml
    ```

    Result:

    ```text
    ingress.networking.k8s.io/logs-demo-nondefault created
    ingress.networking.k8s.io/logs-demo-disabled created
    ingress.networking.k8s.io/logs-demo-default created
    ```

    Three [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) will be automatically deployed based on the Ingress resource configurations.

## Specify the settings for the Ingress resource groups {#configure-group}

Create a resource named `IngressGroupSettings` with these logging settings for the Ingress resource groups:

* `non-default-settings`: Logging to the [previously](#deploy-infrastructure) created custom log group with defined rules.
* `logs-disabled-settings`: No logging.

No settings need to be specified to save logs to the default log group.

1. Create a file named `settings.yaml` with the log group ID:

    ```yaml
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: non-default-settings
    logOptions:
      logGroupID: <custom_log_group_ID>
      discardRules:
        - discardPercent: 50
          grpcCodes:
            - OK
            - CANCELLED
            - UNKNOWN
        - discardPercent: 67
          httpCodeIntervals:
            - HTTP_1XX
        - discardPercent: 20
          httpCodes:
            - 200
            - 404
    ---
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: logs-disabled-settings
    logOptions:
      disable: true
    ```

1. Create the resources:

    ```bash
    kubectl apply -f settings.yaml
    ```

    Result:

    ```text
    ingressgroupsettings.alb.yc.io/non-default-settings created
    ingressgroupsettings.alb.yc.io/logs-disabled-settings created
    ```

The settings from those resources will apply to the Ingress resource groups in line with the `ingress.alb.yc.io/group-settings-name` annotations [specified for the Ingress resources](#create-ingress).

## Check the result {#check-result}

[Get log group IDs](../../application-load-balancer/operations/application-load-balancer-get-log-group-id.md) for the new L7 load balancers and make sure they match the settings in the `settings.yaml` file:

* One of the load balancers should use your custom log group with defined rules.
* Another should use the default log group.
* For the third load balancer, logging should be disabled.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. [Delete](../../vpc/operations/address-delete.md) the cluster public static IP address if you reserved one.
    1. [Delete the service accounts](../../iam/operations/sa/delete.md).
    1. [Delete the log group](../../logging/operations/delete-group.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
