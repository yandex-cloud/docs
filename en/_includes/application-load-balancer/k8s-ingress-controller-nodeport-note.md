{% note warning %}

{{ k8s }} backend services referenced in `Ingress` rules (directly or via `HttpBackendGroup`/`GrpcBackendGroup`), must be of type `NodePort`. For more on this type, see [this {{ k8s }} guide](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

{% endnote %}