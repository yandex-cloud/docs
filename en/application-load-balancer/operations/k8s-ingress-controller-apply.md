---
title: Creating or updating {{ alb-full-name }} resources based on {{ managed-k8s-full-name }} configuration
description: Follow this guide to create or update {{ alb-name }} resources based on {{ managed-k8s-name }} configuration.
---

# Creating or updating {{ alb-name }} resources based on {{ managed-k8s-name }} configuration

To manage {{ alb-name }} resources using an [Ingress controller](../tools/k8s-ingress-controller/index.md) and [Gateway API](../tools/k8s-gateway-api/index.md) for {{ managed-k8s-full-name }}, create a configuration consisting of YAML files with descriptions of {{ k8s }} resources: `Ingress`, `HttpBackendGroup`, `Gateway`, `HTTPRoute`, etc.

## Getting started {#prerequisites}

1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}
1. [Install the Ingress controller](k8s-ingress-controller-install.md) or [Gateway API](k8s-gateway-api-install.md).
1. Create a resource. For configurations of available resources, see [{#T}](../tools/index.md).

## Applying a configuration {#apply}

To apply a configuration:
1. Select the folder with the configuration files.
1. Run this command:

   ```bash
   kubectl apply -f .
   ```

   Applying a configuration might take a few minutes.

1. If you are using the Ingress controller and added a new resource named `Ingress` to the configuration, make sure it was created and got a public IP address:

   ```bash
   kubectl get ingress <Ingress_resource_name>
   ```

   Result:

   ```
   NAME            CLASS   HOSTS          ADDRESS       PORTS   AGE
   <Ingress_name>  <none>  <domain_name>  <IP_address>  80,443  15h
   ```

   The IP address should appear in the `ADDRESS` column. If it did not, the load balancer was not created or threw an error. Check the logs for the `yc-alb-ingress-controller-*` [pod](../../managed-kubernetes/concepts/index.md#pod) (not `yc-alb-ingress-controller-hc-*`).