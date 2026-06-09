# Настроить и активировать SpeechSense

После [загрузки образов](install-images.md) активируйте компонент SpeechSense в кластере Stackland.

## Перед началом работы {#before-you-begin}

1. Убедитесь, что образы SpeechSense [загружены](install-images.md) в кластер.
1. Убедитесь, что компонент [«Поддержка NVIDIA® GPU»](../../concepts/components/gpu.md) включён и узлы с GPU доступны.
1. Убедитесь, что компоненты [Managed Service for PostgreSQL](../../concepts/components/postgresql.md), [Managed Service for ClickHouse®](../../concepts/components/clickhouse.md) и [Managed Service for Apache Kafka®](../../concepts/components/kafka.md) включены.
1. Подготовьте S3-совместимое хранилище:
    * [Создайте бакет](../storage/create-bucket.md) для хранения аудиофайлов.
    * [Создайте AccessKey](../storage/create-accesskey.md) для доступа к хранилищу.

## Активировать компонент {#enable}

1. Создайте файл манифеста `speechsense-config.yaml`:

    ```yaml
    apiVersion: stackland.yandex.cloud/v1alpha1
    kind: SpeechsenseConfig
    metadata:
      name: default
    spec:
      enabled: true
      settings:
        s3: # Опционально. Заполните, если нужно использовать внешнее хранилище
          endpoint: "<адрес_объектного_хранилища>"
          accessKeyID: "<идентификатор_ключа>"
          secretAccessKey: "<секретный_ключ>"
    ```

    Где:

    * `endpoint` — адрес объектного хранилища в кластере.
    * `accessKeyID` — идентификатор ключа доступа к хранилищу.
    * `secretAccessKey` — секретный ключ доступа к хранилищу.

1. Примените манифест:

    ```bash
    kubectl apply -f speechsense-config.yaml
    ```

1. Дождитесь завершения установки. Контроллер автоматически выполнит следующие действия:

    * Создаст namespace `stackland-speechsense`.
    * Сгенерирует секреты с паролями для баз данных.
    * Создаст кластеры PostgreSQL, ClickHouse®, Apache Kafka® и OpenSearch.
    * Создаст сертификаты через Certificate Manager.
    * Установит Helm-чарт `stackland-speechsense`.

## Проверить статус установки {#check-status}

Проверьте статус компонента:

```bash
kubectl get componentinstallation -n stackland-speechsense
```

Убедитесь, что все поды запущены:

```bash
kubectl get pods -n stackland-speechsense
```

{% note info %}

Установка SpeechSense занимает значительное время. Образы больших языковых моделей (LLM) весят 30–70 ГБ.

{% endnote %}

## Открыть консоль SpeechSense {#open-console}

После завершения установки консоль SpeechSense доступна по адресу:

```text
https://speechsense.sys.$cluster.$baseDomain
```

Для входа используйте учётные данные пользователя Stackland. Администраторы кластера автоматически получают права администратора SpeechSense.

## Что дальше {#whats-next}

* [Отключить SpeechSense](disable.md) — отключение SpeechSense.
* [SpeechSense](../../concepts/components/speechsense.md) — описание компонента.