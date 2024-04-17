# ObjectMeta

```yaml
name: <string>
annotations:
  ingress.alb.yc.io/protocol: <string>
  ingress.alb.yc.io/transport-security: <string>
```

#|
|| **Поле**      | **Значение или тип** | **Описание** ||
|| `name`        | `string`             | **Обязательное**.

[Имя ресурса](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

Не является именем балансировщика в {{ alb-name }}. ||
|| `annotations` | `map[string]string`  | **Обязательное**.

Аннотации ресурса. ||
|#
