# Service

```yaml
apiVersion: v1
kind: Service
metadata: <ObjectMeta>
spec: <ServiceSpec>
```

#|
|| **Поле**     | **Значение или тип**   | **Описание**           ||
|| `apiVersion` | `v1` |                   **Обязательное**.

Версия API Kubernetes. ||
|| `kind`       | `Service`              | Тип ресурса.           ||
|| `metadata`   | `ObjectMeta`           | **Обязательное**.

Метаданные ресурса. ||
|| `spec`       | `ServiceSpec`          | **Обязательное**.

Спецификация ресурса. ||
|#

{% cut "Пример" %}

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
