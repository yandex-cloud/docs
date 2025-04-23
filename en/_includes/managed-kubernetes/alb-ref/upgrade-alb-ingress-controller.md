# Upgrading an {{ alb-name }} Ingress controller for {{ managed-k8s-name }}

[ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions 0.2.0 are incompatible with any 0.1.x releases. This incompatibility causes [backend groups](../../../application-load-balancer/tools/k8s-ingress-controller/principles.md) limitations.

One method for creating a backend group involves specifying [rules](../../../application-load-balancer/k8s-ref/ingress.md#rule) directly in the `Ingress` resource. Pre-0.2.0 ALB Ingress Controller versions map each backend group to a distinct combination of `host`, `http.paths.path`, and `http.paths.pathType` values. ALB Ingress Controllers v0.2.0 and later map backend groups to the `backend.service` setting of the `Ingress` resource. This setting specifies a [{{ k8s }} service](../../../managed-kubernetes/concepts/service.md). For more information about `Ingress` resource configuration and settings, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/services-networking/ingress/).

When upgrading your ALB Ingress Controller from version 0.1.x to 0.2.0 or later, check whether any of the following scenarios apply to your `Ingress` resource groups, .i.e., `Ingress` resources with matching `ingress.alb.yc.io/group-name` values:

* They are configured with the same `host`, `http.paths.path`, and `http.paths.pathType` combinations, but different `backend.service.name`, i.e., {{ k8s }} service, values. In this case, recreate your backend groups as [HttpBackendGroup](../../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps) custom resources.

* There is one {{ k8s }} service per multiple `host`, `http.paths.path`, and `http.paths.pathType` combinations. In this case, check whether their `backend` setitngs differ. For example, one `Ingress` resource group can route gRPC traffic, while another handles HTTP connections.

   If backend settings match, no configuration changes are needed. Otherwise, follow the steps below:

   1. Create an individual `Service` configuration file for each `Ingress` resource group and specify the following settings:

      * `Service name`: Use a different name for each service.
      * `Deployment`: This name must be the same for all services, as you previously used only one {{ k8s }} service.
      * Backend settings differing between `Ingress` resource groups.

      {% cut "Sample configuration file" %}

      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: alb-demo-service-1 # Specify different names for each service.
      spec:
        selector:
          app: alb-demo-app # Specify the same Deployment for each service.
        type: NodePort
        ports:
          ... # Specify the settings differing for Ingress resource groups.
      ```

      {% endcut %}

   1. Apply the configurations:

      ```bash
      kubectl apply -f <configuration_file_names>
      ```

   1. Change {{ k8s }} service names in the `Ingress` resources. In the `backend.service.name` setting, specify the service name associated with the `Ingress` resource’s group.
   1. Apply the updated `Ingress` resource configurations:

      ```bash
      kubectl apply -f <Ingress_resource_file_names>
      ```

{% note info %}

If you cannot change the `Ingress` resource configuration, do not upgrade the ALB Ingress Controller, or it will lead to collisions.

{% endnote %}
