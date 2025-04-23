# IngressClass resource fields and annotations

The `IngressClass` resource is a class of [Ingress](../../../application-load-balancer/k8s-ref/ingress.md) resources supporting simultaneous use of multiple ingress controllers, e.g., {{ alb-name }} and NGINX. Each `IngressClass` resource specifies a distinct ingress controller. This enables traffic routing across multiple `Ingress` controllers within the same application and {{ managed-k8s-name }} cluster.

When using multiple ingress controllers, explicitly declare the target controller for each `Ingress` resource. To do this, specify the relevant controller’s `IngressClass` in the [spec.ingressClassName](../../../application-load-balancer/k8s-ref/ingress.md#spec) field of the `Ingress` resource.

`IngressClass` is a standard {{ k8s }} resource. Its fields and annotations are described below. For more information on configuring and using `IngressClass` resources, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class). See a GitHub [example](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class) for configuring `Ingress` resources and routing traffic across multiple ingress controllers.

## IngressClass {#ingress-class}

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata: <ObjectMeta>
spec:
  controller: <string>
```

#|
|| **Field**          | **Value / Type**   | **Description**                    ||
|| `apiVersion`      | `networking.k8s.io/v1` | **This is a required field**.

Kubernetes API version. ||
|| `kind`            | `IngressClass`         | Resource type                    ||
|| `metadata`        | `ObjectMeta`           | **This is a required field**.

[Resource metadata](#metadata). ||
|| `spec`            | `IngressClassSpec`     | **This is a required field**.

Resource specification. ||
|| `spec.controller` | `string`               | **This is a required field**.

Ingress controller name specified by the `IngressClass` resource. The possible values are:

* `ingress.alb.yc.io/yc-alb-ingress-controller`: {{ alb-name}} controller.
* `k8s.io/ingress-nginx`: NGINX controller. ||
|#

{% cut "Example" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  labels:
    app.kubernetes.io/component: controller
  name: alb
  annotations:
    ingressclass.kubernetes.io/is-default-class: "true"
spec:
  controller: ingress.alb.yc.io/yc-alb-ingress-controller
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
labels:
  <string>: <string>
annotations:
  ingressclass.kubernetes.io/is-default-class: "<bool>"
```

#|
|| **Field**      | **Value / Type** | **Description** ||
|| `name`        | `string`             | **This is a required field**.

Resource name. For more information about the name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

This name is also specified in the [spec.ingressClassName](../../../application-load-balancer/k8s-ref/ingress.md#spec) field of the `Ingress` resource. ||
|| `labels`      | `map[string]string`  | {{ k8s }}: Metrics for {{ k8s }} object management and monitoring.

[We recommend](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/) you to specify `app.kubernetes.io/component: controller` in this field. ||
|| `annotations` | `map[string]string`  | Resource annotations.

Available annotation is `ingressclass.kubernetes.io/is-default-class`. The annotation data type is `bool`. This annotation specifies whether the `IngressClass` resource is used by default. When set to `"true"`, this `IngressClass` is automatically used for `Ingress` resources with no `IngressClass` specified. ||
|#
