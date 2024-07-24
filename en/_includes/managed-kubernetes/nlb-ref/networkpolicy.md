# Fields and annotations of the NetworkPolicy resource

`NetworkPolicy` is a resource used for connecting to services published via {{ network-load-balancer-name }} from specified IP addresses.

`NetworkPolicy` is a standard {{ k8s }} resource. This reference describes the resource's fields and annotations supporting {{ network-load-balancer-name }} for {{ managed-k8s-name }}. For a complete reference for the resource, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/network-policy-v1/).

For more information about network policies, see [{#T}](../../../managed-kubernetes/concepts/network-policy.md).

## NetworkPolicy {#network-policy}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: <ObjectMeta>
spec: <NetworkPolicySpec>
```

#|
|| **Field**     | **Value or type**   | **Description**                   ||
|| `apiVersion` | `networking.k8s.io/v1` | **Required**
Kubernetes API version          ||
|| `kind`       | `NetworkPolicy`        | Resource type                    ||
|| `metadata`   | `ObjectMeta`           | **Required**
[Resource metadata](#metadata) ||
|| `spec`       | `NetworkPolicySpec`    | **Required**
[Resource specification](#spec)   ||
|#

{% cut "Example" %}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: whitelist-netpol
  namespace: ns-example
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - ipBlock:
        cidr: 198.18.235.0/24
    - ipBlock:
        cidr: 198.18.248.0/24
    - ipBlock:
        cidr: 172.16.1.0/12
```

{% endcut %}

## ObjectMeta {#metadata}

```yaml
name: <string>
namespace: <string>
```

#|
|| **Field**      | **Value or type** | **Description** ||
|| `name`        | `string`             | **Required**
[Policy name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names) ||
|| `namespace` | `string`  | [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) for saving the policy ||
|#

## NetworkPolicySpec {#spec}

```yaml
podSelector: <selectorRules>
policyTypes:
  - Ingress
ingress:
  - <IngressRule>
  - ...
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `podSelector`   | `LabelSelector` | **Required**
[Pod](../../../managed-kubernetes/concepts/index.md#pod) filtering rules.

See [the {{ k8s }} documentation](https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/label-selector/#LabelSelector)
||

|| `policyTypes`    | `[]Policy`      | **Required**
Policy type. `Ingress` only.
||

|| `ingress` | `[]IngressRule` | **Required**
[List of traffic filtering rules](#rule)
||
|#

### IngressRule {#rule}

```yaml
from:
  - ipBlock: <IPBlock>
  - ...
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `from`   | `[]IPBlock`          | **Required**
List of [IP address ranges](#ipblock) allowed to access the load balancer
||
|#

### IPBlock {#ipblock}

```yaml
ipBlock:
  cidr: <string>
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `cidr`      | `string`       | **Required**
Range of IP addresses allowed to access the load balancer.

The `198.18.235.0/24` and `198.18.248.0/24` ranges are always specified because they are [reserved by {{ network-load-balancer-name }}](../../../network-load-balancer/concepts/health-check.md#target-statuses) for node health checks.
||
|#