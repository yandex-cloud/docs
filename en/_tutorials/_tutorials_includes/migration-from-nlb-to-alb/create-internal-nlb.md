1. Create an internal network load balancer for the NGINX Ingress controller. Select an option that agrees with the method you initially used to deploy your NGINX Ingress controller:

    {% list tabs %}

    * Using a Helm chart

        1. Add the configuration parameters for the internal network load balancer to the `values.yaml` file you used to initially configure the NGINX Ingress controller. Leave the other parameters in the file unchanged.

            ```bash
            controller:
              service:
                external:
                  enabled: true
                internal:
                  enabled: true
                  annotations:
                    yandex.cloud/load-balancer-type: internal
                    yandex.cloud/subnet-id: <subnet_ID_for_internal_network_load_balancer_IP_address>
                  loadBalancerIP: <IP_address_of_internal_network_load_balancer_listener>
                  externalTrafficPolicy: Local
            ```

        1. Use this command to apply the NGINX Ingress controller configuration changes:

            ```bash
            helm upgrade <NGINX_Ingress_controller_name> -f values.yaml <chart_for_NGINX_Ingress_controller> -n <namespace>
            ```

    * Using a manifest

        1. Create a YAML file and describe the `Service` resource in it:

            ```bash
            apiVersion: v1
            kind: Service
            metadata:
              name: <resource_name>
              namespace: <namespace>
              annotations:
                yandex.cloud/load-balancer-type: internal
                yandex.cloud/subnet-id: <subnet_ID_for_internal_network_load_balancer_IP_address>
            spec:
              type: LoadBalancer
              externalTrafficPolicy: Local
              loadBalancerIP: <IP_address_of_internal_network_load_balancer_listener>
              ports:
              - port: <HTTP_port_number_e.g._80>
                targetPort: <HTTP_port_number_of_NGINX_Ingress_controller_pod_e.g._80>
                protocol: TCP
                name: http
              - port: <HTTPS_port_number_e.g._443>
                targetPort: <HTTPS_port_number_of_NGINX_Ingress_controller_pod_e.g._443>
                protocol: TCP
                name: https
              selector:
                <NGINX_Ingress_controller_pod_selectors>
            ```

        1. Apply the changes using this command:

        ```bash
        kubectl apply -f <Service_resource_file>
        ```

    {% endlist %}

1. Wait until the internal network load balancer is created and a matching `Service` object appears. You can use this command to view information about the services:

    ```bash
    kubectl get service
    ```
