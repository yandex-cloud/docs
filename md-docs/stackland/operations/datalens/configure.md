[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > DataLens > Включить DataLens

# Включить DataLens

## Перед началом работы {#before-you-begin}

1. Убедитесь, что образы DataLens загружены в локальный реестр кластера. Подробнее в разделе [Загрузить образы DataLens](install-images.md).
1. Убедитесь, что компоненты Managed Service for PostgreSQL и Identity and Access Management включены в кластере.

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

## Открыть консоль DataLens {#open-console}

После завершения установки консоль DataLens доступна по адресу `https://datalens.<домен кластера>`. Чтобы войти в консоль, нажмите **Sign In via SSO** → **Stackland IAM** и авторизуйтесь в Identity and Access Management.

## Что создаётся при включении {#created-resources}

При включении DataLens автоматически создаются следующие ресурсы:

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
* OAuthClient `stackland.datalens` для интеграции с Identity and Access Management.
* Группа `stackland-datalens-admins` в Identity and Access Management с добавленным администратором кластера.

## Настроить конфигурацию {#configure}

Чтобы изменить параметры компонента, отредактируйте ресурс `DataLensConfig`:

```bash
kubectl edit datalensconfig main
```

Подробнее о параметрах конфигурации в разделе [DataLens](../../concepts/components/datalens.md#configuration).