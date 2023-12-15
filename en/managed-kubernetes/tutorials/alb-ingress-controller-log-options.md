# Logging settings for Ingress controllers {{ alb-name }}

You can configure the logging settings for [L7 balancers](../../application-load-balancer/concepts/application-load-balancer.md) created with {{ alb-name }} [Ingress controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) within a {{ managed-k8s-name }} cluster.

This article explains how to create three L7 balancers with different logging settings:

* Save logs to the [default group](../../logging/concepts/log-group.md).
* Save logs to a custom group.
* No logging.

To configure L7 balancers:

1. [{#T}](#install-app)
1. [{#T}](#create-ingress)
1. [{#T}](#configure-group)
1. [{#T}](#check-result)

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% list tabs %}

- Manually

   1. Create the following [service accounts](../../iam/operations/sa/create.md) for the {{ managed-k8s-name }} cluster:

      * Service account for the resources with the [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) role for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where the [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) is being created.
      * Service account for nodes with the [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) role to the folder with the Docker image [registry](../../container-registry/concepts/registry.md). Nodes will download the Docker images they require from the registry on behalf of this account.
      * Service account for the operation of the {{ alb-name }} Ingress controller with the following roles:

         * [{{ roles-alb-editor }}](../../iam/concepts/access-control/roles.md#alb-editor): To create the required resources.
         * [{{ roles-vpc-public-admin }}](../../iam/concepts/access-control/roles.md#vpc-public-admin): To manage [external connectivity](../../vpc/security/index.md#roles-list).
         * [certificate-manager.certificates.downloader](../../iam/concepts/access-control/roles.md#certificate-manager-certificates-downloader): To use certificates registered in [{{ certificate-manager-full-name }}](../../certificate-manager/).
         * [compute.viewer](../../iam/concepts/access-control/roles.md#compute-viewer): To use {{ managed-k8s-name }} cluster nodes in balancer [target groups](../../application-load-balancer/concepts/target-group.md).

      You can use the same service account for all operations.

   1. [Create an authorized key](../../iam/operations/authorized-key/create.md) for the service account of the Ingress controller in JSON format and save it to `key.json`:

      ```bash
      yc iam key create \
         --service-account-name <Ingress_controller_service_account_name> \
         --output key.json
      ```

      The key data is required for the [installation](#install-alb-ingress-controller) of the ALB Ingress Controller application.

   1. [Create a {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) and a [node group](../operations/node-group/node-group-create.md). When creating a cluster, specify the previously created service accounts for the resources and nodes and choose `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}` in the **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** setting.

   1. Configure security groups:

      * [For the {{ managed-k8s-name }} cluster and node group](../operations/connect/security-groups.md).
      * [For the {{ alb-name }} load balancers](../../application-load-balancer/concepts/application-load-balancer.md#security-groups).

   1. [Create a custom {{ cloud-logging-name }} log group](../../logging/operations/create-group.md).

- Using {{ TF }}

   1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
   1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
   1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
   1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

   1. Download the [k8s-and-registry-for-alb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-and-registry-for-alb.tf) configuration file to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and rules required for the operation of the [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) and [{{ alb-name }} load balancers](../../application-load-balancer/concepts/application-load-balancer.md).
      * {{ managed-k8s-name }} cluster.
      * [Service account](../../iam/concepts/users/service-accounts.md) for {{ managed-k8s-name }} resources and nodes.
      * Service account for the operation of the {{ alb-name }} Ingress controller.
      * [Custom {{ cloud-logging-name }} log group](../../logging/concepts/log-group.md).
      * [Authorized key](../../iam/concepts/authorization/key.md) for the service account of the Ingress controller.
      * Creating a local `key.json` file with authorized key data. The key data is required for the [installation](#install-alb-ingress-controller) of the ALB Ingress Controller application.

   1. In the `k8s-and-registry-for-alb.tf` file, specify:

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

### Before you start working with the {{ managed-k8s-name }} cluster {#prepare-k8s-cluster}

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Install the {{ k8s }} Helm package manager](https://helm.sh/docs/intro/install).

### Register a domain zone {#register-domain}

[Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).

### Install the {{ alb-name }} Ingress controller {#install-alb-ingress-controller}

Install the [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) application by following [this guide](../operations/applications/alb-ingress-controller.md). During the installation, use the `key.json` key data from [{#T}](#deploy-infrastructure).

## Create a test application {#install-app}

Create [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) with NGINX, and [Service](https://kubernetes.io/docs/concepts/services-networking/service/) objects for the application.

1. Create an `app.yaml` application file:

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

1. Create an application:

   ```bash
   kubectl apply -f app.yaml
   ```

   Result:

   ```text
   configmap/alb-demo-1 created
   deployment.apps/alb-demo-1 created
   service/alb-demo-1 created
   ```

## Configure the Ingress controllers {#create-ingress}

Create three [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) resources from which the {{ alb-name }} Ingress controller will create three balancers with the required listeners and HTTP routers.

1. Create an `ingress.yaml` file with the balancer settings and domain name:

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

   * `ingress.alb.yc.io/group-name`: Grouping of {{ k8s }} Ingress resources, with each group served by a separate {{ alb-name }} instance.
   * `ingress.alb.yc.io/subnets`: One or more [subnets](../../vpc/concepts/network.md#subnet) that {{ alb-name }} is going to work with.
   * `ingress.alb.yc.io/security-groups`: One or more [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) for {{ alb-name }}. If you skip this parameter, the default security group will be used.
   * `ingress.alb.yc.io/external-ipv4-address`: Providing public online access to {{ alb-name }}. When set to `auto`, a new IP address is used. Deleting the Ingress controller also deletes the IP address from the cloud.
   * `ingress.alb.yc.io/group-settings-name`: Name for the group settings to be described in the optional `IngressGroupSettings` resource.

   (Optional) Enter advanced controller settings:

   * `ingress.alb.yc.io/internal-ipv4-address`: Provide internal access to {{ alb-name }}. Enter the internal IP address or use `auto` to obtain the IP address automatically.

      {% note info %}

      You can only use one type of access to {{ alb-name }} at a time: `ingress.alb.yc.io/external-ipv4-address` or `ingress.alb.yc.io/internal-ipv4-address`.

      {% endnote %}

   * `ingress.alb.yc.io/internal-alb-subnet`: Subnet for hosting the {{ alb-name }} internal IP address. This parameter is required if the `ingress.alb.yc.io/internal-ipv4-address` parameter is selected.
   * `ingress.alb.yc.io/protocol`: Connection protocol used by the load balancer and the backends:

      * `http`: HTTP/1.1; default value
      * `http2`: HTTP/2
      * `grpc`: gRPC

   * `ingress.alb.yc.io/transport-security`: Encryption protocol used by the connections between the load balancer and the backends:

      * `tls`: TLS with no certificate challenge.

      If no annotation is specified, the load balancer connects to the backends with no encryption.

   * `ingress.alb.yc.io/prefix-rewrite`: Replace the path for the specified value.
   * `ingress.alb.yc.io/upgrade-types`: Valid values for the `Upgrade` HTTP header, e.g., `websocket`.
   * `ingress.alb.yc.io/request-timeout`: Maximum period for which the connection can be established.
   * `ingress.alb.yc.io/idle-timeout`: Maximum connection keep-alive time with zero data transmission.

      Values for `request-timeout` and `idle-timeout` must be specified with units of measurement, e.g., `300ms`, `1.5h`. Acceptable units of measurement include:
      * `ns`: Nanoseconds
      * `us`: Microseconds
      * `ms`: Milliseconds
      * `s`: Seconds
      * `m`: Minutes
      * `h`: Hours

   {% note info %}

   The settings only apply to the hosts of the given controller rather than the entire Ingress group.

   {% endnote %}

   For more information about the Ingress resource settings, see [{#T}](../../application-load-balancer/k8s-ref/ingress.md).

1. Create Ingress controllers:

   ```bash
   kubectl apply -f ingress.yaml
   ```

   Result:

   ```text
   ingress.networking.k8s.io/logs-demo-nondefault created
   ingress.networking.k8s.io/logs-demo-disabled created
   ingress.networking.k8s.io/logs-demo-default created
   ```

   Three [L7 load balancers](../../application-load-balancer/concepts/application-load-balancer.md) will be automatically deployed based on the Ingress controller configurations.

## Configure the Ingress controller groups {#configure-group}

Create an `IngressGroupSettings` resource with the logging settings for the Ingress controller groups:

* `non-default-settings`: Log to the [previously](#deploy-infrastructure) created custom log group with defined rules.
* `logs-disabled-settings`: Disable logging.

No settings need to be specified to save logs to the default log group.

1. Create a `settings.yaml` file with the log group ID:

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

1. Apply the settings for the Ingress controller groups:

   ```bash
   kubectl apply -f settings.yaml
   ```

   Result:

   ```text
   ingressgroupsettings.alb.yc.io/non-default-settings created
   ingressgroupsettings.alb.yc.io/logs-disabled-settings created
   ```

## Check the result {#check-result}

[Get the log group IDs](../../application-load-balancer/operations/application-load-balancer-get-log-group-id.md) for the created L7 balancers and make sure they match the settings in the `settings.yaml` file:

* One of the balancers should use your custom log group with defined rules.
* Another should use the default log group.
* For the third balancer, logging should be disabled.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

- Manually

   1. [Delete the {{ managed-k8s-name }} cluster](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
   1. If you reserved a public static IP address for the cluster, [delete it](../../vpc/operations/address-delete.md).
   1. [Delete the service accounts](../../iam/operations/sa/delete.md).
   1. [Delete the log group](../../logging/operations/delete-group.md).

- Using {{ TF }}

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `k8s-and-registry-for-alb.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point them out.

   1. Confirm updating the resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All resources described in the `k8s-and-registry-for-alb.tf` configuration file will be deleted.

{% endlist %}
