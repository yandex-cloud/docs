# ObjectMeta

```yaml
name: <string>
annotations:
  ingress.alb.yc.io/protocol: <string>
  ingress.alb.yc.io/transport-security: <string>
  ingress.alb.yc.io/health-checks: <string>
```

#|
|| **Field**     | **Value / Type**    | **Description** ||
|| `name`        | `string`             | **This is a required field**.

[Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

This name is not the balancer name in {{ alb-name }}. ||
|| `annotations` | `map[string]string`  | **This is a required field**.

Resource annotations. ||
|#
