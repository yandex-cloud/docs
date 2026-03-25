# Настроить и активировать {{ speechsense-name }}

После [загрузки образов](install-images.md) активируйте компонент {{ speechsense-name }} в кластере {{ stackland-name }}.

## Перед началом работы {#before-you-begin}

1. Убедитесь, что образы {{ speechsense-name }} [загружены](install-images.md) в кластер.
1. Убедитесь, что компонент [{{ gpu-operator }}](../../concepts/components/gpu.md) включён и узлы с GPU доступны.
1. Убедитесь, что компоненты [{{ mpg-name }}](../../concepts/components/postgresql.md), [{{ mch-name }}](../../concepts/components/clickhouse.md) и [{{ mkf-name }}](../../concepts/components/kafka.md) включены.
1. Подготовьте S3-совместимое хранилище:
    * [Создайте бакет](../storage/create-bucket.md) для хранения аудиофайлов.
    * [Создайте AccessKey](../storage/create-accesskey.md) для доступа к хранилищу.

## Активировать компонент {#enable}

1. Создайте файл манифеста `speechsense-config.yaml`:

    {% include notitle [speechsense-config](../../_includes/yamls/components/speechsenseconfig.md) %}

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
    * Создаст кластеры {{ PG }}, {{ CH }}, {{ KF }} и OpenSearch.
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

Установка {{ speechsense-name }} занимает значительное время. Образы больших языковых моделей (LLM) весят 30–70 ГБ.

{% endnote %}

## Открыть консоль {{ speechsense-name }} {#open-console}

После завершения установки консоль {{ speechsense-name }} доступна по адресу:

```text
https://speechsense.sys.$cluster.$baseDomain
```

Для входа используйте учётные данные пользователя {{ stackland-name }}. Администраторы кластера автоматически получают права администратора {{ speechsense-name }}.

## Что дальше {#whats-next}

* [{#T}](disable.md) — отключение {{ speechsense-name }}.
* [{{ speechsense-name }}](../../concepts/components/speechsense.md) — описание компонента.
