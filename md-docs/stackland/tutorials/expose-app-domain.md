# Настройка внешнего доступа к поду в кластере

{{ stackland-name }} позволяет пользователям запускать собственные приложения в кластере и создавать внешний доступ к ним. В этом руководстве мы разберем пример создания внешнего доступа к HTML-странице в кластере.

## Перед началом работы {#before-begin}

1. Если проект еще не создан, создайте его: `kubectl create namespace <название проекта>`.
1. Выберите ссылку для внешнего доступа. Например, `test.{{ cluster-domain }}`.

    При необходимости получить домен кластера можно с помощью команды `kubectl get platformenvironments main -o jsonpath='{.status.clusterDomain}'`.

## Как создать внешний доступ {#how-to}

### Шаг 1. Создайте Ingress {#create-ingress}

1. Создайте файл ресурса `Ingress`. Например, с помощью команды `touch ingress.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      annotations:
        cert-manager.io/cluster-issuer: stackland-default
      name: test-stackland-ingress
      namespace: <название проекта>
    spec:
      ingressClassName: stackland-default
      rules:
      - host: <внешняя ссылка>
        http:
          paths:
          - backend:
              service:
                name: test-stackland-service
                port:
                  number: 5556
            path: /
            pathType: Prefix
      tls:
      - hosts:
        - <внешняя ссылка>
        secretName: test-stackland-tls
    ```

1. Подставьте в параметр:

    * `metadata.namespace` — название проекта.
    * `spec.rules[0].host` — ссылку для внешнего доступа.
    * `spec.tls[0].hosts[0]` — ссылку для внешнего доступа.

1. Примените манифест: `kubectl apply -f ingress.yaml`.

### Шаг 2. Создайте HTML-страницу {#create-HTML}

1. Создайте файл ресурса `ConfigMap`. Например, с помощью команды `touch configmap.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    ```yaml
    apiVersion: v1
    data:
      index.html: "<!DOCTYPE html>\n<html>\n<head>\n    <title>Тест Stackland</title>\n    <meta charSet=\"UTF-8\"/>\n</head>\n<body>\n    <h1>Тест внешнего доступа к Stackland</h1>\n    <p>Эта страница используется для тестирования внешнего доступа к сервису Stackland</p>\n</body>\n</html>\n"
    kind: ConfigMap
    metadata:
      name: test-stackland-html
      namespace: <название проекта>
    ```

1. Подставьте в параметр `metadata.namespace` название проекта.
1. Примените манифест: `kubectl apply -f configmap.yaml`.

### Шаг 3. Создайте Deployment для HTML-страницы {#create-deployment}

1. Создайте файл ресурса `Deployment`. Например, с помощью команды `touch deployment.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: test-stackland
      namespace: <название проекта>
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: test-stackland-service
      template:
        metadata:
          labels:
            app: test-stackland-service
        spec:
          containers:
          - image: nginx:alpine
            name: nginx
            ports:
            - containerPort: 80
            volumeMounts:
            - mountPath: /usr/share/nginx/html
              name: html
          volumes:
          - configMap:
              name: test-stackland-html
            name: html
    ```

1. Подставьте в параметр `metadata.namespace` название проекта.
1. Примените манифест: `kubectl apply -f deployment.yaml`.

### Шаг 4. Создайте Service для HTML-страницы {#create-service}

1. Создайте файл ресурса `Service`. Например, с помощью команды `touch service.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: test-stackland-service
      namespace: <название проекта>
    spec:
      ports:
      - port: 5556
        targetPort: 80
      selector:
        app: test-stackland-service
    ```

1. Подставьте в параметр `metadata.namespace` название проекта.
1. Примените манифест: `kubectl apply -f service.yaml`.

### Шаг 5. Проверьте работу доступа {#check-access}

Откройте в браузере выбранную ссылку для внешнего доступа. Вы должны увидеть тестовую HTML-страницу.