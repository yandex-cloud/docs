# Инъекция секретов через ConfigMap (ConfigMap mode)

В этом руководстве описано, как настроить подстановку секретов из Secrets Store в файлы конфигурации с помощью ConfigMap mode Secrets Injector.

В ConfigMap mode инжектор работает как init-контейнер. Он обрабатывает ConfigMap пода, заменяет ссылки на секреты реальными значениями и записывает результирующие файлы в директорию `/secrets`. Основной контейнер читает уже заполненные конфигурационные файлы оттуда.

## Перед началом {#before-you-begin}

1. Убедитесь, что компонент Secrets Store [установлен и активен](../../concepts/components/secrets-store.md) в кластере.
1. В Secrets Store созданы секреты, к которым должно обращаться приложение.

## Создайте namespace и ServiceAccount {#create-sa}

Создайте namespace для приложения (если ещё не создан):

```bash
kubectl create namespace myapp-namespace
```

Создайте ServiceAccount:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: myapp-sa
  namespace: myapp-namespace
```

```bash
kubectl apply -f serviceaccount.yaml
```

## Настройте роль в Secrets Store {#configure-role}

[Настройте роль в Secrets Store](../../concepts/components/secrets-store.md#openbao-role) с доступом к нужным путям и привязкой к созданному ServiceAccount.

## Создайте ConfigMap со ссылками на секреты {#create-configmap}

В значениях ключей ConfigMap укажите ссылки на секреты в формате `secrets:<путь>#<ключ>`:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: myapp-namespace
data:
  database.yaml: |
    host: postgres.example.com
    port: 5432
    username: myapp
    password: secrets:secret/data/myapp/database#password
  app.yaml: |
    log_level: info
    api_token: secrets:secret/data/myapp/api#token
```

```bash
kubectl apply -f configmap.yaml
```

## Подготовьте Deployment {#create-deployment}

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: myapp-namespace
data:
  database.yaml: |
    host: postgres.example.com
    port: 5432
    username: myapp
    password: secrets:secret/data/myapp/database#password
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: myapp-namespace
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
      annotations:
        secrets.stackland.yandex.cloud/render-configmap: "true"
        secrets.stackland.yandex.cloud/role: "myapp"
    spec:
      serviceAccountName: myapp-sa
      containers:
        - name: app
          image: myapp:latest
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
          volumeMounts:
            - name: app-config
              mountPath: /config
      volumes:
        - name: app-config
          configMap:
            name: app-config
```

Ключевые требования:

* Аннотация `secrets.stackland.yandex.cloud/render-configmap: "true"` включает ConfigMap mode.
* Аннотация `secrets.stackland.yandex.cloud/role` задает роль в Secrets Store.
* Аннотации размещаются в `spec.template.metadata.annotations` (на шаблоне пода).
* ConfigMap монтируется в директорию, указанную в `configmap-mounts` (по умолчанию `/config`).
* Том для готовых файлов с секретами добавляется вебхуком автоматически и монтируется в `/secrets`.

## Примените манифесты {#apply}

```bash
kubectl apply -f deployment.yaml
```

## Проверьте результат {#verify}

```bash
# Проверить статус пода
kubectl get pods -n myapp-namespace

# Проверить логи init-контейнера инжектора
kubectl logs <имя_пода> -n myapp-namespace -c stackland-secrets-injector

# Проверить содержимое /secrets внутри пода
kubectl exec -n myapp-namespace <имя_пода> -- ls /secrets
kubectl exec -n myapp-namespace <имя_пода> -- cat /secrets/database.yaml
```

В директории `/secrets` будут файлы с именами, соответствующими ключам ConfigMap, и подставленными значениями секретов. Права доступа к файлам — `0600`.

## Несколько директорий ConfigMap {#multiple-mounts}

Если ConfigMap подмонтированы в несколько директорий, перечислите их через запятую:

```yaml
annotations:
  secrets.stackland.yandex.cloud/configmap-mounts: "/config/app,/config/db,/etc/config"
```

{% note warning %}

Формат `name:/path` не поддерживается — указывайте только пути к директориям.

{% endnote %}

## Диагностика {#troubleshooting}

Если секреты не подставляются, смотрите раздел [{#T}](troubleshooting.md).