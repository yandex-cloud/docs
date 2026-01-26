# GatewayPolicy resource fields

The `GatewayPolicy` resource specifies cloud policies applied to `Gateway` resources within a single {{ k8s }} namespace. You can apply a policy to specific resources with the help of references (`targetRefs`) or a selector (`selector`). If neither of these fields is set, the policy applies to all the resources within the namespace.

`GatewayPolicy` is a Gateway API extension implemented in {{ alb-name }}. Below, we describe its fields and annotations used by the {{ alb-name }} Gateway API.

{% note info %}

You can also set up your policies using `Gateway` resource annotations. The `GatewayPolicy` resource parameters and `Gateway` annotations are equivalent.

{% endnote %}

Here is an example of the `GatewayPolicy` resource definition we provide only to demonstrate all the parameters:

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: GatewayPolicy
metadata:
  name: my-gateway-policy
spec:
  targetRefs:
    - name: some-gateway
      kind: Gateway
      group: gateway.networking.k8s.io
  
  selector:
    matchLabels:
      app: my-app

  policy:
    subnets: ["subnet-id-1", "subnet-id-2"]
    securityGroups: ["sg-id-1", "sg-id-2"]

    logs:
      logGroupID: "some-log-group-id"
      disable: false                 
      discardRule:
        http-errors:                 
          httpCodes: [404, 500]  
          httpCodeIntervals: ["4XX", "5XX"]
          discardPercent: 100   

    autoScale:
      minZoneSize: 2
      maxSize: 10 

    zone:
      ru-central1-a:  
        receiveTraffic: true
```

## GatewayPolicy {#gatewaypolicy}

```yaml
apiVersion: gateway.alb.yc.io/v1
kind: GatewayPolicy
metadata:
  name: <string>
  namespace: <string>
spec:
  targetRefs:
    - name: <string>
      kind: <string>
      group: <string>
  selector:
    matchLabels:
      <string>: <string>
    matchExpressions:
      - key: <string>
        operator: <string>
        values:
          - <string>
  policy:
    subnets: [...]
    securityGroups: [...]
    logs: ...
    autoScale: ...
    zone: ...
status:
  conditions: [...]
  attachedGateways: <integer>
```

Where:

* `apiVersion`: `gateway.alb.yc.io/v1`
* `kind`: `GatewayPolicy`
* `metadata` (`ObjectMeta`; this is a required field)

  Resource metadata.

  * `name` (`string`; this is a required field)
  
    Resource name. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

  * `namespace` (`string`)
  
    [Namespace](../../../managed-kubernetes/concepts/index.md#namespace) the resource belongs to. The default value is `default`.

* `spec` (`GatewayPolicySpec`; this is a required field)

  Policy specification.

  * `targetRefs` (`[]LocalObjectReference`)

    List of references to resources targeted by the policy. If specified, the policy applies only to these resources.

  * `selector` (`LabelSelector`)

    Selector for selecting resources by label. If specified, the policy applies only to selected resources.

  * `policy` (`Gateway`)

    Cloud configuration applied to selected resources. For more information, see [below](#gatewaypolicy-gateway).

* `status` (`GatewayPolicyStatus`)

  Current status of the policy.

  * `conditions`: Array of status conditions. For more information about the format, see [this {{ k8s }} guide](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.31/#condition-v1-meta).

  * `attachedGateways`: Number of attached `Gateway` resources.

## Gateway {#gatewaypolicy-gateway}

Resource defining the load balancer's cloud parameters that can be set using a policy.

```yaml
subnets: [<string>, ...]
securityGroups: [<string>, ...]
logs:
  logGroupID: <string>
  disable: <bool>
  discardRule:
    <rule_name>:
      httpCodes: [<int>, ...]
      httpCodeIntervals: [<string>, ...]
      grpcCodes: [<string>, ...]
      discardPercent: <int>
autoScale:
  minZoneSize: <int>
  maxSize: <int>
zone:
  <availability_zone>:
    receiveTraffic: <bool>
```

Where:

* `subnets` (`[]string`)

  List of {{ vpc-name }} [subnets](../../../vpc/concepts/network.md#subnet) in the load balancer's [availability zones](../../../overview/concepts/geo-scope.md). This is a comma separated list of subnet IDs.

* `securityGroups` (`[]string`)

  List of {{ vpc-name }} [security groups](../../../vpc/concepts/security-groups.md) for a load balancer. This is a comma separated list of group IDs.

  For the proper load balancer and Gateway API operation, make sure to configure security groups as specified in [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* `logs` (`LogOptions`)

  Load balancer logging parameters.

  * `logGroupID` (`string`)
  
    ID of the [log group](../../../logging/concepts/log-group.md) to write [load balancer](../../../application-load-balancer/logs-ref.md) logs to in {{ cloud-logging-full-name }}.

  * `disable` (`bool`)
  
    Disables logging.

  * `discardRule` (`map[string]string`)

    Log discard rules.

    * `httpCodes` (`[]int`)

      HTTP codes to discard.

    * `httpCodeIntervals` (`[]string`)

      HTTP code groups to discard, e.g., `4xx`.

    * `grpcCodes` (`[]string`)

      gRPC codes to discard.

    * `discardPercent` (`int`)
    
      Percentage of logs to discard (`0` to retain all, `100` to discard all).

* `autoScale` (`AutoScalePolicy`)

  Load balancer scaling parameters.

  * `minZoneSize` (`int`)
  
    Minimum number of [resource units](../../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling) per availability zone. The default minimum is 2. You cannot set a limit lower than two resource units per zone.

  * `maxSize` (`int`)
  
    Maximum total number of resource units.

* `zone` (`map[string]string`)

  Parameters for specific availability zones.

  * `receiveTraffic` (`bool`)
  
    If `true`, traffic to the load balancer nodes in this zone is disabled.
