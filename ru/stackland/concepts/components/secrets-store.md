# Secrets Store

{{ stackland-name }} использует для безопасного хранения секретов и их инъекции два основных инструмента:

* Secrets Injector — загружает секреты по API, совместимому с [Vault](https://developer.hashicorp.com/vault/docs), и подставляет их в ресурсы кластера.
* Хранилище секретов, совместимое с [Vault](https://developer.hashicorp.com/vault/docs).

Если использовать конфигурацию Secrets Injector по умолчанию, то в кластере хранилищем секретов будет [OpenBao](https://openbao.org/), форк системы [Vault](https://developer.hashicorp.com/vault/docs).

Вы можете изменить настройки по умолчанию с помощью параметров [кастомного ресурса](#configuration) `SecretsStoreConfig`.

## Доступ к OpenBao {#openbao}

Интерфейс и доступ к API OpenBao по умолчанию выключены:

* Чтобы открыть доступ к API OpenBao извне кластера, нужно установить флаг `server.ingress.enabled = true`;
* Чтобы открыть доступ к интерфейсу OpenBao извне кластера, нужно установить флаг `server.ingress.enabled = true` и `ui.enabled = true`.

Интерфейс и API станут доступны по адресу `https://secrets.sys.<домен кластера>`. Если `ui.enabled = true`, а `server.ingress.enabled = false`, то доступ к интерфейсу будет только внутри кластера.

## Использование Secrets Injector {#secretsInjector}

Secrets Injector готов к работе сразу после развертывания кластера и не требует дополнительной настройки. Secrets Injector использует хранилище OpenBao в {{ stackland-name }}. При необходимости можно настроить использование собственного хранилища секретов в кастомном ресурсе в [параметре](#secretsInjector-settings) `secretsAddr`.

Для аутентификации сервисных аккаунтов, которые подставляют секреты в манифесты, Secrets Injector использует API OpenBao. По умолчанию применяется эндпоинт `auth/kubernetes`, но его можно изменить, настроив [параметр](#secretsInjector-settings) `authPath`.

## Конфигурация {#configuration}

Пример:

{% include notitle [YAML-файл](../../_includes/yamls/components/secretsstoreconfig.md) %}

### Параметры Secrets Injector {#secretsInjector-settings}

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

* `authPath` — указывает эндпоинт API OpenBao для аутентификации и авторизации через Kubernetes. По умолчанию используется `auth/kubernetes`.
* `enabled` — включает использование Secrets Injector.
* `resources` — ограничивает ресурсы (CPU и память) для пода.
* `secretsAddr` — указывает HTTPS-адрес API OpenBao.
* `skipTLSVerify` — позволяет пропустить проверку TLS-сертификата, если его нет в списке доверенных сертификатов.
* `webhookTimeout` — определяет время ожидания ответа от Secrets Injector.

### Параметры пода OpenBao {#server}

```yaml
server:
  dataStorage:
    size: 2Gi
    storageClass: stackland-default
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

* `enabled` — включает интерфейс OpenBao по адресу `https://secrets.sys.<домен кластера>`.

