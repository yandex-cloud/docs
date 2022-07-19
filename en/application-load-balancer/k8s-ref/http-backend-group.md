# HttpBackendGroup resource fields

The `HttpBackendGroup` resource enables you to combine backends that are {{ k8s }} services and that traffic is distributed to, into a group. The [{{ alb-name }} Ingress controller](../tools/k8s-ingress-controller/index.md) uses these resources to create [backend groups](../concepts/backend-group.md).

You must add a reference to `HttpBackendGroup` to the [`Ingress` resource](ingress.md).

{% include [k8s-ingress-controller-backend-group-features](../../_includes/application-load-balancer/k8s-ingress-controller-backend-group-features.md) %}

`HttpBackendGroup` is a [custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) from the API `alb.yc.io`, group provided by the Ingress controller.

## HttpBackendGroup {#http-backend-group}

```yaml
apiVersion: alb.yc.io/v1alpha1
kind: HttpBackendGroup
metadata:
  name: <string>
spec:
  backends:
    - name: <string>
      weight: <int64>
      useHttp2: <bool>
      service:
         name: <int64>
         port:
           name: <string>
           number: <int32>
      storageBucket:
        name: <string>
      tls:
        sni: <string>
        trustedCa: <string>
    - ...
```

Where:

* `apiVersion`: `alb.yc.io/v1alpha1`
* `kind`: `HttpBackendGroup`
* `metadata` (`ObjectMeta`, required)

   Resource metadata.

   * `name` (`string`, required)

      Resource name. For more information about format, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

      You must specify this name in the `spec.rules.http.paths.backend.resource.name` field of the `Ingress` resource (see [reference](ingress.md)).

      Does not match the backend group name in {{ alb-name }}.

* `spec` (`HttpBackendGroupSpec`)

   Resource specification.

   * `backends` (`[]HttpBackend`)

      List of backends included in a group.

      * `name` (`string`, required)

         Backend name.

      * `weight` (`int64`)

         Relative backend weight. Traffic is distributed to backends in a group as a function of backend weights.

         Weights must be specified either for all backends in a group, or for none. If weights are not specified, traffic is distributed to the backends as if they had identical positive weights.

         If a non-positive weight is specified, a backend will not receive traffic.

      * `useHttp2` (`bool`)

         Enables HTTP/2 connections between load balancer nodes and backend endpoints.

         The default value is `false` causing HTTP/1.1 connections to be made.

      * `service` (`ServiceBackend`)

         Reference to the [{{ k8s }} service](../../managed-kubernetes/concepts/index.md#service) expected to be the backend to process the requests.

         The `Service` resource this field points to must be described as in the [specification](service.md).

         A backend must either have a service or a {{ objstorage-name }} bucket specified (`storageBucket`) but not both.

         {% include [k8s-ingress-controller-service-backend](../../_includes/application-load-balancer/k8s-ingress-controller-service-backend.md) %}

      * `storageBucket` (`StorageBucketBackend`)

         Reference to a [{{ objstorage-full-name }} bucket](../../storage/concepts/bucket.md) expected to process requests as a backend. For more detail on using a bucket as a backend, please review [{#T}](../concepts/backend-group.md#types).

         {% include [bucket-availability-note](../_includes_service/bucket-availability-note.md) %}

         Either a bucket or a {{ k8s }} service (`service`) must be specified for a backend but not both.

         * `name` (`string`, required)

            Bucket name.

      * `tls` (`BackendTLS`)

         TLC connection settings for load balancer nodes and backend endpoints.

         If the field is specified, the load balancer established TLS connections with the backend and compares the certificates received to the certificate specified in the `trustedCa` field. If the field is not specified, the load balancer will make unencrypted connections to the backend.

         * `sni` (`string`)

            Domain name specified as the value for the Server Name Indication (SNI) TLS extension.

         * `trustedCa` (`string`)

            Contents of the X.509 certificate issued by a certificate authority in PEM format.

