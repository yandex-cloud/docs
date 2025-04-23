# Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: <string>
spec: <ServiceSpec>
```

#|
|| **Field**        | **Value / Type**   | **Description**          ||
|| `apiVersion`    | `v1`                   | **This is a required field**.

Kubernetes API version. ||
|| `kind`          | `Service`              | Resource type          ||
|| `metadata`      | `ObjectMeta`           | **This is a required field**.

Resource metadata ||
|| `metadata.name` | `string`               | **This is a required field**.

[Resource name](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names)

Do not mistake it for the {{ alb-name }} load balancer name. ||
|| `spec`          | `ServiceSpec`          | **This is a required field**.

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
