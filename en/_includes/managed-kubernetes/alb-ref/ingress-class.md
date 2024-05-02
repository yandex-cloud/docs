# IngressClass resource fields and annotations

The `IngressClass` resource is a class of [Ingress](../../../application-load-balancer/k8s-ref/ingress.md) resources which supports simultaneous use of multiple Ingress controllers, e.g., {{ alb-name }} and NGINX. Each `IngressClass` resource refers to a different Ingress controller. As a result, you can route traffic through the `Ingress` resources of different controllers within the same application in a single {{ managed-k8s-name }} cluster.

If you are using multiple Ingress controllers, specify which controller the resource refers to in each `Ingress` resource. To do this, specify the `IngressClass` name of the controller in the [spec.ingressClassName](../../../application-load-balancer/k8s-ref/ingress.md#spec) field.

`IngressClass` is a standard {{ k8s }} resource. Its fields and annotations are described below. For more information on using and configuring the `IngressClass` resource, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/services-networking/ingress/#ingress-class). On GitHub, you can find an [example](https://github.com/yandex-cloud-examples/yc-mk8s-with-ingress-class) of how to configure `Ingress` resources and route traffic using multiple Ingress controllers.

## IngressClass {#ingress-class}

```yaml
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata: <ObjectMeta>
spec:
  controller: <string>
```

#|
|| **Field**         | **Value or type**      | **Description**                    ||
|| `apiVersion`      | `networking.k8s.io/v1` | **Required**.

Kubernetes API version. ||
|| `kind`            | `IngressClass`         | Resource type.                    ||
|| `metadata`        | `ObjectMeta`           | **Required**.

[Resource metadata](#metadata). ||
|| `spec`            | `IngressClassSpec`     | **Required**.

Resource specification. ||
|| `spec.controller` | `string`               | **Required**.

Name of the Ingress controller the `IngressClass` resource refers to. The possible values include:

* `ingress.alb.yc.io/yc-alb-ingress-controller`: {{ alb-name}} controller
* `k8s.io/ingress-nginx`: NGINX controller ||
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
|| **Field**     | **Value or type** | **Description** ||
|| `name`        | `string`          | **Required**.

Resource name. For more information about the format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

This name is also specified in the [spec.ingressClassName](../../../application-load-balancer/k8s-ref/ingress.md#spec) field in the `Ingress` resource. ||
|| `labels`      | `map[string]string`  | {{ k8s }} labels to manage and monitor {{ k8s }} objects.

The [recommended value](https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/) is `app.kubernetes.io/component: controller`. ||
|| `annotations` | `map[string]string`  | Resource annotations.

The available annotation is `ingressclass.kubernetes.io/is-default-class`. The annotation data type is `bool`. This annotation determines whether or not the `IngressClass` resource is used by default. If it is set to `true`, the `IngressClass` is automatically applied to `Ingress` resources in which `IngressClass` is not specified. ||
|#
