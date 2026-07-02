[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > Концепции > [Компоненты](overview.md) > Secrets Store

# Secrets Store

Stackland использует для безопасного хранения секретов и их подстановки два основных инструмента:

* Secrets Injector — загружает секреты по API, совместимому с [Vault](https://developer.hashicorp.com/vault/docs), и подставляет их в ресурсы кластера.
* Хранилище секретов, совместимое с [Vault](https://developer.hashicorp.com/vault/docs).

Если использовать конфигурацию Secrets Injector по умолчанию, то в кластере хранилищем секретов будет [OpenBao](https://openbao.org/), форк системы [Vault](https://developer.hashicorp.com/vault/docs).

Вы можете изменить настройки по умолчанию с помощью параметров [кастомного ресурса](#configuration) `SecretsStoreConfig`.

## Архитектура {#architecture}

Secrets Store состоит из трех компонентов:

1. **Mutation Webhook** — обрабатывает создание и обновление `Deployment`, `StatefulSet`, `DaemonSet`, `Job` и `CronJob`. Для этих ресурсов вебхук добавляет init-контейнер с бинарным файлом `stackland-secrets-injector`. Напрямую поды вебхук не обрабатывает. Вебхук работает автоматически в пространствах имен, где инъекция не [отключена явно](#namespace-selector).
1. **Secrets Injector** (`stackland-secrets-injector`) — бинарный файл инжектора. Аутентифицируется в Secrets Store, получает секреты по ссылкам вида `secrets:<путь>#<ключ>`. В Env mode запускается как обертка процесса основного контейнера, в ConfigMap mode работает как init-контейнер.
1. **OpenBao** — хранилище секретов, совместимое с Vault API. Разворачивается в пространстве имен `stackland-secrets-store` и доступно изнутри кластера по адресу `https://openbao.stackland-secrets-store.svc.cluster.local:8200`.

В Env mode вебхук добавляет init-контейнер `copy-stackland-secrets-injector` и том `emptyDir` с именем `stackland-secrets-injector`. Через этот том в основной контейнер передается бинарный файл инжектора. В ConfigMap mode вебхук добавляет init-контейнер `stackland-secrets-injector` и том `emptyDir` с именем `stackland-secrets`: init-контейнер читает подмонтированные ConfigMap, получает секреты из OpenBao и записывает обработанные файлы в этот том. Основной контейнер читает результат из директории `/secrets`. В Dual mode используются оба механизма одновременно.

## Режимы работы {#modes}

### Env mode {#env-mode}

В этом режиме инжектор запускается как **обертка процесса** (process wrapper). Он подставляет секреты в переменные окружения и затем запускает команду основного контейнера с уже заполненными переменными.

Для работы Env mode необходимо:

1. Указать аннотацию `secrets.stackland.yandex.cloud/render-env: "true"` в шаблоне пода.
1. Задать аннотацию `secrets.stackland.yandex.cloud/role` с именем роли в Secrets Store.
1. В поле `env` контейнера использовать ссылки на секреты в формате `secrets:<путь>#<ключ>`.
1. Задать явную команду запуска: `command` или `args`, где первый элемент `args` — исполняемый файл. Инжектор использует эти поля для запуска приложения.

{% note warning %}

В Env mode задайте `command` контейнера или `args`, где первый элемент — исполняемый файл. Если не задано ни одно из этих полей, инжектор завершится с ошибкой `no command is given` и основной контейнер не запустится. ENTRYPOINT образа не используется автоматически.

{% endnote %}

Аннотации в Env mode рекомендуется размещать в `spec.template.metadata.annotations` (на шаблоне пода). Для `Deployment`, `StatefulSet`, `DaemonSet` и `Job` вебхук также может скопировать аннотации из `metadata.annotations` ресурса, если они не заданы в шаблоне пода. Если одна и та же аннотация задана в обоих местах, используется значение из шаблона пода.

Подробное руководство: [Инъекция секретов в переменные окружения (Env mode)](../../operations/secrets-store/inject-secrets-env.md).

### ConfigMap mode {#configmap-mode}

В этом режиме инжектор запускается как init-контейнер и обрабатывает ConfigMap, подмонтированные в под. Он находит в значениях ConfigMap ссылки на секреты и получает их из Secrets Store. Результат записывается в директорию `/secrets` в виде плоской структуры файлов с правами `0600`. Основной контейнер затем читает файлы из `/secrets`.

Для работы ConfigMap mode необходимо:

1. Указать аннотацию `secrets.stackland.yandex.cloud/render-configmap: "true"`.
1. Задать аннотацию `secrets.stackland.yandex.cloud/role`.
1. В значениях ConfigMap использовать ссылки на секреты.
1. Подмонтировать ConfigMap в контейнер.

Подробное руководство: [Инъекция секретов через ConfigMap (ConfigMap mode)](../../operations/secrets-store/inject-secrets-configmap.md).

### Dual mode {#dual-mode}

Одновременное использование Env mode и ConfigMap mode. Для включения задайте оба флага:

```yaml
annotations:
  secrets.stackland.yandex.cloud/render-env: "true"
  secrets.stackland.yandex.cloud/render-configmap: "true"
  secrets.stackland.yandex.cloud/role: "myapp"
```

Полный пример манифеста:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: myapp-namespace
data:
  app.yaml: |
    db_host: postgres.example.com
    db_password: secrets:secret/data/myapp/database#password
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
        secrets.stackland.yandex.cloud/render-env: "true"
        secrets.stackland.yandex.cloud/render-configmap: "true"
        secrets.stackland.yandex.cloud/role: "myapp"
    spec:
      serviceAccountName: myapp-sa
      containers:
        - name: app
          image: myapp:latest
          # В Env mode задайте command или args с исполняемым файлом первым элементом.
          command:
            - /app/myapp
          resources:
            requests:
              cpu: "100m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
          env:
            - name: API_KEY
              value: "secrets:secret/data/myapp/api#key"
          volumeMounts:
            - name: app-config
              mountPath: /config
      volumes:
        - name: app-config
          configMap:
            name: app-config
```

## Формат ссылок на секреты {#secret-references}

Ссылки на секреты используются в полях `env[].value` контейнера (Env mode) или в значениях ключей ConfigMap (ConfigMap mode).

Базовый формат:

```
secrets:<vault_path>#<key>
```

Где:

* `<vault_path>` — путь к секрету в Secrets Store, например `secret/data/myapp/database`.
* `<key>` — ключ внутри секрета, например `password`.

Пример:

```yaml
env:
  - name: DB_PASSWORD
    value: "secrets:secret/data/myapp/database#password"
  - name: API_KEY
    value: "secrets:secret/data/myapp/api#key"
```

## Namespace-selector {#namespace-selector}

Mutation Webhook применяется ко всем пространствам имен кластера, кроме тех, в которых явно отключена инъекция. Вебхук обрабатывает создание и обновление `Deployment`, `StatefulSet`, `DaemonSet`, `Job` и `CronJob`, но не обрабатывает напрямую созданные поды.

Чтобы отключить инъекцию секретов для конкретного пространства имен, добавьте ему метку:

```yaml
kubectl label namespace <имя_пространства_имен> secrets.stackland.yandex.cloud/injection=disabled
```

## Аннотации Mutation Webhook {#annotations}

Аннотации задаются в шаблоне пода: `spec.template.metadata.annotations` для `Deployment`, `StatefulSet`, `DaemonSet` и `Job`, `spec.jobTemplate.spec.template.metadata.annotations` для `CronJob`.

### Базовые аннотации

* `secrets.stackland.yandex.cloud/role` (обязательная) — роль в Secrets Store для аутентификации пода.
* `secrets.stackland.yandex.cloud/mutate` — значение `skip` полностью отключает мутацию для пода.
* `secrets.stackland.yandex.cloud/addr` — адрес сервера Secrets Store. По умолчанию `https://openbao.stackland-secrets-store.svc.<домен кластера>:8200`.
* `secrets.stackland.yandex.cloud/auth-path` — путь аутентификации в Secrets Store. По умолчанию `kubernetes`.
* `secrets.stackland.yandex.cloud/namespace` — пространство имен OpenBao (только для Vault Enterprise).

### Выбор режима

* `secrets.stackland.yandex.cloud/render-env` — включить Env mode. По умолчанию `false`.
* `secrets.stackland.yandex.cloud/render-configmap` — включить ConfigMap mode. По умолчанию `false`.

### Настройки ConfigMap mode

* `secrets.stackland.yandex.cloud/configmap-mounts` — директории, в которых инжектор ищет подмонтированные ConfigMap (пути через запятую). По умолчанию `/config`. Формат `name:/path` **не поддерживается**, только пути к директориям.

### Дополнительные параметры

* `secrets.stackland.yandex.cloud/containers` — список контейнеров для мутации (имена через запятую). Если не задан, а в поде несколько контейнеров — вебхук отклоняет под.
* `secrets.stackland.yandex.cloud/skip-tls-verify` — отключить проверку TLS-сертификата при подключении к Secrets Store. По умолчанию `false`.
* `secrets.stackland.yandex.cloud/ignore-missing-secrets` — продолжить работу, если часть секретов не найдена (вместо аварийного завершения). По умолчанию `false`.
* `secrets.stackland.yandex.cloud/injector-image` — переопределить образ инжектора.
* `secrets.stackland.yandex.cloud/injector-image-tag` — переопределить тег образа инжектора. По умолчанию `latest`.
* `secrets.stackland.yandex.cloud/secrets-volume-name` — имя тома для файлов с секретами. По умолчанию `stackland-secrets`.

## Настройка роли в Secrets Store {#openbao-role}

Чтобы инжектор мог получать секреты, настройте аутентификацию в Secrets Store. Kubernetes auth включается компонентом автоматически.

1. Создайте ServiceAccount в кластере:

   ```bash
   kubectl create serviceaccount myapp-sa -n myapp-namespace
   ```

1. Создайте policy с доступом к нужным путям:

   ```hcl
   # myapp-policy.hcl
   path "secret/data/myapp/*" {
     capabilities = ["read"]
   }
   ```

   ```bash
   bao policy write myapp-policy myapp-policy.hcl
   ```

1. Создайте role и привяжите ее к ServiceAccount пода:

   ```bash
   bao write auth/kubernetes/role/myapp \
     bound_service_account_names=myapp-sa \
     bound_service_account_namespaces=myapp-namespace \
     policies=myapp-policy \
     ttl=1h
   ```

Подробное описание настройки Kubernetes auth в OpenBao — в [официальной документации OpenBao](https://openbao.org/docs/auth/kubernetes/).

## Доступ к Secrets Store {#openbao}

Интерфейс и доступ к API Secrets Store по умолчанию выключены:

* Чтобы открыть доступ к API Secrets Store извне кластера, установите флаг `server.ingress.enabled = true`.
* Чтобы открыть доступ к интерфейсу Secrets Store извне кластера, установите флаги `server.ingress.enabled = true` и `ui.enabled = true`.

Интерфейс и API станут доступны по адресу `https://secrets.sys.<домен кластера>`. Если `ui.enabled = true`, а `server.ingress.enabled = false`, то доступ к интерфейсу будет только внутри кластера.

## Использование Secrets Injector {#secrets-injector}

После включения компонента Secrets Store инжектор не требует отдельного развертывания. Secrets Injector использует Secrets Store в Stackland. Для получения секретов приложением настройте секреты, policy и role в Secrets Store. При необходимости можно настроить использование собственного хранилища секретов в кастомном ресурсе в [параметре](#secrets-injector-settings) `secretsAddr`.

Для аутентификации сервисных аккаунтов Secrets Injector использует API Secrets Store. По умолчанию применяется эндпоинт `auth/kubernetes`. Если для приложения нужен другой путь аутентификации, задайте аннотацию `secrets.stackland.yandex.cloud/auth-path` в шаблоне пода.

## Конфигурация {#configuration}

Пример:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: SecretsStoreConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    stacklandSecretsInjector: # Настройки Secrets Injector
      authPath: kubernetes
      enabled: true
      resources:
        limits:
          cpu: 100m
          memory: 128Mi
        requests:
          cpu: 50m
          memory: 64Mi
      secretsAddr: ''
      skipTLSVerify: false
      webhookTimeout: 30
    server: # Настройки пода OpenBao
      dataStorage:
        size: 2Gi
        storageClass: stackland-other
      enabled: true
      ingress:
        clusterIssuer: stackland-default
        enabled: false
      resources:
        limits:
          cpu: 500m
          memory: 512Mi
        requests:
          cpu: 100m
          memory: 256Mi
      updateStrategyType: RollingUpdate
    ui:
      enabled: true # Использование интерфейса OpenBao
```

### Параметры Secrets Injector {#secrets-injector-settings}

```yaml
stacklandSecretsInjector:
  authPath: kubernetes
  enabled: true
  resources:
    limits:
      cpu: 100m
      memory: 128Mi
    requests:
      cpu: 50m
      memory: 64Mi
  secretsAddr: ''
  skipTLSVerify: false
  webhookTimeout: 30
```

* `authPath` — указывает путь Kubernetes auth backend, который компонент настраивает в Secrets Store. По умолчанию используется `kubernetes`, что соответствует эндпоинту API `auth/kubernetes`. Для приложений, которым нужен другой путь аутентификации, укажите такой же путь в аннотации `secrets.stackland.yandex.cloud/auth-path`.
* `enabled` — включает использование Secrets Injector.
* `resources` — зарезервированный параметр для настройки ресурсов (CPU и память) пода Secrets Injector. В текущей версии используются значения по умолчанию.
* `secretsAddr` — указывает HTTPS-адрес API Secrets Store.
* `skipTLSVerify` — зарезервированный параметр. Чтобы отключить проверку TLS-сертификата для конкретного приложения, используйте аннотацию `secrets.stackland.yandex.cloud/skip-tls-verify: "true"`.
* `webhookTimeout` — определяет время ожидания ответа от Secrets Injector.

### Параметры пода Secrets Store {#server}

```yaml
server:
  dataStorage:
    size: 2Gi
    storageClass: stackland-other
  enabled: true
  ingress:
    clusterIssuer: stackland-default
    enabled: false
  resources:
    limits:
      cpu: 500m
      memory: 512Mi
    requests:
      cpu: 100m
      memory: 256Mi
  updateStrategyType: RollingUpdate
```

* `dataStorage` — задает расширенные настройки для хранилища.
* `enabled` — включает использование пода.
* `ingress` — задает настройки объекта Ingress.
* `resources` — ограничивает ресурсы (CPU и память) для пода.
* `updateStrategyType` — определяет тип обновления.

### Использование интерфейса {#ui}

```yaml
ui:
  enabled: true
```

* `enabled` — включает интерфейс Secrets Store в OpenBao. Для внешнего доступа к интерфейсу дополнительно включите `server.ingress.enabled`.