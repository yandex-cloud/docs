# ServiceSpec

```yaml
type: NodePort
ports:
  - <ServicePort>
  -
```

#|
|| **Field** | **Value / Type** | **Description** ||
|| `type`    | `NodePort`        | **This is a required field**.

Service type.

{% include [k8s-ingress-controller-nodeport-note](../../application-load-balancer/k8s-ingress-controller-nodeport-note.md) %} ||
|| `ports`   | `[]ServicePort`   | **This is a required field**.

List of ports the service is available on. ||
|#
