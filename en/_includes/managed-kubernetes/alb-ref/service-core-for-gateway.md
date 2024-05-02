# Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: <string>
spec: <ServiceSpec>
```

#|
|| **Field**       | **Value or type**      | **Description**          ||
|| `apiVersion`    | `v1`                   | **Required**.

Kubernetes API version. ||
|| `kind`          | `Service`              | Resource type.          ||
|| `metadata`      | `ObjectMeta`           | **Required**.

Resource metadata. ||
|| `metadata.name` | `string`               | **Required**.

[Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).

This name is not the balancer name in {{ alb-name }}. ||
|| `spec`          | `ServiceSpec`          | **Required**.

Resource specification. ||
|#

{% cut "Example" %}

```yaml
apiVersion: v1
kind: Service
metadata:
  name: alb-demo-1
spec:
  selector:
    app: alb-demo-1
  type: NodePort
  ports:
    - name: http
      port: 80
      protocol: TCP
      nodePort: 30081
```

{% endcut %}
