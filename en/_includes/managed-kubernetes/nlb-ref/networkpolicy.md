# `NetworkPolicy` resource fields and annotations

`NetworkPolicy` is a resource used for managing access to services published via {{ network-load-balancer-name }} based on IP addresses.

`NetworkPolicy` is a standard {{ k8s }} resource. This reference describes the resource fields and annotations supported by {{ network-load-balancer-name }} for {{ managed-k8s-name }}. For a complete `NetworkPolicy` resource reference, see [this {{ k8s }} article](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/network-policy-v1/).

For more information about network policies, see [{#T}](../../../managed-kubernetes/concepts/network-policy.md).

## NetworkPolicy {#network-policy}

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata: <ObjectMeta>
spec: <NetworkPolicySpec>
```

#|
|| **Field**     | **Value / Type**   | **Description**                   ||
|| `apiVersion` | `networking.k8s.io/v1` | **This is a required field**
                                           Kubernetes API version.          ||
|| `kind`       | `NetworkPolicy`        | Resource type                    ||
|| `metadata`   | `ObjectMeta`           | **This is a required field**
                                          [Resource metadata](#metadata). ||
|| `spec`       | `NetworkPolicySpec`    | **This is a required field**
                                          [Resource specification](#spec).   ||
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
|| **Field**      | **Value / Type** | **Description** ||
|| `name`        | `string`             | **This is a required field**
[Policy name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names). ||
|| `namespace` | `string`  | [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) for the policy ||
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
|| **Field** | **Value / Type** | **Description** ||
|| `podSelector`   | `LabelSelector` | **This is a required field**
[Pod](../../../managed-kubernetes/concepts/index.md#pod) filtering rules.

See [this {{ k8s }} article](https://kubernetes.io/docs/reference/kubernetes-api/common-definitions/label-selector/#LabelSelector).
||

|| `policyTypes`    | `[]Policy`      | **This is a required field**
Policy type. The only value is `Ingress`.
||

|| `ingress` | `[]IngressRule` | **This is a required field**
[List of traffic filtering rules](#rule).
||
|#

### IngressRule {#rule}

```yaml
from:
  - ipBlock: <IPBlock>
  - ...
```

#|
|| **Field** | **Value / Type** | **Description** ||
|| `from`   | `[]IPBlock`          | **This is a required field**
List of [IP address ranges](#ipblock) allowed to access the load balancer.
||
|#

### IPBlock {#ipblock}

```yaml
ipBlock:
  cidr: <string>
```

#|
|| **Field** | **Value / Type** | **Description** ||
|| `cidr`      | `string`       | **This is a required field**
Range of IP addresses allowed to access the load balancer.

The `198.18.235.0/24` and `198.18.248.0/24` ranges are always specified as they are [reserved by {{ network-load-balancer-name }}](../../../network-load-balancer/concepts/health-check.md#target-statuses) for node health checks.
||
|#