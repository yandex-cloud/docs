# Migrating services from a NLB with target resources from a {{ managed-k8s-full-name }} cluster to an L7 ALB


You [can use](../../network-load-balancer/concepts/scenarios.md#nlb-mk8s) a [{{ network-load-balancer-full-name }}](../../network-load-balancer/) load balancer as part of services within a [{{ managed-k8s-full-name }}](../../managed-kubernetes/) cluster. The cluster itself creates network load balancer objects according to the manifests provided and monitors the load balancer's target group receiving VMs from that cluster's node groups.

One of the options for a network load balancer in a {{ managed-k8s-name }} cluster is to use it as part of an [nginx Ingress controller](../../managed-kubernetes/operations/applications/ingress-nginx.md).

This tutorial covers the migration from a network load balancer to an [{{ alb-full-name }}](../../application-load-balancer/) L7 load balancer created by an [{{ alb-name }} Ingress controller](../../application-load-balancer/tools/k8s-ingress-controller/index.md), with a [{{ sws-full-name }}](../../smartwebsecurity/) security profile connected.

To migrate a service from a network load balancer to an L7 load balancer:

1. [See recommendations for service migration](#recommendations).
1. [Complete the prerequisite steps](#before-you-begin).
1. [Create a {{ sws-name }} profile](#create-profile-sws).
1. [Install an {{ alb-name }} Ingress controller and create resources in your {{ managed-k8s-name }} cluster](#install-ingress-nginx). At this step, you will connect your {{ sws-name }} profile to the L7 load balancer.
1. [Migrate user load from the network load balancer to the L7 load balancer](#migration-nlb-to-alb).

## Service migration recommendations {#recommendations}

1. In addition to DDoS protection at level L7 of the OSI model using [{{ sws-full-name }}](../../smartwebsecurity/), we recommend enabling DDoS protection at L3-L4. To do this, [reserve a public static IP address with DDoS protection](../../vpc/operations/enable-ddos-protection.md#enable-on-reservation) in advance and use this address for the L7 load balancer's listener.

    If the network load balancer's listener already uses a public IP address with DDoS protection, you can save it and use it for the L7 load balancer.

    If the network load balancer's listener uses a public IP address without DDoS protection, the only way to enable L7 load balancer DDoS protection at level L3-L4 is to change the public IP address for your service.

    When using L3-L4 DDoS protection, configure a trigger threshold for the L3-L4 protection mechanisms aligned with the amount of legitimate traffic to the protected resource. To set up this threshold, contact [support]({{ link-console-support }}).

    Also, set the MTU value to `1450` for the target resources downstream of the load balancer. For more information, see [Setting up MTU when enabling DDoS protection](../../vpc/operations/adjust-mtu-ddos-protection.md).

1. We recommend performing migration during the hours when user load is at its lowest. If you plan to keep your public IP address, bear in mind that migration involves moving this IP address from the load balancer to the L7 load balancer. Your service will be unavailable during this period. Under normal conditions, this may last for several minutes. After the user load is migrated from the network load balancer to the L7 load balancer, it may take time for the L7 balancer's resource unit group to autoscale depending on the external load on the load balancer nodes.

1. When using an L7 load balancer, requests to backends come with the source IP address from the range of internal IP addresses of the subnets specified when creating the L7 load balancer. The original IP address of the request source (user) is specified in the `X-Forwarded-For` header. If you want to log public IP addresses of users on the web server, reconfigure it.

1. For the L7 load balancer, two [resource units](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) will be created in each of the subnets specified when creating the `Ingress` resource. The `Ingress` resource annotations do not support specifying the minimum number of resource units for an L7 load balancer. A group of resource units is automatically scaled depending on the external load on load balancer nodes.

1. The features of the {{ alb-name }} load balancer may differ from those of your load balancer deployed in the {{ managed-k8s-name }} cluster. See the [{{ alb-name }} Ingress controller description](../../application-load-balancer/tools/k8s-ingress-controller/index.md) and [operating principles](../../application-load-balancer/tools/k8s-ingress-controller/principles.md).

## Getting started {#before-you-begin}

1. [Create subnets](../../vpc/operations/subnet-create.md) in three availability zones. These will be used for the L7 load balancer.

1. Create [security groups](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) that allow the L7 load balancer to receive incoming traffic and send it to the target resources and allow the target resources to receive incoming traffic from the load balancer.

1. When using HTTPS, [add your service's TLS certificate](../../certificate-manager/operations/import/cert-create.md#create-certificate) to [{{ certificate-manager-full-name }}](../../certificate-manager/).

1. [Reserve a static public IP address with DDoS protection](../../vpc/operations/get-static-ip.md) at level L3-L4 for the L7 load balancer. See [service migration recommendations](#recommendations).

1. The {{ managed-k8s-name }} services used as backends must be of the `NodePort` type. If your services employ another type, change it to `NodePort`. For more details on this type, please see the [{{ k8s }}](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) documentation.

## Create a {{ sws-name }} security profile {#create-profile-sws}

[Create](../../smartwebsecurity/operations/profile-create.md) a {{ sws-name }} security profile by selecting **{{ ui-key.yacloud.smart-web-security.title_default-template }}**.

Use these settings when creating the profile:

* In the **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** field, select `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
* For the **{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}** rule, enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**.

These settings are limited to logging the info about the traffic without applying any actions to it. This will reduce the risk of disconnecting users due to profile configuration issues. As you move along, you will be able to turn **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** off and configure some prohibiting rules for your use case in the security profile.

## Install an {{ alb-name }} Ingress controller and create resources in your {{ managed-k8s-name }} cluster {#install-ingress-nginx}

1. [Install an {{ alb-full-name }}](../../managed-kubernetes/operations/applications/alb-ingress-controller.md) Ingress controller.

1. Create an [IngressClass](../../application-load-balancer/k8s-ref/ingress-class.md) resource for the L7 load balancer's Ingress controller:

    1. Create a YAML file and describe the `IngressClass` resource in it.

        {% cut "Example of IngressClass resource" %}

        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: IngressClass
        metadata:
          labels:
            app.kubernetes.io/component: controller
          name: ingress-alb
        spec:
          controller: ingress.alb.yc.io/yc-alb-ingress-controller
        ```

        {% endcut %}

    1. Use the following command to create the `IngressClass` resource:

        ```bash
        kubectl apply -f <IngressClass_resource_file>
        ```

1. Create an `Ingress` resource:

    1. Read the descriptions of the [`Ingress` resource fields and annotations](../../managed-kubernetes/alb-ref/ingress.md) and see [the example](../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps).

    1. Create a YAML file and describe the `Ingress` resource in it:

        * Complete the [annotations](../../managed-kubernetes/alb-ref/ingress.md#annotations) section for the L7 load balancer settings:

            * `ingress.alb.yc.io/subnets`: IDs of the subnets in the three availability zones for the L7 load balancer nodes. Specify the IDs separated by commas with no spaces.
            * `ingress.alb.yc.io/security-groups`: ID of one or more security groups for the L7 load balancer. For multiple groups, specify their IDs separated by commas with no spaces.
            * `ingress.alb.yc.io/external-ipv4-address`: Previously reserved static public IP address.
            * `ingress.alb.yc.io/group-name`: Name of the `Ingress` resource group. `Ingress` resources are grouped together, each group served by a separate {{ alb-name }} instance with a dedicated public IP address.
            * `ingress.alb.yc.io/security-profile-id`: ID of the previously created {{ sws-name }} security profile.

                {% note warning %}

                The security profile will be linked to the virtual host of the L7 load balancer. Specifying your security profile is the key step to connecting {{ sws-name }}.

                {% endnote %}

        * For the `ingressClassName` field, enter the name of the `IngressClass` resource you created earlier.

        * When using HTTPS, complete the [tls](../../managed-kubernetes/alb-ref/ingress#tls) section:

            * `hosts`: Your service domain name the TLS certificate corresponds to.
            * `secretName`: TLS certificate of your service in {{ certificate-manager-full-name }}, in `yc-certmgr-cert-id-<certificate_ID>` format.

        * Complete the [rules](../../managed-kubernetes/alb-ref/ingress.md#rule) section in line with your rules for distribution of incoming traffic among backends depending on the domain name (`host` field) and requested resource (`http.paths` field).

            * `host`: Your service domain name.
            * `pathType`: Type of reference to the requested resource:

                * `Exact`: Request URI path must match the `path` field value.
                * `Prefix`: Request URI path must start with the `path` field value.

            * `path`: Incoming request URI path (if `Exact`) or its prefix (if `Prefix`).
            * `backend`: Reference to a [backend or group of backends](../../managed-kubernetes/alb-ref/ingress.md#backend) to process the requests with the specified domain name and URI path. Specify either a service backend (`service`) or a backend group (`resource`) but not both.

                * `service`: {{ managed-k8s-name }} service to process the requests as a backend:

                    * `name`: {{ managed-k8s-name }} service name. The `Service` resource this field refers to must be described in line with [this configuration](../../application-load-balancer/k8s-ref/service-for-ingress.md).
                    * `port`: Service port `Ingress` is going to address. For the service port, specify either a number (`number`) or a name (`name`) but not both.

                    {% note warning %}

                    The {{ managed-k8s-name }} services used as backends must be of the `NodePort` type.

                    {% endnote %}

                * `resource`: Reference to the `HttpBackendGroup` group of backends to process the requests. A group like this may have {{ managed-k8s-name }} services or [{{ objstorage-full-name }}](../../storage/concepts/bucket.md) buckets as backends. When using a backend group, advanced {{ alb-name }} functionality is available. You can also specify relative backend weights to allocate traffic to them in proportion.

                    * `kind`: `HttpBackendGroup`.
                    * `name`: Backend group name. The name must match the value specified in the `metadata.name` field of the `HttpBackendGroup` resource. The `HttpBackendGroup` resource this field refers to must be described in line with [this configuration](../../application-load-balancer/k8s-ref/http-backend-group.md).
                    * `apiGroup`: `alb.yc.io`.

        {% cut "Example of Ingress resource" %}

        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: Ingress
        metadata:
          name: <resource_name>
          annotations:
            ingress.alb.yc.io/subnets: <ru-central1-a_subnet_ID,ru-central1-b_subnet_ID,ru-central1-d_subnet_ID>
            ingress.alb.yc.io/security-groups: <L7_load_balancer_security_group_ID>
            ingress.alb.yc.io/external-ipv4-address: <static_public_IP_address>
            ingress.alb.yc.io/group-name: <resource_group_name>
            ingress.alb.yc.io/security-profile-id: <Smart_Web_Security_security_profile_ID>
        spec:
          ingressClassName: <IngressClass_resource_name>
          tls:
            - hosts:
                - <service_domain_name>
              secretName: yc-certmgr-cert-id-<certificate_ID>
          rules:
            - host: <service_domain_name>
              http:
                paths:
                - path: /
                  pathType: Prefix
                  backend:
                    service:
                      name: <Kubernetes_service_name>
                      port:
                        number: <port_number_e.g._443>
        ```

        {% endcut %}

    1. Use the following command to create the `Ingress` resource:

        ```bash
        kubectl apply -f <Ingress_resource_file>
        ```

1. An L7 load balancer will be deployed based on the `Ingress` resource configuration. Wait until its creation is complete and `Ingress` has a public IP address linked. You will need this IP address to check requests. You can view resource info using this command:

    ```bash
    kubectl get ingress <Ingress_resource_name> -w
    ```

1. Run a test request to the service through the L7 load balancer, for example, using one of these methods:

    * Add this record to the `hosts` file on your workstation: `<L7_load_balancer_public_IP_address> <service_domain_name>`. Delete the record after the test.
    * Execute the request using {{ api-examples.rest.tool }} depending on the protocol type:

        ```bash
        curl http://<service_domain_name> \
            --resolve <service_domain_name>:80:<L7_load_balancer_public_IP_address>
        ```

        ```bash
        curl https://<service_domain_name> \
            --resolve <service_domain_name>:443:<L7_load_balancer_public_IP_address>
        ```

## Migrate user load from the network load balancer to the L7 load balancer {#migration-nlb-to-alb}

Select one of the migration options:

* [Keep the public IP address for your service](#save-public-ip).
* [Do not keep public IP address for your service](#not-save-public-ip).

### Keep the public IP address for your service {#save-public-ip}

1. If your external network load balancer uses a dynamic public IP address, [convert it to static](../../vpc/operations/set-static-ip.md).

1. [Delete all listeners](../../network-load-balancer/operations/listener-remove.md) in the network load balancer to release the static public IP address. This will make your service unavailable through the network load balancer.

1. In the L7 load balancer, assign to the listener the public IP address previously assigned to the network load balancer:

    1. Open the YAML file that describes the `Ingress` resource.
    1. Under `annotations`, for the `ingress.alb.yc.io/external-ipv4-address` field, specify the public IP address previously assigned to the network load balancer.
    1. Apply changes using this command:

        ```bash
        kubectl apply -f <Ingress_resource_file>
        ```

1. Wait for the `Ingress` resource to finish changing its public IP address. You can view resource info using this command:

    ```bash
    kubectl get ingress <Ingress_resource_name> -w
    ```

    After the IP addresses changes, your service will again be available through the L7 load balancer.

1. Go to the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), go to the folder the {{ managed-k8s-name }} cluster is in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster you need.
    1. Select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left, and the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer's user load from the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Delete the released static public IP address previously reserved for the L7 load balancer.

1. (Optional) [Delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating user load to the L7 load balancer.

### Do not keep the public IP address for your service {#not-save-public-ip}

1. To migrate user load from a network load balancer to an L7 load balancer, in the DNS service of your domain's public zone, change the A record value for the service domain name to the public IP address of the L7 load balancer. If the public domain zone was created in [{{ dns-full-name }}](../../dns/), change the record using this guide.

    {% note info %}

    The propagation of DNS record updates depends on the time-to-live (TTL) value and the number of links in the DNS request chain. This process can take a long time.

    {% endnote %}

1. As the DNS record updates propagate, follow the increase of requests to the L7 load balancer:

    1. In the [management console]({{ link-console-main }}), go to the folder the {{ managed-k8s-name }} cluster is in.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
    1. Select the cluster you need.
    1. Select ![image](../../_assets/console-icons/timestamps.svg) **{{ ui-key.yacloud.k8s.cluster.switch_network }}** on the left, and the **{{ ui-key.yacloud.k8s.network.label_ingress }}** tab on the right. For your `Ingress` resource, follow the L7 load balancer link in the **Load balancer** column.
    1. Monitor the L7 load balancer's user load from the [load balancer statistics](../../application-load-balancer/operations/application-load-balancer-get-stats.md) charts.

1. Follow the decrease of the network load balancer load using the `processed_bytes` and `processed_packets` [load balancer metrics](../../monitoring/metrics-ref/network-load-balancer-ref.md). You can [create a dashboard](../../monitoring/operations/dashboard/create.md) to visualize these metrics. The absence of load on the network load balancer for a prolonged period of time indicates that the user load has been transfered to the L7 load balancer.

1. (Optional) [Delete the network load balancer](../../network-load-balancer/operations/load-balancer-delete.md) after migrating user load to the L7 load balancer.
