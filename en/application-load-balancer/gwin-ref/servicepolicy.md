---
sourcePath: en/_gwin-ref/gwin-ref/servicepolicy.md
---
# ServicePolicy

ServicePolicy is a Gwin custom resource for configuring Service-specific policies. It allows you to configure how Kubernetes Services are used as ALB targets, controlling target selection, addressing, and zone matching.

ServicePolicy provides the same functionality as [Service](./service.md) annotations but through spec fields instead of annotations, offering better validation and type safety.

* [Cheatsheet](#cheatsheet)
* [ServicePolicySpec](#servicepolicyspec)
  * [LocalObjectReference](#localobjectreference)
  * [LabelSelector](#labelselector)
  * [LabelSelectorRequirement](#labelselectorrequirement)
  * [Service](#service)
* [ServicePolicyStatus](#servicepolicystatus)

## Cheatsheet

__NOTE__: Specification provided below is not valid configuration.

It's just demonstration of all `ServicePolicy` fields.

```yaml
apiVersion: gwin.yandex.cloud/v1
kind: ServicePolicy
metadata:
  name: example-service-policy
  namespace: example-ns
spec:
  # Target selection - policy applies to services matching these criteria
  targetRefs:
    - group: ""
      kind: Service
      name: my-service  # specific service by name
  selector:
    matchLabels:
      app: my-app  # services with these labels
    matchExpressions:
      - key: environment
        operator: In
        values: ["production", "staging"]
  
  # Service target configuration
  policy:
    targets:
      type: Node  # Node or Pod targets
      ipFamily: IPv4  # IP family for targets
      cidrs: ["10.0.0.0/8", "172.16.0.0/12"]  # address filtering
      albZoneMatch: true  # zone matching
      node:
        onlyWithPods: true  # only nodes with pods
        addressType: InternalIP  # address type
```

| Field | Description |
|-------|-------------|
| metadata | **ServicePolicyMeta** <br> Standard Kubernetes metadata |
| spec | **[ServicePolicySpec](#servicepolicyspec)** <br> ServicePolicy specification |
| status | **[ServicePolicyStatus](#servicepolicystatus)** <br> ServicePolicy status |

## ServicePolicySpec

*Appears in:* [ServicePolicy](#cheatsheet)

The policy is restricted to resources within the same namespace.

When determining which resources the policy applies to, the following rules are used:
- If both TargetRefs and Selector are specified, a resource must match both criteria to be affected by the policy.
- If neither TargetRefs nor Selector is specified, the policy applies to all resources within the same namespace.

| Field | Description |
|-------|-------------|
| targetRefs | **[[]LocalObjectReference](#localobjectreference)** <br> References to Service resources that this policy should apply to |
| selector | **[LabelSelector](#labelselector)** <br> Label selector for Service resources that this policy should apply to |
| policy | **[Service](#service)** <br> Service-specific configuration |

## LocalObjectReference

Reference to a local Kubernetes object.

*Appears in:* [ServicePolicySpec](#servicepolicyspec)

| Field | Description |
|-------|-------------|
| group | **string** <br> API group of the target resource <br> Example: `""` |
| kind | **string** <br> Kind of the target resource <br> Example: `Service` |
| name | **string** <br> Name of the target resource <br> Example: `my-service` |

## LabelSelector

Label selector for selecting resources by labels.

*Appears in:* [ServicePolicySpec](#servicepolicyspec)

| Field | Description |
|-------|-------------|
| matchLabels | **map[string]string** <br> Map of key-value pairs for exact label matching <br> Example: `app: my-service` |
| matchExpressions | **[[]LabelSelectorRequirement](#labelselectorrequirement)** <br> List of label selector requirements |

## LabelSelectorRequirement

Label selector requirement for advanced label matching.

*Appears in:* [LabelSelector](#labelselector)

| Field | Description |
|-------|-------------|
| key | **string** <br> Label key that the selector applies to <br> Example: `environment` |
| operator | **string** <br> Operator for the requirement. Options: `In`, `NotIn`, `Exists`, `DoesNotExist` <br> Example: `In` |
| values | **[]string** <br> Array of string values for `In` and `NotIn` operators <br> Example: `["production", "staging"]` |

## Service

Service policy configuration that applies to Service targets.

*Appears in:* [ServicePolicySpec](#servicepolicyspec)

| Field | Description |
|-------|-------------|
| targets | **[ServiceTargets](#servicetargets)** <br> Configures how ALB should select and address Service endpoints |

## ServiceTargets

*Appears in:* [Service](#service)

ServiceTargets defines how ALB targets are selected and addressed for a Service. It controls whether to use Node or Pod endpoints, network restrictions, and zone matching.

| Field | Description |
|-------|-------------|
| type | **string** <br> Specifies whether to use Node or Pod endpoints as ALB targets. `Node` uses cluster nodes as targets (default), `Pod` uses individual pods as targets <br> Example: `Node` |
| ipFamily | **string** <br> Specifies which IP family to use for target addresses. Currently only IPv4 is supported <br> Example: `IPv4` |
| cidrs | **[]string** <br> Helps select appropriate target addresses when targets have multiple IP addresses. Only addresses within these CIDR blocks will be used for ALB targets <br> Example: `["10.0.0.0/8", "172.16.0.0/12"]` |
| albZoneMatch | **boolean** <br> Controls whether to verify that targets are located in the same zones as the ALB. When true (default), only targets in ALB zones are included <br> Example: `true` |
| node | **[ServiceTargetsNode](#servicetargetsnode)** <br> Additional configuration when type is "Node". This field is ignored when type is "Pod" |

## ServiceTargetsNode

*Appears in:* [ServiceTargets](#servicetargets)

ServiceTargetsNode contains configuration specific to Node-type targets. This configuration is only used when ServiceTargets.Type is "Node".

| Field | Description |
|-------|-------------|
| onlyWithPods | **boolean** <br> Controls whether to include only nodes that have pods for this service. When true (default), only nodes running pods that match the service selector are used as targets <br> Example: `true` |
| addressType | **string** <br> Specifies which node address type to use for ALB targets. `InternalIP` uses node's internal IP address (default), `ExternalIP` uses node's external IP address <br> Example: `InternalIP` |

## ServicePolicyStatus

*Appears in:* [ServicePolicy](#cheatsheet)

| Field | Description |
|-------|-------------|
| conditions | **[]Condition** <br> List of conditions representing the current state of the ServicePolicy |
| attachedServices | **int32** <br> Number of currently attached services |
