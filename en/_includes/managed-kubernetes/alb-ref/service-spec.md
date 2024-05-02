# ServiceSpec

```yaml
type: NodePort
ports:
  - <ServicePort>
  -
```

#|
|| **Field** | **Value or type** | **Description** ||
|| `type`    | `NodePort`        | **Required**.

Service type.

{% include [k8s-ingress-controller-nodeport-note](../../application-load-balancer/k8s-ingress-controller-nodeport-note.md) %} ||
|| `ports`   | `[]ServicePort`   | **Required**.

List of ports where the service is available. ||
|#
