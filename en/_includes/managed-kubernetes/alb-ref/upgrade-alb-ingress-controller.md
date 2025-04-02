# Updating an {{ alb-name }} Ingress controller for {{ managed-k8s-name }}

[ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) versions 0.2.0 and later are not compatible with versions 0.1.x. This causes limitations associated with [backend groups](../../../application-load-balancer/tools/k8s-ingress-controller/principles.md).

One of the ways to create a backend group is to specify [rules](../../../application-load-balancer/k8s-ref/ingress.md#rule) in the `Ingress` resource. In ALB Ingress Controller versions prior to 0.2.0, each backend group corresponds to a bundle of `host`, `http.paths.path`, and `http.paths.pathType` parameters. In versions 0.2.0 and later, the backend group corresponds to the `backend.service` parameter in the `Ingress` resource. This parameter specifies [{{ k8s }}](../../../managed-kubernetes/concepts/service.md). For more information about parameter values and the `Ingress` resource configuration, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/).

If upgrading the ALB Ingress Controller from version 0.1.x to version 0.2.0 or later, check whether the following cases apply to your `Ingress` resource groups (groups are formed according to the `ingress.alb.yc.io/group-name` annotation value in the `Ingress` resources):

* The configurations feature the same values for the `host`, `http.paths.path`, and `http.paths.pathType` parameters, while different {{ k8s }} services are specified in the `backend.service.name` parameters. In this case, recreate the backend groups using the [HttpBackendGroup](../../../managed-kubernetes/tutorials/alb-ingress-controller.md#create-ingress-and-apps) objects.

* There is one {{ k8s }} service per multiple bundles of the `host`, `http.paths.path`, and `http.paths.pathType` parameters. In this case, check if the backend settings in the `backend` parameter are different. For example, one group of `Ingress` resources can establish connections using the gRPC protocol, while another group can establish connections using the HTTP protocol.

   If the backend settings do not differ, there is no need to change the configuration. If they differ, follow the steps below:

   1. Create a separate `Service` object configuration file for each `Ingress` resource group. In the object, specify the following:

      * Its name. Use a different name for each service.
      * `Deployment` object name. This name must be the same for each service, since only one {{ k8s }} service was previously used.
      * Backend settings that are different for `Ingress` resource groups.

      {% cut "Sample configuration file" %}

      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
        name: alb-demo-service-1 # Specify different names for each service.
      spec:
        selector:
          app: alb-demo-app # Specify one Deployment for each service.
        type: NodePort
        ports:
          ... # Specify the settings that are different for Ingress resource groups.
      ```

      {% endcut %}

   1. Apply the resulting configurations:

      ```bash
      kubectl apply -f <configuration_file_names>
      ```

   1. Change the names of the {{ k8s }} services in the `Ingress` resources. In the `backend.service.name` parameter, specify the name of the service according to the group in which the `Ingress` resource is located.
   1. Apply the changed `Ingress` resource configurations:

      ```bash
      kubectl apply -f <Ingress_resource_file_names>
      ```

{% note info %}

If you cannot change the configuration of the `Ingress` resources, do not update the ALB Ingress Controller. Otherwise, there will be collisions.

{% endnote %}
