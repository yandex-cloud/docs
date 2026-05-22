```yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: monium-secrets
  namespace: nginx-demo
stringData:
  MONIUM_API_KEY: '<API_ключ>'
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: otel-collector-conf
  namespace: nginx-demo
  labels:
    app: opentelemetry
    component: otel-collector-conf
data:
  otel-collector-config: |
    receivers:
      prometheus:
        config:
          scrape_configs:
            - job_name: "nginx"
              scrape_interval: 15s
              kubernetes_sd_configs:
                - role: pod
                  namespaces:
                    names:
                      - nginx-demo

              relabel_configs:
                - source_labels: [__meta_kubernetes_namespace]
                  action: keep
                  regex: nginx-demo

                - source_labels: [__meta_kubernetes_pod_label_app]
                  action: keep
                  regex: nginx

                - source_labels: [__meta_kubernetes_pod_container_port_name]
                  action: keep
                  regex: metrics

                - source_labels: [__meta_kubernetes_pod_name]
                  target_label: pod

                - source_labels: [__meta_kubernetes_namespace]
                  target_label: namespace
      filelog:
        include:
          - /var/log/pods/nginx-demo_nginx-server-*/nginx/*.log
        operators:
          - type: container
            id: container-parser

    processors:
      batch:
        timeout: 5s
        send_batch_size: 1024
      memory_limiter:
        limit_mib: 1500
        spike_limit_mib: 512
        check_interval: 5s
      resource:
        attributes:
          - key: service.name
            value: nginx
            action: upsert
          - key: service.namespace
            value: nginx-demo
            action: upsert

    exporters:
      otlp/monium:
        compression: none
        endpoint: ingest.monium.yandex.cloud:443
        headers:
          Authorization: Api-Key ${env:MONIUM_API_KEY}
          x-monium-project: folder__<идентификатор_каталога>
      debug:
        verbosity: basic

    extensions:
      zpages: {}

    service:
      extensions: [zpages]
      pipelines:
        metrics:
          receivers: [prometheus]
          processors: [memory_limiter, resource, batch]
          exporters: [otlp/monium, debug]
        logs:
          receivers: [filelog]
          processors: [memory_limiter, resource, batch]
          exporters: [otlp/monium, debug]
---
apiVersion: v1
kind: Service
metadata:
  name: otel-collector
  namespace: nginx-demo
  labels:
    app: opentelemetry
    component: otel-collector
spec:
  ports:
    - name: otlp-grpc
      port: 4317
      protocol: TCP
      targetPort: 4317
    - name: otlp-http
      port: 4318
      protocol: TCP
      targetPort: 4318
    - name: metrics
      port: 8888
  selector:
    component: otel-collector
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: otel-collector
  namespace: nginx-demo
  labels:
    app: opentelemetry
    component: otel-collector
spec:
  selector:
    matchLabels:
      app: opentelemetry
      component: otel-collector
  template:
    metadata:
      labels:
        app: opentelemetry
        component: otel-collector
    spec:
      serviceAccountName: otel-collector
      containers:
        - command:
            - "/otelcol-contrib"
            - "--config=/conf/otel-collector-config.yaml"
          image: otel/opentelemetry-collector-contrib:latest
          name: otel-collector
          resources:
            limits:
              cpu: 1
              memory: 2Gi
            requests:
              cpu: 200m
              memory: 400Mi
          ports:
            - containerPort: 55679
            - containerPort: 4317
            - containerPort: 4318
            - containerPort: 8888
          env:
            - name: MY_POD_IP
              valueFrom:
                fieldRef:
                  apiVersion: v1
                  fieldPath: status.podIP
            - name: GOMEMLIMIT
              value: 1600MiB
            - name: MONIUM_API_KEY
              valueFrom:
                secretKeyRef:
                  name: monium-secrets
                  key: MONIUM_API_KEY
          volumeMounts:
            - name: otel-collector-config-vol
              mountPath: /conf
            - name: varlogpods
              mountPath: /var/log/pods
              readOnly: true
      volumes:
        - name: otel-collector-config-vol
          configMap:
            name: otel-collector-conf
            items:
              - key: otel-collector-config
                path: otel-collector-config.yaml
        - name: varlogpods
          hostPath:
            path: /var/log/pods
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: otel-collector
  namespace: nginx-demo
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: otel-collector-discovery
  namespace: nginx-demo
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: otel-collector-discovery
  namespace: nginx-demo
subjects:
  - kind: ServiceAccount
    name: otel-collector
    namespace: nginx-demo
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: otel-collector-discovery
```