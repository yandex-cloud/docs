{% note warning %}

{{ k8s }} backend services referenced in `Ingress` rules (directly or via `HttpBackendGroup`/`GrpcBackendGroup`), must be of type `NodePort`. For more information about this type, see the relevant [{{ k8s }} article](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport).

{% endnote %}