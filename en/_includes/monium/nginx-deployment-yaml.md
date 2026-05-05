```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-server
  namespace: nginx-demo
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:stable
          ports:
            - name: http
              containerPort: 80
          volumeMounts:
            - name: nginx-config
              mountPath: /etc/nginx/conf.d/default.conf
              subPath: nginx.conf
            - name: nginx-config
              mountPath: /usr/share/nginx/html/index.html
              subPath: index.html
        - name: nginx-exporter
          image: nginx/nginx-prometheus-exporter:0.10.0
          args:
            - -nginx.scrape-uri=http://localhost/nginx_status
          ports:
            - name: metrics
              containerPort: 9113
          resources:
            limits:
              memory: 128Mi
              cpu: 500m
      volumes:
        - name: nginx-config
          configMap:
            name: nginx-config
```