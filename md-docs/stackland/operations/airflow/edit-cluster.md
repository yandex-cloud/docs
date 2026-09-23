[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Оркестрация данных > Managed Service for Apache Airflow™ > Изменить настройки кластера Apache Airflow™

# Изменить настройки кластера Apache Airflow™

Настройки кластера [Apache Airflow™](../../concepts/components/airflow.md) изменяются в ресурсе `AirflowCluster`.

## Через CLI {#edit}

1. Выгрузите текущую конфигурацию:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -o yaml > airflow-cluster.yaml
    ```

1. Измените поля `spec` и удалите из файла служебные поля `status`, `metadata.resourceVersion`, `metadata.uid`, `metadata.creationTimestamp` и `metadata.managedFields`.

1. Примените конфигурацию:

    ```bash
    kubectl apply -f airflow-cluster.yaml
    ```

1. Дождитесь завершения обновления:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -w
    ```

    Поле `status.phase` должно принять значение `Ready` или `Paused`, если кластер приостановлен.

## Что можно изменить {#mutable-fields}

Без пересоздания кластера можно:

* выбрать другую поддерживаемую версию в `spec.version`;
* изменить количество реплик и ресурсы компонентов;
* изменить [`spec.config`](#airflow-config) с учетом ограничений;
* включить или выключить публичный доступ через `spec.publicAccess`;
* изменить дополнительные пакеты и их репозитории в `spec.dependencies`;
* изменить `ref` Git-репозитория и Secret с учетными данными;
* включить или отключить удаленные логи, добавив или удалив `spec.taskLogs`;
* [приостановить или возобновить кластер](pause-resume.md) через `spec.pause`;
* включить или выключить [защиту от удаления](../../concepts/components/airflow.md#deletion-protection) через `spec.deletionProtection`.

{% note warning %}

При добавлении или удалении `spec.taskLogs` существующие логи не переносятся между локальным диском и S3. Новая настройка применяется только к новым записям. Автоматически созданный бакет и уже сохраненные в нем объекты при отключении удаленных логов не удаляются.

{% endnote %}

## Что нельзя изменить {#immutable-fields}

После создания нельзя менять:

* тип источника DAG, URL Git-репозитория и `subPath`;
* тип объектного хранилища, имя бакета, эндпоинт, `subPath` и ссылки на ресурсы управляемого хранилища.

Для изменения этих параметров создайте новый `AirflowCluster` и перенесите данные отдельно.

База метаданных [создается автоматически](../../concepts/components/airflow.md#metadata-db). Выбрать другую базу или изменить ее параметры нельзя.

## Ресурсы компонентов {#resources}

В примерах ниже приведены фрагменты `spec`. Объедините их с текущей конфигурацией, сохранив остальные параметры.

Пример изменения числа реплик и ресурсов:

```yaml
spec:
  components:
    scheduler:
      replicas: 2
      resources:
        requests:
          cpu: 500m
          memory: 1Gi
        limits:
          cpu: "2"
          memory: 4Gi
    dagProcessor:
      replicas: 2
```

Если поле `resources` задано, укажите все четыре значения: `requests.cpu`, `requests.memory`, `limits.cpu` и `limits.memory`.

В `requests` задаются гарантированные ресурсы для одного пода, в `limits` — максимальные. Поле `cpu` определяет количество CPU, а `memory` — объем оперативной памяти.

В `spec.components` доступны `scheduler`, `apiServer`, `triggerer` и `dagProcessor`. Для них задаются `replicas` и `resources`. Правила размещения подов не настраиваются.

## Параметры Apache Airflow™ {#airflow-config}

Поле `spec.config` задает параметры `airflow.cfg`: первый уровень — секция, второй — имя параметра. Например, чтобы отключить загрузку демонстрационных DAG-файлов:

```yaml
spec:
  config:
    core:
      load_examples: "False"
```

Все значения должны быть однострочными строками, включая числа и логические значения. Используйте буквальные значения без шаблонных выражений. Названия секций и параметров должны начинаться с латинской буквы, цифры или подчеркивания и содержать только латинские буквы, цифры, подчеркивания, точки и дефисы. Секция `DEFAULT` зарезервирована.

Следующие параметры нельзя изменять через `spec.config`. Ограничение действует независимо от регистра букв:

#|
|| **Секция** | **Параметры** ||
|| `api` | `base_url`, `secret_key` ||
|| `api_auth` | `jwt_secret` ||
|| `core` | `auth_manager`, `dags_folder`, `execution_api_server_url`, `executor`, `fernet_key` ||
|| `dag_processor` | `dag_bundle_config_list` ||
|| `database` | `sql_alchemy_conn` ||
|| `kubernetes_executor` | `multi_namespace_mode`, `namespace`, `pod_template_file`, `worker_container_repository`, `worker_container_tag` ||
|| `logging` | `delete_local_logs`, `remote_base_log_folder`, `remote_log_conn_id`, `remote_logging` ||
|| `metrics` | `statsd_host`, `statsd_on`, `statsd_port`, `statsd_prefix` ||
|| `scheduler` | `standalone_dag_processor` ||
|#

## Дополнительные зависимости {#dependencies}

Пример добавления Python- и Debian-пакетов:

```yaml
spec:
  dependencies:
    pip:
      - name: apache-airflow-providers-amazon
    deb:
      - name: libpq5
```

Для Python-пакета можно указать `version` с ограничением версии, например `">=2.0,<3.0"`; для Debian-пакета задается только `name`. Установка пакетов не меняет версию самого Apache Airflow™ из `spec.version`: несовместимые зависимости приводят к ошибке установки.

После изменения пакетов, репозиториев или связанных с ними Secret дождитесь завершения обновления кластера. Условие `DependenciesReady=True` для текущей конфигурации подтверждает, что зависимости готовы. Если установка пакетов завершилась ошибкой, воспользуйтесь [инструкцией по диагностике](troubleshooting.md#dependencies).

### Репозитории пакетов {#package-repositories}

Если `repositories` не задано, используются предустановленные настройки pip и APT. Для своих источников задайте `spec.dependencies.repositories`:

```yaml
spec:
  dependencies:
    pip:
      - name: apache-airflow-providers-amazon
    deb:
      - name: libpq5
    repositories:
      pip:
        index:
          url: https://pypi.example.org/simple
          credentialsSecretRef:
            name: airflow-pypi-auth
          caSecretRef:
            name: airflow-repository-ca
            key: ca.crt
        extraIndexes:
          - url: https://pypi.org/simple
      deb:
        url: https://apt.example.org/debian
        suite: bookworm
        components: [main]
        credentialsSecretRef:
          name: airflow-apt-auth
        signingKeySecretRef:
          name: airflow-apt-key
          key: archive.asc
        caSecretRef:
          name: airflow-repository-ca
          key: ca.crt
```

Подготовьте указанные Secret в пространстве имен `AirflowCluster`:

* `credentialsSecretRef` — непустые ключи `username` и `password`. Допускаются печатные ASCII-символы без пробелов. Для репозитория без аутентификации ссылку можно опустить;
* `caSecretRef` — ключ с CA-сертификатами в формате PEM. Ссылка нужна, если репозиторий использует собственный центр сертификации;
* `signingKeySecretRef` — запись Secret с ключом подписи APT-репозитория. Эта ссылка обязательна для `repositories.deb`.

URL репозиториев должны использовать HTTPS и не содержать учетные данные, параметры запроса или фрагмент. URL pip должен заканчиваться на `/simple`. Поддерживаются один основной и до 16 дополнительных индексов pip; для индексов на одном хосте используйте одинаковый `credentialsSecretRef`. Для APT поддерживается один репозиторий.

Секция `repositories.pip` допустима только при непустом списке `pip`, а `repositories.deb` — при непустом списке `deb`. В установке без доступа в интернет замените все адреса в примере, включая `extraIndexes`, на доступные внутри сети.