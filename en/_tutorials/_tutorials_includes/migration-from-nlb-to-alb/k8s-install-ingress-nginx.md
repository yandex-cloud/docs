1. [Install the {{ alb-full-name }}](../../../managed-kubernetes/operations/applications/alb-ingress-controller.md) ingress controller.

1. Create an [IngressClass](../../../application-load-balancer/k8s-ref/ingress-class.md) resource for the L7 load balancer's Ingress controller:

    1. Create a YAML file and describe the `IngressClass` resource in it.

        `IngressClass` resource example:

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

    1. Use the following command to create the `IngressClass` resource:

        ```bash
        kubectl apply -f <IngressClass_resource_file>
        ```

1. Create an `Ingress` resource:

    1. Read the descriptions of the [`Ingress`](../../../managed-kubernetes/alb-ref/ingress.md) resource fields and annotations and see [the example](../../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps).

    1. Create a YAML file and describe the `Ingress` resource in it:

        * Complete the [annotations](../../../managed-kubernetes/alb-ref/ingress.md#annotations) section for the L7 load balancer settings:

            * `ingress.alb.yc.io/subnets`: IDs of the subnets in the three availability zones for the L7 load balancer nodes. Specify the IDs separated by commas with no spaces.
            * `ingress.alb.yc.io/security-groups`: ID of one or more security groups for the L7 load balancer. For multiple groups, specify their IDs separated by commas with no spaces.
            * `ingress.alb.yc.io/external-ipv4-address`: Previously reserved static public IP address.
            * `ingress.alb.yc.io/group-name`: Name of the `Ingress` resource group. `Ingress` resources are grouped together, each group served by a separate {{ alb-name }} instance with a dedicated public IP address.
            * `ingress.alb.yc.io/security-profile-id`: ID of the previously created {{ sws-name }} security profile.

                {% note warning %}

                The security profile will be linked to the virtual host of the L7 load balancer. Specifying your security profile is the key step to connecting {{ sws-name }}.

                {% endnote %}

            * `ingress.alb.yc.io/autoscale-min-zone-size`: [Minimum number of resource units](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings) per availability zone, based on expected load.

                We recommend selecting the number of resource units based on the load expressed in:

                * Number of requests per second (RPS)
                * Number of concurrent active connections
                * Number of new connections per second
                * Traffic processed per second

        * For the `ingressClassName` field, enter the name of the `IngressClass` resource you created earlier.

        * When using HTTPS, complete the [tls](../../../managed-kubernetes/alb-ref/ingress.md#tls) section:

            * `hosts`: Your service domain name the TLS certificate corresponds to.
            * `secretName`: TLS certificate of your service in {{ certificate-manager-full-name }}, in `yc-certmgr-cert-id-<certificate_ID>` format.

        * Complete the [rules](../../../managed-kubernetes/alb-ref/ingress.md#rule) section in line with your rules for distribution of incoming traffic among backends depending on the domain name (`host` field) and requested resource (`http.paths` field).

            * `host`: Your service domain name.
            * `pathType`: Type of reference to the requested resource:

                * `Exact`: Request URI path must match the `path` field value.
                * `Prefix`: Request URI path must start with the `path` field value.

            * `path`: Incoming request URI path (if `Exact`) or its prefix (if `Prefix`).
            * `backend`: Reference to a [backend or group of backends](../../../managed-kubernetes/alb-ref/ingress.md#backend) to process the requests with the specified domain name and URI path. Specify either a service backend (`service`) or a backend group (`resource`) but not both.

                * `service`: {{ managed-k8s-name }} backend service for processing requests:

                    * `name`: {{ managed-k8s-name }} service name. The `Service` resource this field refers to must be described in line with [this configuration](../../../application-load-balancer/k8s-ref/service-for-ingress.md).
                    * `port`: Service port `Ingress` is going to address. For the service port, specify either a number (`number`) or a name (`name`) but not both.

                    {% note warning %}

                    The {{ managed-k8s-name }} services used as backends must be of the `NodePort` type.

                    {% endnote %}

                * `resource`: Reference to the `HttpBackendGroup` group of backends to process the requests. A backend group can route traffic to either {{ managed-k8s-name }} services or [{{ objstorage-full-name }} buckets](../../../storage/concepts/bucket.md). When using a backend group, advanced {{ alb-name }} functionality is available. You can also specify relative backend weights to allocate traffic to them in proportion.

                    * `kind`: `HttpBackendGroup`
                    * `name`: Backend group name. The name must match the value specified in the `metadata.name` field of the `HttpBackendGroup` resource. The `HttpBackendGroup` resource this field refers to must be described in line with [this configuration](../../../application-load-balancer/k8s-ref/http-backend-group.md).
                    * `apiGroup`: `alb.yc.io`

        `Ingress` resource example:

        ```yaml
        apiVersion: networking.k8s.io/v1
        kind: Ingress
        metadata:
          name: <resource_name>
          annotations:
            ingress.alb.yc.io/subnets: <IDs_of_subnets_in_three_availability_zones>
            ingress.alb.yc.io/security-groups: <L7_load_balancer_security_group_ID>
            ingress.alb.yc.io/external-ipv4-address: <static_public_IP_address>
            ingress.alb.yc.io/group-name: <resource_group_name>
            ingress.alb.yc.io/security-profile-id: <Smart_Web_Security_security_profile_ID>
            ingress.alb.yc.io/autoscale-min-zone-size: <minimum_number_of_L7_load_balancer_resource_units_per_zone>
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
                        number: <443_or_another_port_number>
        ```

    1. Use the following command to create the `Ingress` resource:

        ```bash
        kubectl apply -f <Ingress_resource_file>
        ```

1. An L7 load balancer will be deployed based on the `Ingress` resource configuration. Wait until its creation is complete and `Ingress` has a public IP address linked. You will need this IP address to check requests. You can view resource info using this command:

    ```bash
    kubectl get ingress <Ingress_resource_name> -w
    ```
