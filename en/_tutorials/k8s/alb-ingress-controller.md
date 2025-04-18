# Configuring an {{ alb-full-name }} L7 load balancer using an Ingress controller

The [{{ alb-full-name }}](../../application-load-balancer/) service is designed for load balancing and traffic distribution across applications. To use it for managing ingress traffic of applications running in a [{{ managed-k8s-name }} cluster](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), you need an [Ingress controller](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

To set up access to the applications running in your {{ managed-k8s-name }} cluster via an {{ alb-name }} L7 load balancer:

1. [Set up the Ingress resource and test applications](#create-ingress-and-apps).
1. [(Optional) Configure the Ingress resource group](#configure-group).
1. [Make sure the {{ managed-k8s-name }} cluster applications are accessible via {{ alb-name }}](#verify-setup).

For full configuration of the resources for the {{ alb-name }} Ingress controller, see the following sections:

* [Ingress](../../managed-kubernetes/alb-ref/ingress.md): Backend traffic distribution and load balancer configuration rules.
* [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md), [GrpcBackendGroup](../../managed-kubernetes/alb-ref/grpc-backend-group.md): Combining backends into groups.
* [IngressClass](../../managed-kubernetes/alb-ref/ingress-class.md): Managing multiple Ingress controllers in a {{ k8s }} cluster.
* [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md): Description of {{ k8s }} services used as backends.


## Required paid resources {#paid-resources}

The support cost includes:

* Fee for a DNS zone and DNS requests (see [{{ dns-name }} pricing](../../dns/pricing.md)).
* Fee for the {{ managed-k8s-name }} cluster: using the master and outgoing traffic (see [{{ managed-k8s-name }} pricing](../../managed-kubernetes/pricing.md)).
* Cluster nodes (VM) fee: using computing resources, operating system, and storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for using the computing resources of the L7 load balancer (see [{{ alb-name }} pricing](../../application-load-balancer/pricing.md)).
* Fee for public IP addresses for cluster nodes and L7 load balancer (see [{{ vpc-name }} pricing](../../vpc/pricing.md#prices-public-ip)).
* {{ objstorage-name }} bucket fee: Storing data and performing operations with it (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).


## Getting started {#before-you-begin}

1. [Register a public domain zone and delegate your domain](../../dns/operations/zone-create-public.md).

1. If you already have a certificate for the domain zone, [add its details](../../certificate-manager/operations/import/cert-create.md) to the [{{ certificate-manager-full-name }}](../../certificate-manager/) service. Alternatively, you can [add a new {{ lets-encrypt }} certificate](../../certificate-manager/operations/managed/cert-create.md).

1. Get the ID of the certificate you added:

    ```bash
    yc certificate-manager certificate list
    ```

    What the command should return:

    ```text
    +----------------------+-----------+----------------+---------------------+----------+--------+
    |          ID          |   NAME    |    DOMAINS     |      NOT AFTER      |   TYPE   | STATUS |
    +----------------------+-----------+----------------+---------------------+----------+--------+
    | fpq8diorouhp******** | sert-test |    test.ru     | 2022-01-06 17:19:37 | IMPORTED | ISSUED |
    +----------------------+-----------+----------------+---------------------+----------+--------+
    ```

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}
1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. [Install an {{ alb-name }} Ingress controller](../../managed-kubernetes/operations/applications/alb-ingress-controller.md).


1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}


1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [Run kubectl cluster-info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Set up the Ingress resource and test applications {#create-ingress-and-apps}

The [Ingress resource](../../application-load-balancer/k8s-ref/ingress.md) defines:

* L7 load balancer parameters set using annotations.
* Rules for distribution of incoming traffic between [{{ k8s }} services](../../application-load-balancer/k8s-ref/service-for-ingress.md).

    Services acting as {{ alb-name }} backends may be specified in the Ingress resource either directly or as part of [HttpBackendGroup](../../application-load-balancer/k8s-ref/http-backend-group.md)/[GrpcBackendGroup](../../application-load-balancer/k8s-ref/grpc-backend-group.md) backend groups.

Create test applications and an Ingress resource:

{% list tabs %}

- Ingress resource for {{ k8s }} services

  1. In a separate directory, create the `demo-app-1.yaml` and `demo-app-2.yaml` application configuration files:

     {% cut "demo-app-1.yaml" %}

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

     {% cut "demo-app-2.yaml" %}

     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: alb-demo-2
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
               return 200 'Add app#';
             }
             location = /app2 {
               add_header Content-Type text/plain;
               return 200 'This is APP#2';
             }
           }
         }
     ---
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: alb-demo-2
       labels:
         app: alb-demo-2
         version: v1
     spec:
       replicas: 2
       selector:
         matchLabels:
           app: alb-demo-2
       strategy:
         type: RollingUpdate
         rollingUpdate:
           maxSurge: 1
           maxUnavailable: 0
       template:
         metadata:
           labels:
             app: alb-demo-2
             version: v1
         spec:
           terminationGracePeriodSeconds: 5
           volumes:
             - name: alb-demo-2
               configMap:
                 name: alb-demo-2
           containers:
             - name: alb-demo-2
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
                 - name: alb-demo-2
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
       name: alb-demo-2
     spec:
       selector:
         app: alb-demo-2
       type: NodePort
       ports:
         - name: http
           port: 80
           targetPort: 80
           protocol: TCP
           nodePort: 30082
     ```

     {% endcut %}

  1. In the same directory, create a file named `ingress.yaml` and specify in it the [previously delegated domain name](#before-you-begin), [ID of the certificate obtained earlier](#before-you-begin), and settings for the {{ alb-name }} L7 load balancer:

     ```yaml
     apiVersion: networking.k8s.io/v1
     kind: Ingress
     metadata:
       name: alb-demo-tls
       annotations:
         ingress.alb.yc.io/subnets: <list_of_subnet_IDs>
         ingress.alb.yc.io/security-groups: <list_of_security_group_IDs>
         ingress.alb.yc.io/external-ipv4-address: <IP_address_assignment_method>
         ingress.alb.yc.io/group-name: my-ingress-group
     spec:
       tls:
         - hosts:
             - <domain_name>
           secretName: yc-certmgr-cert-id-<TLS_certificate_ID>
       rules:
         - host: <domain_name>
           http:
             paths:
               - path: /app1
                 pathType: Prefix
                 backend:
                   service:
                     name: alb-demo-1
                     port:
                       number: 80
               - path: /app2
                 pathType: Prefix
                 backend:
                   service:
                     name: alb-demo-2
                     port:
                       number: 80
               - pathType: Prefix
                 path: "/"
                 backend:
                   service:
                     name: alb-demo-2
                     port:
                       name: http
     ```

     Where:

     * `ingress.alb.yc.io/subnets`: One or more subnets hosting the {{ alb-name }} L7 load balancer.
     * `ingress.alb.yc.io/security-groups`: One or more [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) for the load balancer. If you skip this parameter, the default security group will be used. At least one of the security groups must allow an outgoing TCP connection to port `10501` in the {{ managed-k8s-name }} node group subnet or to its security group.
     * `ingress.alb.yc.io/external-ipv4-address`: Public access to the load balancer from the internet. Enter the [IP address you got earlier](../../vpc/operations/get-static-ip.md) or set `auto` to get a new IP address automatically.

       If you set `auto`, deleting the load balancer from the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) will also delete the [IP address](../../vpc/concepts/address.md). To avoid this, use an existing reserved IP address.

     * `ingress.alb.yc.io/group-name`: Group name. Ingress resources are grouped together, each group served by a separate load balancer.

       You can replace `my-ingress-group` with any group name you like. Make sure it meets the naming [requirements]({{ k8s-docs }}/concepts/overview/working-with-objects/names/).

     In [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions prior to 0.2.0, each backend group corresponds to a bundle of `host`, `http.paths.path`, and `http.paths.pathType` parameters. In versions 0.2.0 and later, the backend group corresponds to the `backend.service` parameter. This may cause collisions when updating the ALB Ingress Controller. To avoid them, [find out whether upgrade restrictions apply](../../managed-kubernetes/operations/applications/upgrade-alb-ingress-controller.md) to your infrastructure.

     (Optional) Enter the advanced settings for the load balancer:

     {% cut "Additional settings" %}

     {% include [alb-ingress-balancer-additional-settings](../_tutorials_includes/alb-ingress-balancer-additional-settings.md) %}

     Available settings:

     * `ingress.alb.yc.io/group-settings-name`: Name for the Ingress resource group settings to be described in the optional `IngressGroupSettings` resource. For more information, see [Configure the Ingress resource group](#configure-group).
     * `ingress.alb.yc.io/internal-ipv4-address`: Provide internal access to the load balancer. Enter the internal IP address or use `auto` to obtain the IP address automatically.

       {% note info %}

       You can only use one type of access to the load balancer at a time: `ingress.alb.yc.io/external-ipv4-address` or `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet`: Subnet to host the load balancer. This parameter is required if the `ingress.alb.yc.io/internal-ipv4-address` parameter is selected.
     * `ingress.alb.yc.io/protocol`: Connection protocol used between the load balancer and backends:
       * `http`: HTTP/1.1, default
       * `http2`: HTTP/2
       * `grpc`: gRPC
     * `ingress.alb.yc.io/transport-security`: Encryption protocol for connections between the load balancer and backends.

        {% note warning %}

        In [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) version 0.2.0 and later, you can only use an annotation in the [Service](../../application-load-balancer/k8s-ref/service-for-ingress.md#metadata) object.

        If you annotate `Ingress` resources that use a single service with the same settings for backend groups, such annotation will apply correctly. However, this mechanism is obsolete and will not be supported going forward.

        {% endnote %}

        The valid value is `tls`: TLS with no certificate challenge.

        If no annotation is specified, the load balancer connects to the backends with no encryption.
     * `ingress.alb.yc.io/prefix-rewrite`: Replace the path for the specified value.
     * `ingress.alb.yc.io/upgrade-types`: Valid values of the `Upgrade` HTTP header, e.g., `websocket`.
     * `ingress.alb.yc.io/request-timeout`: Maximum period for which a connection can be established.
     * `ingress.alb.yc.io/idle-timeout`: Maximum connection keep-alive time without data transmission.

       The `request-timeout` and `idle-timeout` values must be specified with units of measurement, e.g., `300ms` or `1.5h`. Valid units of measurement:
       * `ns`, nanoseconds
       * `us`, microseconds
       * `ms`, milliseconds
       * `s`, seconds
       * `m`, minutes
       * `h`, hours

     * `ingress.alb.yc.io/security-profile-id`: Support for [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md) that allows you to get protected against DDoS attacks and bots, plus enable [WAF](../../smartwebsecurity/concepts/waf.md) and [limit the load](../../smartwebsecurity/concepts/arl.md) on the resource you are protecting.

       To enable support for {{ sws-full-name }}, specify the previously created {{ sws-name }} [security profile](../../smartwebsecurity/concepts/profiles.md) in the Ingress annotation:

       ```yaml
       ingress.alb.yc.io/security-profile-id: <security_profile_ID>
       ```

       {% include [sws-editor-role](../../_includes/managed-kubernetes/alb-ref/sws-editor-role.md) %}

     * `ingress.alb.yc.io/use-regex`: Support for [RE2](https://github.com/google/re2/wiki/Syntax) regular expressions when matching the request path. If the `true` string is provided, the support is enabled. Only applies if the `pathType` parameter is set to `Exact`.

     * `ingress.alb.yc.io/balancing-panic-threshold`: [Panic mode](../../application-load-balancer/concepts/backend-group.md#panic-mode) threshold. The mode will be activated if the percentage of healthy endpoints falls below this value. The default value is `0`, which means the panic mode will never be activated.

     * `ingress.alb.yc.io/balancing-locality-aware-routing`: Percentage of incoming traffic the load balancer forwards to backends from its availability zone. The remaining traffic is evenly distributed between other availability zones. The default value is `0`. [More on locality aware routing](../../application-load-balancer/concepts/backend-group.md#locality).

     * `ingress.alb.yc.io/autoscale-max-size`: Maximum total number of resource units. By default, this number is unlimited. Make sure the value is more or equal to the number of load balancer availability zones multiplied by the minimum number of resource units per zone. [Learn more about the autoscaling settings here](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings).

     * `ingress.alb.yc.io/modify-header-response-append`: Adds a string to the response header value. The header and string should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-response-append: <name_of_header_to_edit>=<string>
       ```

     * `ingress.alb.yc.io/modify-header-response-replace`: Replaces the response header value. The header and its new value should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-response-replace: <name_of_header_to_edit>=<new_header_value>
       ```

     * `ingress.alb.yc.io/modify-header-response-rename`: Renames the response header. The header and its new name should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-response-rename: <name_of_header_to_edit>=<new_header_name>
       ```

     * `ingress.alb.yc.io/modify-header-response-remove`: Removes the response header. The header to remove should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-response-remove: <name_of_header_to_delete>=true

     * `ingress.alb.yc.io/modify-header-request-append`: Adds a string to the request header value. The header and string should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-request-append: <name_of_header_to_edit>=<string>
       ```

     * `ingress.alb.yc.io/modify-header-request-replace`: Replaces the request header value. The header and its new value should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-request-replace: <name_of_header_to_edit>=<new_header_value>
       ```

     * `ingress.alb.yc.io/modify-header-request-rename`: Renames the request header. The header and its new name should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-request-rename: <name_of_header_to_edit>=<new_header_name>
       ```

     * `ingress.alb.yc.io/modify-header-request-remove`: Removes the request header. The header to remove should be specified in the following format:

       ```yaml
       ingress.alb.yc.io/modify-header-request-remove: <name_of_header_to_delete>=true
       ```

     {% endcut %}

     If you use several Ingress controllers, create an [IngressClass](../../managed-kubernetes/alb-ref/ingress-class.md) resource for each of them. In the `Ingress` configuration, specify the `IngressClass` you need in the `spec.ingressClassName` field.

     For more information about the `Ingress` resource settings, see [{#T}](../../managed-kubernetes/alb-ref/ingress.md).

  1. Create {{ k8s }} applications and the Ingress resource:

     ```bash
     kubectl apply -f .
     ```

     ALB Ingress Controller will automatically deploy the [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) using Ingress resource configuration.

  1. Wait until the {{ alb-name }} L7 load balancer is created and gets a public IP address. This may take several minutes.

     To follow the load balancer's creation and make sure it is error-free, open the logs of the pod the creation process was run in:

     1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Click your cluster's name and select **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
     1. Select one of the `alb-demo-***` pods the load balancer's creation was run in.
     1. Go to the **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}** tab on the pod page.

        The load balancer's creation logs are generated and displayed in real time. Any errors that occur will also be logged.

  1. Make sure the load balancer was created. To do this, run the appropriate command and check that the command output shows the following value in the `ADDRESS` field:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Result:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <domain_name>  <IP_address>  80,443  15h
     ```

- Ingress resource for a backend group

  1. Create a [backend group with a bucket](../../application-load-balancer/operations/backend-group-create.md#with-s3-bucket):
     1. Create a [public bucket in {{ objstorage-name }}](../../tutorials/web/static/console.md#create-public-bucket).
     1. [Configure the website home page and error page](../../tutorials/web/static/console.md).
  1. Create a configuration file named `demo-app-1.yaml` for your application:

     {% cut "demo-app-1.yaml" %}

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

  1. In a separate directory, create a file named `http-group.yaml` with the `HttpBackendGroup` resource settings:

     ```yaml
     apiVersion: alb.yc.io/v1alpha1
     kind: HttpBackendGroup
     metadata:
       name: example-backend-group
     spec:
       backends: # List of backends.
         - name: alb-demo-1
           weight: 70 # Backend relative weight when distributing traffic. The load will be distributed in proportion to the weights of the group's other backends. Specify the weight even if you have only one backend in the group.
           service:
              name: alb-demo-1
              port:
                number: 80
         - name: bucket-backend
           weight: 30
           storageBucket:
             name: <bucket_name>
     ```

     (Optional) Enter the advanced settings for the backend group:
     * `spec.backends.useHttp2`: `HTTP/2` mode.
     * `spec.backends.tls`: Certificate from the certificate authority the load balancer will trust when establishing a secure connection with backend endpoints. Specify the certificate contents in the `trustedCa` field in plain text.

     For more information, see [{#T}](../../application-load-balancer/concepts/backend-group.md).

  1. In the same directory, create a file named `ingress-http.yaml` and specify in it the [previously delegated domain name](#before-you-begin), [ID of the certificate obtained earlier](#before-you-begin), and settings for the {{ alb-name }} L7 load balancer:

     ```yaml
     apiVersion: networking.k8s.io/v1
     kind: Ingress
     metadata:
       name: alb-demo-tls
       annotations:
         ingress.alb.yc.io/subnets: <list_of_subnet_IDs>
         ingress.alb.yc.io/security-groups: <list_of_security_group_IDs>
         ingress.alb.yc.io/external-ipv4-address: <IP_address_assignment_method>
         ingress.alb.yc.io/group-name: my-ingress-group
     spec:
       tls:
         - hosts:
           - <domain_name>
           secretName: yc-certmgr-cert-id-<TLS_certificate_ID>
       rules:
         - host: <domain_name>
           http:
             paths:
               - path: /app1
                 pathType: Exact
                 backend:
                   resource:
                     apiGroup: alb.yc.io
                     kind: HttpBackendGroup
                     name: example-backend-group
     ```

     Where:
     * `ingress.alb.yc.io/subnets`: One or more subnets hosting the {{ alb-name }} L7 load balancer.
     * `ingress.alb.yc.io/security-groups`: One or more [security groups](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) for the load balancer. If you skip this parameter, the default security group will be used. At least one of the security groups must allow an outgoing TCP connection to port `10501` in the {{ managed-k8s-name }} node group subnet or to its security group.
     * `ingress.alb.yc.io/external-ipv4-address`: Public access to the load balancer from the internet. Enter the [IP address you got earlier](../../vpc/operations/get-static-ip.md) or set `auto` to get a new IP address automatically.

       If you set `auto`, deleting the load balancer from the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) will also delete the [IP address](../../vpc/concepts/address.md). To avoid this, use an existing reserved IP address.

     * `ingress.alb.yc.io/group-name`: Group name. Ingress resources are grouped together, each group served by a separate load balancer.

       You can replace `my-ingress-group` with any group name you like. Make sure it meets the naming [requirements]({{ k8s-docs }}/concepts/overview/working-with-objects/names/).

     (Optional) Enter the advanced settings for the load balancer.

     {% include [alb-ingress-balancer-additional-settings](../_tutorials_includes/alb-ingress-balancer-additional-settings.md) %}

     Available settings:

     * `ingress.alb.yc.io/group-settings-name`: Name for the Ingress resource group settings to be described in the optional `IngressGroupSettings` resource. For more information, see [Configure the Ingress resource group](#configure-group).
     * `ingress.alb.yc.io/internal-ipv4-address`: Provide internal access to the load balancer. Enter the internal IP address or use `auto` to obtain the IP address automatically.

       {% note info %}

       You can only use one type of access to the load balancer at a time: `ingress.alb.yc.io/external-ipv4-address` or `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet`: Subnet to host the load balancer. This parameter is required if the `ingress.alb.yc.io/internal-ipv4-address` parameter is selected.
     * `ingress.alb.yc.io/protocol`: Connection protocol used between the load balancer and backends:
       * `http`: HTTP/1.1. Default
       * `http2`: HTTP/2
       * `grpc`: gRPC
     * `ingress.alb.yc.io/prefix-rewrite`: Replace the path for the specified value.
     * `ingress.alb.yc.io/upgrade-types`: Valid values of the `Upgrade` HTTP header, e.g., `websocket`.
     * `ingress.alb.yc.io/request-timeout`: Maximum period for which a connection can be established.
     * `ingress.alb.yc.io/idle-timeout`: Maximum connection keep-alive time without data transmission.

       The `request-timeout` and `idle-timeout` values must be specified with units of measurement, e.g., `300ms` or `1.5h`. Valid units of measurement:
       * `ns`, nanoseconds
       * `us`, microseconds
       * `ms`, milliseconds
       * `s`, seconds
       * `m`, minutes
       * `h`, hours

     * `ingress.alb.yc.io/security-profile-id`: Support for [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md) that allows you to get protected against DDoS attacks and bots, plus enable [WAF](../../smartwebsecurity/concepts/waf.md) and [limit the load](../../smartwebsecurity/concepts/arl.md) on the resource you are protecting.

       To enable support for {{ sws-full-name }}, specify the previously created {{ sws-name }} [security profile](../../smartwebsecurity/concepts/profiles.md) in the Ingress annotation:

       ```yaml
       ingress.alb.yc.io/security-profile-id: <security_profile_ID>
       ```

       {% include [sws-editor-role](../../_includes/managed-kubernetes/alb-ref/sws-editor-role.md) %}

     * `ingress.alb.yc.io/use-regex`: Support for [RE2](https://github.com/google/re2/wiki/Syntax) regular expressions when matching the request path. If the `true` string is provided, the support is enabled. Only applies if the `pathType` parameter is set to `Exact`.

     For more information about the Ingress resource settings, see [{#T}](../../managed-kubernetes/alb-ref/ingress.md).
  1. Create the {{ k8s }} app, `HttpBackendGroup` resource, and Ingress resource:

     ```bash
     kubectl apply -f .
     ```

    ALB Ingress Controller will automatically deploy the [L7 load balancer](../../application-load-balancer/concepts/application-load-balancer.md) using Ingress resource configuration.

  1. Wait until the {{ alb-name }} L7 load balancer is created and gets a public IP address. This may take several minutes.

     To follow the load balancer's creation and make sure it is error-free, open the logs of the pod the creation process was run in:

     1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Click your cluster's name and select **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}** in the left-hand panel.
     1. Select one of the `alb-demo-***` pods the load balancer's creation was run in.
     1. Go to the **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}** tab on the pod page.

        The load balancer's creation logs are generated and displayed in real time. Any errors that occur will also be logged.

  1. Make sure the load balancer was created. To do this, run the appropriate command and check that the command output shows the following value in the `ADDRESS` field:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Result:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <domain_name>  <IP_address>  80,443  15h
     ```

{% endlist %}

By default, the {{ alb-name }} Ingress controller receives application [health check](../../application-load-balancer/concepts/backend-group.md#health-checks) requests from the L7 load balancer at TCP port `10501` and health checks the [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) pods on each cluster node. If `kube-proxy` is healthy, then, even though an application does not respond in a particular pod, {{ k8s }} will redirect traffic to a different pod with that application or to a different node.

You can use the [HttpBackendGroup](../../application-load-balancer/k8s-ref/http-backend-group.md)/[GrpcBackendGroup](../../application-load-balancer/k8s-ref/grpc-backend-group.md) resource parameters to customize health checks. For more information, see [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

## (Optional) Configure the Ingress resource group {#configure-group}

If you specified a name for the Ingress resource group settings in the `ingress.alb.yc.io/group-settings-name` annotation when setting up the Ingress resource, you can specify logging settings for the L7 load balancer. To do this, [create a custom log group](../../logging/operations/create-group.md) and specify the Ingress resource group settings in the optional `IngressGroupSettings` resource:

1. Create a `settings.yaml` file with your logging settings and the custom log group ID, e.g.:

    ```yaml
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: <name_for_Ingress_resource_group_settings>
    logOptions:
      logGroupID: <user_log_group_ID>
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
    ```

    Where `name` is the name for the Ingress resource group settings in the `ingress.alb.yc.io/group-settings-name` annotation.

1. Apply the settings for the Ingress resource group:

    ```bash
    kubectl apply -f settings.yaml
    ```

## Make sure the applications are accessible via the L7 load balancer {#verify-setup}

1. If you have no [ExternalDNS with a plugin for {{ dns-name }}](/marketplace/products/yc/externaldns) installed, [add an A record to your domain zone](../../dns/operations/resource-record-create.md). In the **Value** field, specify the public IP address of the {{ alb-name }} L7 load balancer. If you are using ExternalDNS with a plugin for {{ dns-full-name }}, this record will be created automatically.

1. Test the load balancer:

   {% list tabs %}

   - Ingress resource for {{ k8s }} services

     Open the application URIs in your browser:

     ```http
     https://<your_domain>/app1
     https://<your_domain>/app2
     ```

     Make sure the applications are accessible via the {{ alb-name }} L7 load balancer and return pages with the `This is APP#1` and `This is APP#2` text, respectively.

     {% include [Configuring security groups if the resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   - Ingress resource for a backend group

     Open the application's URI in your browser:

     ```http
     https://<your_domain>/app1
     ```

     Make sure the target resources are accessible via the {{ alb-name }} L7 load balancer.

     {% include [Configuring security groups if the resource is unavailable](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   {% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the {{ managed-k8s-name }} cluster](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
1. [Delete the {{ alb-name }} target groups](../../application-load-balancer/operations/target-group-delete.md).
1. [Delete the {{ objstorage-name }} bucket](../../storage/operations/buckets/delete.md).
