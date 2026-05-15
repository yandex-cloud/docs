{% include [Gwin-with-preset](../../application-load-balancer/ingress-to-gwin-tip-with-preset.md) %}

To manage {{ alb-name }} resources using an [ingress controller]({{ ingress-local-link }}/index.md) and {{ managed-k8s-full-name }} [Gateway API]({{ gateway-local-link }}/index.md), create YAML configuration files describing {{ k8s }} resources, e.g., `Ingress`, `HttpBackendGroup`, `Gateway`, `HTTPRoute`, etc.

## Getting started {#prerequisites}

1. {% include [kubectl-install](../../managed-kubernetes/kubectl-install.md) %}
1. [Install the ingress controller]({{ ingress-install-local-link }}) or [Gateway API]({{ gateway-install-local-link }}).
1. Create a resource. For available resource configurations, see [{#T}]({{ alb-local-link }}/index.md).

## Applying a configuration {#apply}

To apply a configuration:
1. Navigate to the folder with configuration files.
1. Run the following command:

   ```bash
   kubectl apply -f .
   ```

   Applying a configuration may take a few minutes.

1. After defining a new `Ingress` resource for your ingress controller to implement, make sure it was successfully created and got a public IP address:

   ```bash
   kubectl get ingress <Ingress_resource_name>
   ```

   Result:

   ```
   NAME            CLASS   HOSTS          ADDRESS       PORTS   AGE
   <Ingress_name>  <none>  <domain_name>  <IP_address>  80,443  15h
   ```

   The IP address should appear in the `ADDRESS` column. Otherwise, the load balancer was not created or was created with an error. Check the logs for the `yc-alb-ingress-controller-*` [pod](../../../managed-kubernetes/concepts/index.md#pod). (Do not confuse it with the `yc-alb-ingress-controller-hc-*` pod.)