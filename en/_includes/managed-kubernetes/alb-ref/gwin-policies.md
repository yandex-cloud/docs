# Gwin policies

Gwin is a tool for creating {{ alb-full-name }} load balancers and managing them in [{{ managed-k8s-full-name }} clusters](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster).

The controller supports the [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) and [Gateway API](https://gateway-api.sigs.k8s.io/) specifications. There is a policy mechanism to configure additional {{ alb-name }} features beyond the standard {{ k8s }} specification. The policies are managed with the help of [CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) or annotations.

Additional features offered by {{ alb-name }}:

* [Logging](../../../application-load-balancer/concepts/application-load-balancer.md#logging) and setting up log discard rules.
* [Autoscaling](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) with resource unit control.
* [Zonal traffic management](../../../application-load-balancer/concepts/application-load-balancer.md#lb-location) for high availability of services.
* Flexible load balancing settings, including [traffic locality](../../../application-load-balancer/concepts/backend-group.md#locality) and [panic mode](../../../application-load-balancer/concepts/backend-group.md#panic-mode).
* Request processing rate limit at virtual host level.
* [Security profiles](../../../smartwebsecurity/concepts/profiles.md) and [WAF protection](../../../smartwebsecurity/concepts/waf.md).
* [Security groups](../../../vpc/concepts/security-groups.md).
* Integration with the {{ yandex-cloud }} services: [{{ certificate-manager-full-name }}](../../../certificate-manager/index.yaml) and [{{ cloud-logging-full-name }}](../../../logging/index.yaml).

These features are enabled by the policy mechanism. It also allows you to:

* Extend standard resources using annotations without changing the specifications for these resources.
* Create complex configurations out of multiple policy resources.
* Combine both methods for more flexibility.

## Configuring policies {#configure-policies}

There are two equally effective ways to configure policies: using annotations and policy resources.

* Annotations allow you to quickly add specific settings to standard resources. Annotations support dot notation to create complex nested configurations and write them in `key:value` format.

  Here is an example:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: example-ingress
      annotations:
        gwin.yandex.cloud/subnets: "subnet-1,subnet2"
        gwin.yandex.cloud/logs.logGroupId: "group-1"
        gwin.yandex.cloud/rules.backends.balancing.mode: "ROUND_ROBIN"
    spec:
      ...
    ```

* Policy resources means policies represented as separate resources.

  Here is an example:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: example-ingress
    spec:
      ...
    ---
    apiVersion: gwin.yandex.cloud/v1
    kind: IngressPolicy
    metadata:
      name: example-ingress-policy
    spec:
      targetRefs:
        - kind: Ingress
          name: example-ingress
      policy:
        subnets: ["subnet-1", "subnet2"]
        logs:
          logGroupId: "group-1"
        rules:
          backends:
            balancing:
              mode: "ROUND_ROBIN"
    ```

## Applying policies to target resources {#apply-policies}

You can apply policies to particular resources with the help of references (`targetRefs`) or selectors (`selector`).

Example of using a reference:

```yaml
kind: IngressPolicy
spec:
  targetRefs:
    - kind: Ingress
      name: my-app
...
```

Example of using a selector:

```yaml
kind: IngressPolicy
spec:
  selector:
    matchLabels:
      environment: production
 ...
```

{% note info %}

Policies operate only within a single {{ k8s }} namespace.

{% endnote %}

## Merging configurations {#config}

If multiple configuration sources are applied to a single resource, they merge. Settings merge recursively: nested objects join together at all levels. 

When merging, configurations are checked for conflicts: if different sources contain identical fields with different values, you get a resource validation error.

### Merge example {#merge-example}

`Ingress` resource with annotations:

```yaml
kind: Ingress
metadata:
  annotations:
    gwin.yandex.cloud/subnets: "subnet-1,subnet-2"
    gwin.yandex.cloud/logs.logGroupId: "group-1"
```

`IngressPolicy` policy resource:

```yaml
kind: IngressPolicy
spec:
  policy:
    securityGroups: ["sg-1"]
    rules:
      backends:
        balancing:
          mode: "ROUND_ROBIN"
```

The result of a merge into a single configuration:

```yaml
securityGroups: ["sg-1"]
logs:
  subnets: ["subnet-1", "subnet-2"]
  securityGroups: ["sg-1"]
  logGroupId: "group-1"
  rules:
    backends:
      balancing:
        mode: "ROUND_ROBIN"
```

### Merging global and specific settings {#merge-global-specific}

Some settings can be specified either for all objects of a certain type and for an individual object. Individual object settings do not override global settings; therefore, a conflict may occur if different configuration sources have different values in the same field.


Here is an example of conflicting configurations:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-gateway
  annotations:
    # The setting is specified for all listeners:
    gwin.yandex.cloud/listeners.http.protocolSettings.allowHTTP10: "true"
spec:
  ...
```

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-gateway
  annotations:
    # The setting is specified for the _api_ listener:
    gwin.yandex.cloud/listener.api.http.protocolSettings.allowHTTP10: "false"
spec:
  ...
```

## Troubleshooting {#troubleshooting}

If you have any issues with policies:

  1. Check the status of resources. You can find validation errors in the `.status.conditions` field of the object description or in the {{ k8s }} events.
  1. Make sure you use the correct namespace.
  1. Make sure `targetRefs` or `selector` refers to relevant resources.
  1. If there are multiple configuration sources, make sure the same fields in different sources have the same values.