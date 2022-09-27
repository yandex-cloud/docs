# Creating or modifying {{ alb-name }} resources based on {{ managed-k8s-name }} Ingress controller configuration

The [{{ alb-name }} Ingress controller for {{ managed-k8s-full-name }}](../tools/k8s-ingress-controller/index.md) manages {{ alb-name }} resources based on your configuration in the form of YAML files describing {{ k8s }} resources, such as `Ingress`, `Service`, `HttpBackendGroup`, and so on. For more detail on the configuration, please see the [Ingress controller reference](../k8s-ref/index.md).

## Before you start {#prerequisites}

1. {% include [kubectl-install-links](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Install the Ingress controller](k8s-ingress-controller-install.md).
1. Creating a configuration. For more information, please see the [description](../tools/k8s-ingress-controller/index.md) and the controller reference.

## Applying a configuration {#apply}

To apply a configuration:
1. Select the folder with the configuration files.
1. Run the following command:

   ```bash
   kubectl apply -f .
   ```

   Applying a configuration might take a few minutes.
1. If a new `Ingress` resource has been added to the configuration, check that it is there and has a public IP address:

   ```bash
   kubectl get ingress <Ingress resource name>
   ```

   Result:

   ```
   NAME            CLASS   HOSTS          ADDRESS       PORTS    AGE
   <Ingress name>  <none>  <domain name>  <IP address>  80, 443  15h
   ```

   The `ADDRESS` column must contain an IP address. Otherwise, the load balancer has not been created, or has been created with an error. Check the logs for a [pod](../../managed-kubernetes/concepts/index.md#pod) called `yc-alb-ingress-controller-*` (not `yc-alb-ingress-controller-hc-*`).