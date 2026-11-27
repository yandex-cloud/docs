[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > DataLens > Включить DataLens

# Включить DataLens

## Перед началом работы {#before-you-begin}

1. Убедитесь, что образы DataLens загружены в локальный реестр кластера. Подробнее см. в разделе [Загрузить образы DataLens](install-images.md).
1. Убедитесь, что компоненты Managed Service for PostgreSQL, Object Storage и Identity and Access Management включены в кластере и готовы к работе.
1. Включите Lockbox и дождитесь его готовности.
1. Включите Connection Manager и дождитесь его готовности.

## Включить компонент {#enable}

1. Создайте файл манифеста `datalensconfig.yaml` со следующим содержимым. В кластере допускается только одна конфигурация DataLens с именем `main`:

   ```yaml
   apiVersion: stackland.yandex.cloud/v1alpha1
   kind: DataLensConfig
   metadata:
     name: main
   spec:
     enabled: true
   ```

1. Примените манифест:

   ```bash
   kubectl apply -f datalensconfig.yaml
   ```

## Проверить статус установки {#check-status}

1. Проверьте статус установки компонента:

   ```bash
   kubectl get componentinstallation -l component=datalens
   ```

1. Дождитесь готовности всех подов в пространстве имён `stackland-datalens`:

   ```bash
   kubectl get pods -n stackland-datalens
   ```

   Все поды должны перейти в статус `Running`. Приложения запускаются после готовности базы данных и ресурсов Identity and Access Management.

## Открыть консоль DataLens {#open-console}

После завершения установки интерфейс DataLens доступен по адресу `https://datalens.sys.<домен кластера>`. Вход выполняется через Identity and Access Management.

## Что создаётся при включении {#created-resources}

При включении DataLens автоматически создаются следующие ресурсы:

* Пространство имён `stackland-datalens`.
* Кластер PostgreSQL `datalens-db` с базами `stackland_us` и `stackland_aux`, необходимыми расширениями и pooler. Для US создаётся пользователь `datalens`, владеющий обеими базами без прав суперпользователя.
* Бакет в Object Storage для ежедневных резервных копий PostgreSQL. Копии хранятся 7 дней, сохраняются как минимум две копии.
* Приложения `datalens-ui` и `datalens-us`, их внутренние Services и отдельные ServiceAccounts.
* Приложения `control-api`, `data-api` и `control-api-async`, их внутренние Services и общий ServiceAccount `datalens-backend`.
* Secrets `datalens-db-user` и `datalens-runtime` с паролем базы, master token, ключами cookies/CSRF и ключом шифрования BI backend. При повторном применении конфигурации значения сохраняются.
* OAuthClient `stackland.datalens` для интеграции с Identity and Access Management.
* Группа `stackland-datalens-admins` в Identity and Access Management с добавленным администратором кластера.

## Настроить конфигурацию {#configure}

Чтобы изменить параметры компонента, отредактируйте ресурс `DataLensConfig`:

```bash
kubectl edit datalensconfig main
```

Подробнее о параметрах конфигурации см. в разделе [DataLens](../../concepts/components/datalens.md#configuration).

## Настроить нейроаналитика {#ai-analyst}

После включения DataLens создайте Secret `datalens-ai` с ключом `api-token` в пространстве имён `stackland-datalens`. Например, если токен провайдера хранится в локальном файле:

```bash
kubectl -n stackland-datalens create secret generic datalens-ai --from-file=api-token=/path/to/token
```

Добавьте блок `ai` в `spec.settings` ресурса `DataLensConfig/main`, сохранив остальные настройки:

```yaml
spec:
  enabled: true
  settings:
    ai:
      endpoint: https://llm.example.org/v1
      modelName: my-model
      modelContextWindowSize: 64000
      extraHeaders:
        x-folder-id: "example-folder-id"
      providerStream: false
```

Обязательны `endpoint` и `modelName`. Укажите базовый URL OpenAI-совместимого API, доступный серверу DataLens, и идентификатор модели у провайдера. Клиент добавляет путь `/chat/completions` к базовому URL.

Дополнительные параметры:

| Параметр | Назначение | По умолчанию |
| --- | --- | --- |
| `modelContextWindowSize` | Размер контекстного окна модели в токенах. | `128000` |
| `extraHeaders` | Дополнительные HTTP-заголовки для запросов сервера к провайдеру. Указывайте только несекретные значения. | Нет |
| `providerStream` | Запрашивать у провайдера потоковый ответ. | `true` |

Нейроаналитик доступен, когда заданы настройки модели и сервер получил токен из Secret. При обновлении токена в Secret Stackland перезапускает поды UI. Чтобы отключить нейроаналитика, удалите блок `spec.settings.ai`.

## Подключить Data Catalog {#integrations}

Data Catalog устанавливается отдельно. DataLens подключается к `datacatalog.<домен кластера>:443` по gRPC с TLS.

IAM ID определяется по аннотациям ServiceAccount `yc.datacatalog.worker` в пространстве имён `stackland-datacatalog`. При создании, изменении или удалении ServiceAccount контроллер обновляет конфигурацию DataLens. Доступность IAM ID отражается в условии `DataCatalogReady` в `DataLensConfig.status.conditions`.

## Доступ к Connection Manager {#connection-manager}

Приложения `control-api`, `data-api` и `control-api-async` работают от имени ServiceAccount `datalens-backend`. Для него в пространстве имён `stackland-datalens` создаются привязки ролей `connection-manager.editor`, `connection-manager.clusterCredentialsResolver` и `connection-manager.clusterCredentialsResolverWeak`.

## Ключ шифрования подключений {#encryption-key}

Ключ шифрования подключений `DL_CRY_KEY_VAL_ID_KEY` создаётся один раз и хранится в Secret `datalens-runtime`.

{% note warning %}

Сохраните резервную копию Secret `datalens-runtime`. Если ключ утерян, восстановите его из резервной копии: с новым ключом сохранённые пароли подключений станут недоступны.

{% endnote %}