# ServiceSpec

```yaml
type: NodePort
ports:
  - <ServicePort>
  -
```

#|
|| **Поле** | **Значение или тип** | **Описание** ||
|| `type`   | `NodePort` | **Обязательное**.

Тип сервиса.

{% include [k8s-ingress-controller-nodeport-note](../../application-load-balancer/k8s-ingress-controller-nodeport-note.md) %} ||
|| `ports`    | `[]ServicePort`      | **Обязательное**.

Список портов, на которых доступен сервис. ||
|#
