# Gateway resource fields

The `Gateway` resource defines rules for accepting and routing incoming traffic. [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md) and [TLSRoute](../../../application-load-balancer/k8s-ref/tls-route.md) resources specify traffic routes. [{{ alb-name }} Gateway API](../../../application-load-balancer/tools/k8s-gateway-api/index.md) uses these rules to create:

* [Load balancer](../../../application-load-balancer/concepts/application-load-balancer.md) and its listeners.
* [Backend groups](../../../application-load-balancer/concepts/backend-group.md).
* [HTTP routers](../../../application-load-balancer/concepts/http-router.md). They are only created if [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md) resources are used.

The `Gateway` resource is designed for cluster operators. Application developers should use `TLSRoute` or `HTTPRoute` resources.

`Gateway` is a [{{ k8s }} Gateway API project](https://gateway-api.sigs.k8s.io/) resource. Below, we describe its fields and annotations used by {{ alb-name }} Gateway API. For configuration details, see the [{{ k8s }} Gateway API reference](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.Gateway).

## Gateway {#gateway}

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: <string>
  namespace: <string>
  annotations:
    gateway.alb.yc.io/security-groups: <string>
spec: <GatewaySpec>
```

Where:

* `apiVersion`: `gateway.networking.k8s.io/v1`
* `kind`: `Gateway`
* `metadata`: `ObjectMeta`. This is a required field.
  
  Resource metadata.

  * `name` (`string`, required):

    Resource name. For more information about the group name format, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

    Do not mistake this name for the {{ alb-name }} load balancer name.
  
  * `namespace` (`string`)
  
    Resource [namespace](../../../managed-kubernetes/concepts/index.md#namespace). The default value is `default`.
   
  * `annotations` (`map[string]string`, required)
    
    Resource annotations.

    * `gateway.alb.yc.io/security-groups` (`string`, required)

      Load balancer {{ vpc-name }} [security groups](../../../vpc/concepts/security-groups.md). This is a comma separated list of group IDs, e.g.:
    
      ```
      gateway.alb.yc.io/security-groups: b0c2kotoidcoh6haf8cu,e2lnhhdj9a0aqmr78d36,e9bud5itjnl8mkjj7td1
      ```
    
      For the proper load balancer and Gateway API operation, make sure to configure security groups as specified in [{#T}](../../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md).

* `spec` (`GatewaySpec`, required)

  Resource specification. For more information, see [below](#spec).


## GatewaySpec {#spec}

```yaml
gatewayClassName: yc-df-class
listeners:
  - name: <string>
    hostname: <string>
    port: <int32>
    protocol: <string>
    tls:
      mode: <string>
      certificateRefs:
        - group: <string>
          kind: <string>
          name: <string>
          namespace: <string>
        - ...
    allowedRoutes:
      namespaces:
        from: <string>
        selector:
          matchExpressions:
            - key: <string>
              operator: <string>
              values:
                - <string>
                - ...
          matchLabels:
            <string>: <string>
            ...
  - ...
addresses:
  - type: IPAddress
    value: <string>
  - ...
```

Where:

* `gatewayClassName`: `yc-df-class`
* `listeners` (`[]Listener`)

  Load balancer listeners.

  * `name` (`string`)
    
    Listener internal name.
    
    This name is only used by {{ k8s }}. Do not mistake it for the {{ alb-name }} listener name.
  
    The internal name should be in domain format, i.e., match the following regular expression: 
    
    ```[a-z0-9]([-a-z0-9]*[a-z0-9])?(\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*```
  
    For example, `example`, `example.com`, and `foo.example.com` are valid internal names, while `example.com/bar` and `-example.` are not.
    
    The name can be up to 63 characters long.
    
  * `hostname` (`string`)

    Listener domain name.

    {% include [k8s-ingress-controller-hostnames-wildcard](../../application-load-balancer/k8s-ingress-controller-hostnames-wildcard.md) %}
  
    The listener will only process routes, i.e., [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md) and [TLSRoute](../../../application-load-balancer/k8s-ref/tls-route.md) resources, with domain names, i.e `spec.hostnames` fields, matching the value specified in this setting.

  * `port` (`int32`)
    
    Listener incoming traffic port.
    
  * `protocol` (`string`)
    
    Listener incoming traffic protocol: `HTTP`, `HTTPS` or `TLS`.

  * `tls` (`GatewayTlsConfig`)

    TLS settings for incoming HTTPS and TLS traffic.
  
    * `mode` (`string`)
      
      TLS connections termination mode.
      
      You can only use the default `Terminate` setting, where incoming traffic is decrypted using certificates from `certificateRefs` and then routed to backends. `Passthrough` mode without connection termination is not supported.

    * `certificateRefs` (`[]SecretObjectReference`)
  
      {{ k8s }} resources containing TLS certificates.

      You can only use this setting if `protocol` is specified as `HTTPS` or `TLS`. The list must contain at least one certificate.

      The load balancer will only use the first certificate from the list while ignoring the others.
  
      You can add a certificate to a cluster as a secret, i.e., `Secret` resource, in the {{ managed-k8s-name }} management console or using the `kubectl` command line tool:
  
      ```
      kubectl create secret tls <secret_name> \
        -n <namespace_name> \
        --cert <certificate_file_path> \
        --key <path_to_file_with_certificate_private_key>
      ```
  
      * `group` (`string`)
        
        Name of the {{ k8s }} API group associated with the certificate resource, e.g., `networking.k8s.io`. 
        
        The default value is empty, indicating the root API group.

      * `kind` (`string`)
        
        Type of the {{ k8s }} certificate storage resource.
  
        The default value is `Secret`.

      * `name` (`string`)
        
        Name of the {{ k8s }} certificate storage resource.

      * `namespace` (`string`)
  
        Certificate resource namespace.

  * `allowedRoutes` (`AllowedRoutes`)

    Rules for selection of listener routes, i.e., [HTTPRoute](../../../application-load-balancer/k8s-ref/http-route.md) and [TLSRoute](../../../application-load-balancer/k8s-ref/tls-route.md) resources. To ensure route selection, these resources must have `Gateway` specified in their `spec.parentRefs` fields.

    The system will use these routes to create [backend groups](../../../application-load-balancer/concepts/backend-group.md) you can link to the listener. The system will automatically create [HTTP routers](../../../application-load-balancer/concepts/http-router.md) for `HTTPRoute` resources.

    * `namespaces` (`RouteNamespaces`)
  
      Namespace selection rule for `HTTPRoute` and `TLSRoute` listener resources.
  
      * `from` (`string`)
        
        Rule type:
  
        * `All`: All namespaces are available for resource selection.
        * `Same`: Only the `Gateway` resource namespace specified in the `metadata.namespace` field is available for selection.
        * `Selector`: Only namespaces meeting criteria specified in the `selector` field are available for selection.

      * `selector` (`LabelSelector`)
  
        Namespace selection requirements. To be selected, a namespace must meet all criteria specified in `matchExpressions` and `matchLabels` fields.
  
        To learn more, see the [{{ k8s }} API reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.23/#labelselector-v1-meta).
  
        If you specify a value other than `Selector` in the `from` field, the `selector` field will be ignored. 

* `addresses` (`[]GatewayAddress`)

  Load balancer public IP settings.

  If you skip this field, the system will automatically assign one public IP address to the load balancer. 

  * `type`: `IPAddress`
  * `value` (`string`)

    {{ vpc-full-name }} Load balancer public IP address.
  
    To use a public IP address, first, you need to reserve it by following [this guide](../../../vpc/operations/get-static-ip.md).
