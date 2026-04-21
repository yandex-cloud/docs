# Service

Service represents a Kubernetes service that acts as a backend for Gwin resources. Services are used as backend targets in [HTTPRoute](./httproute.md), [GRPCRoute](./grpcroute.md), [TLSRoute](./tlsroute.md), and [Ingress](./ingress.md) resources to distribute incoming traffic within a Kubernetes cluster.

Service is a standard [Kubernetes](https://kubernetes.io/docs/concepts/services-networking/service/) resource. Below, we describe its fields and annotations used by Gwin. For configuration details, see the [upstream documentation](https://kubernetes.io/docs/reference/kubernetes-api/service-resources/service-v1/).

For an alternative approach using CRD instead of annotations, see [ServicePolicy](./servicepolicy.md).

* [Cheatsheet](#cheatsheet)
* [ServiceMeta](#servicemeta)
  * [Annotations cheatsheet](#annotations-cheatsheet)
  * [Annotations reference](#annotations-reference)
* [ServiceSpec](#servicespec)
  * [ServicePort](#serviceport)

## Cheatsheet

__NOTE__: Specification provided below is not valid configuration.

It's just demonstration of all `Service` fields.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: example-service
  namespace: example-ns
  annotations: ... # see annotations example below
spec:
  type: NodePort  # service type for Gwin backends
  selector:
    app: example-app  # pod selector
  ports:
    - name: http  # port name
      protocol: TCP  # protocol
      port: 80  # service port
      targetPort: 8080  # container port
      nodePort: 30080  # node port
    - name: https
      protocol: TCP
      port: 443
      targetPort: 8443
      nodePort: 30443
```

| Field | Description |
|-------|-------------|
| metadata | **[ServiceMeta](#servicemeta)** <br> Name, namespace and annotations. |
| spec | **[ServiceSpec](#servicespec)** <br> Service specification. |

## ServiceMeta

*Appears in:* [Service](#cheatsheet)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the Service. |
| namespace | **string** <br> Namespace of the Service. |
| annotations | **map[string]string** <br> Annotations of the Service. |

### Annotations cheatsheet

__NOTE__: Specification provided below is not valid configuration.

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    # Target configuration
    gwin.yandex.cloud/targets.type: "Node"  # Node or Pod targets
    gwin.yandex.cloud/targets.ipFamily: "IPv4"  # IP family for targets
    gwin.yandex.cloud/targets.cidrs: "10.0.0.0/8,172.16.0.0/12"  # Address filtering
    gwin.yandex.cloud/targets.albZoneMatch: "true"  # Zone matching
    
    # Node-specific configuration (when targets.type is "Node")
    gwin.yandex.cloud/targets.node.onlyWithPods: "true"  # Only nodes with pods
    gwin.yandex.cloud/targets.node.addressType: "InternalIP"  # Address type
    
    # Attach to existing ALB infrastructure
    gwin.yandex.cloud/attach.targetGroup.id: "target-group-id-1"  # Existing target group ID
    gwin.yandex.cloud/attach.targetGroup.dontUpdatePaths: "name,description"  # Fields not to update
    gwin.yandex.cloud/attach.gatewayClass: "yandex-cloud-gateway"  # Gateway class filter

    # ALB resource naming
    gwin.yandex.cloud/albTargetGroupName: "my-target-group"  # custom target group name
```

### Annotations reference

#### Target Configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/targets.type` <br> _(string)_ <br> Specifies whether to use Node or Pod endpoints as ALB targets. Node uses cluster nodes as targets (default), Pod uses individual pods as targets. <br> Example: `Node` |
| `gwin.yandex.cloud/targets.ipFamily` <br> _(string)_ <br> Specifies which IP family to use for target addresses. Currently only IPv4 is supported. <br> Example: `IPv4` |
| `gwin.yandex.cloud/targets.cidrs` <br> _(string list)_ <br> Helps select appropriate target addresses when targets have multiple IP addresses. Only addresses within these CIDR blocks will be used for ALB targets. <br> Example: `10.0.0.0/8,172.16.0.0/12` |
| `gwin.yandex.cloud/targets.albZoneMatch` <br> _(boolean)_ <br> Controls whether to verify that targets are located in the same zones as the ALB. When true (default), only targets in ALB zones are included. <br> Example: `true` |

#### Node Target Configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/targets.node.onlyWithPods` <br> _(boolean)_ <br> Controls whether to include only nodes that have pods for this service. When true (default), only nodes running pods that match the service selector are used as targets. <br> Example: `true` |
| `gwin.yandex.cloud/targets.node.addressType` <br> _(string)_ <br> Specifies which node address type to use for ALB targets. InternalIP uses node's internal IP address (default), ExternalIP uses node's external IP address. <br> Example: `InternalIP` |

#### Attach Configuration

| Annotation and description |
|------------|
| `gwin.yandex.cloud/attach.targetGroup.id` <br> _(string)_ <br> Cloud target group ID that should be managed by this service. The controller will attach to this existing target group instead of creating a new one. <br> Example: `target-group-id-1` |
| `gwin.yandex.cloud/attach.targetGroup.dontUpdatePaths` <br> _(string list)_ <br> Specifies which fields should NOT be updated by the controller. Default is "name" - the controller doesn't touch the group name. <br> Example: `name,description`, `none` |
| `gwin.yandex.cloud/attach.gatewayClass` <br> _(string)_ <br> Specifies the gateway class that should manage this service. If specified and the corresponding gatewayClass is not managed by the controller, the service is ignored. This is useful for advanced scenarios where multiple controllers might be present. <br> Example: `yandex-cloud-gateway` |

#### ALB resource naming

| Annotation and description |
|------------|
| `gwin.yandex.cloud/albTargetGroupName` <br> _(string)_ <br> Custom name for the ALB target group created for this service. By default, the controller generates the name automatically. <br> Example: `my-target-group` |

## ServiceSpec

*Appears in:* [Service](#cheatsheet)

| Field | Description |
|-------|-------------|
| type | **string** <br> Type of service. For Gwin backends, must be `NodePort`. |
| selector | **map[string]string** <br> Label selector for pods that this service routes to. |
| ports | **[[]ServicePort](#serviceport)** <br> List of ports exposed by this service. |

## ServicePort

*Appears in:* [ServiceSpec](#servicespec)

| Field | Description |
|-------|-------------|
| name | **string** <br> Name of the port. Must be unique within the service. |
| protocol | **string** <br> Protocol for this port. Must be `TCP`, `UDP`, or `SCTP`. Defaults to `TCP`. |
| port | **int32** <br> Port number exposed by the service. |
| targetPort | **int32 or string** <br> Port number or name on the pod that traffic should be directed to. |
| nodePort | **int32** <br> Port on each node on which this service is exposed when type is `NodePort`. If not specified, a port will be allocated automatically. |
