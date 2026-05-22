# Включить {{ datalens-name }}

## Перед началом работы {#before-you-begin}

1. Убедитесь, что образы {{ datalens-name }} загружены в локальный реестр кластера. Подробнее см. в разделе [{#T}](install-images.md).
1. Убедитесь, что компоненты {{ mpg-name }} и {{ iam-name }} включены в кластере.

## Включить компонент {#enable}

1. Создайте файл манифеста `datalensconfig.yaml` со следующим содержимым:

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

   Все поды должны перейти в статус `Running`.

## Открыть консоль {{ datalens-name }} {#open-console}

После завершения установки консоль {{ datalens-name }} доступна по адресу `https://datalens.<домен кластера>`. Чтобы войти в консоль, нажмите **Sign In via SSO** → **Stackland IAM** и авторизуйтесь в {{ iam-name }}.

## Что создаётся при включении {#created-resources}

При включении {{ datalens-name }} автоматически создаются следующие ресурсы:

* Пространство имён `stackland-datalens`.
* Кластер PostgreSQL `datalens-db` со следующими базами данных:
  * `datalens-auth` — данные аутентификации;
  * `datalens-compeng` — вычислительный движок;
  * `datalens-us` — пользовательские настройки;
  * `datalens-meta-manager` — метаданные;
  * `datalens-demo` — демонстрационные данные;
  * `datalens-temporal` — данные планировщика задач;
  * `datalens-temporal-visibility` — данные видимости задач.
* Секреты с паролями базы данных и ключами аутентификации. В секрете `datalens-secrets` содержится пароль локального пользователя-администратора по умолчанию. Используйте его в случае возникновения проблем с IAM-федерацией.
* OAuthClient `stackland.datalens` для интеграции с {{ iam-name }}.
* Группа `stackland-datalens-admins` в {{ iam-name }} с добавленным администратором кластера.

## Настроить конфигурацию {#configure}

Чтобы изменить параметры компонента, отредактируйте ресурс `DataLensConfig`:

```bash
kubectl edit datalensconfig main
```

Подробнее о параметрах конфигурации см. в разделе [{{ datalens-name }}](../../concepts/components/datalens.md#configuration).
