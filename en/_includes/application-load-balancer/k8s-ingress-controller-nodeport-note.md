{% note warning %}

The {{ k8s }} services used as backends (as specified in the `Ingress` rules directly or in `HttpBackendGroup`/`GrpcBackendGroup`), must be of the `NodePort` type. For more details on this type, please see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

{% endnote %}