# Creating or updating {{ alb-name }} resources based on {{ managed-k8s-name }} configuration

To manage {{ alb-name }} resources using an [Ingress controller](../tools/k8s-ingress-controller/index.md){% if product == "yandex-cloud" %} and [Gateway API](../tools/k8s-gateway-api/index.md){% endif %} for {{ managed-k8s-full-name }}, create a configuration consisting of YAML files with descriptions of {{ k8s }} resources: `Ingress`, `HttpBackendGroup`{% if product == "yandex-cloud" %}, `Gateway`, `HTTPRoute`{% endif %}, and so on. For more information about the configuration, see the [{{ managed-k8s-name }} tool reference](../k8s-ref/index.md).

## Before you begin {#prerequisites}

1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Install an Ingress controller](k8s-ingress-controller-install.md){% if product == "yandex-cloud" %} or [Gateway API](k8s-gateway-api-install.md){% endif %}.
1. Creating a configuration. For more information, see {% if product == "yandex-cloud" %}the [Ingress controller](../tools/k8s-ingress-controller/index.md) and [Gateway API](../tools/k8s-gateway-api/index.md) descriptions and the [reference](../k8s-ref/index.md) for these tools{% endif %}{% if product == "cloud-il" %}the Ingress controller [description](../tools/k8s-ingress-controller/index.md) and [reference](../k8s-ref/index.md){% endif %}.

## Applying a configuration {#apply}

To apply a configuration:
1. Select the folder with the configuration files.
1. Run the following command:

   ```bash
   kubectl apply -f .
   ```

   Applying a configuration might take a few minutes.

1. If you're using the Ingress controller and added a new resource named `Ingress` to the configuration, make sure it's created and has a public IP address assigned:

   ```bash
   kubectl get ingress <Ingress_resource_name>
   ```

   Result:

   ```
   NAME            CLASS   HOSTS          ADDRESS       PORTS    AGE
   <Ingress_name>  <none>  <domain_name>  <IP_address>  80, 443  15h
   ```

   The `ADDRESS` column must contain an IP address. Otherwise, the load balancer has not been created, or has been created with an error. Check the logs for a [pod](../../managed-kubernetes/concepts/index.md#pod) called `yc-alb-ingress-controller-*` (not `yc-alb-ingress-controller-hc-*`).