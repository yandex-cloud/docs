[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Оркестрация данных > Managed Service for Apache Airflow™ > Создать кластер Apache Airflow™

# Создать кластер Apache Airflow™

Кластер [Apache Airflow™](../../concepts/components/airflow.md) создается ресурсом `AirflowCluster` в пространстве имен [проекта](../projects/create-project.md). Перед созданием кластера администратор установки должен [включить Managed Service for Apache Airflow™](enable.md).

База метаданных создается автоматически. Настраивать подключение к базе не требуется.

## Перед началом {#before-you-begin}

Подготовьте:

* [пространство имен проекта](../projects/manage-namespaces.md#create-namespace);
* Git-репозиторий с DAG-файлами или S3-совместимое хранилище;
* S3-совместимое хранилище, если нужны удаленные логи задач;
* Secret с учетными данными, если используется приватный Git-репозиторий или внешнее S3-хранилище.

Создайте Secret и ConfigMap, на которые ссылается конфигурация, в том же пространстве имен, что и `AirflowCluster`.

Для автоматически создаваемых бакетов должен быть включен компонент [Object Storage](../../concepts/components/storage.md).

Проверьте доступные версии Apache Airflow™:

```bash
kubectl get airflowimagecatalog airflow \
  -o jsonpath='{range .spec.images[*]}{.version}{"\n"}{end}'
```

Если команда не выводит версии, посмотрите структуру ресурса: `kubectl get airflowimagecatalog airflow -o yaml`.

## Через CLI {#create}

1. Создайте файл ресурса `AirflowCluster`, например `airflow-cluster.yaml`, и вставьте одну из конфигураций:

    {% list tabs %}

    - Git и локальные логи

        Пример использует публичный Git-репозиторий и локальные логи задач.

        ```yaml
        apiVersion: airflow.stackland.yandex.cloud/v1alpha1
        kind: AirflowCluster
        metadata:
          name: airflow-demo
        spec:
          version: "3.1.8"
          dags:
            source: git
            git:
              repo: https://github.com/example/airflow-dags.git
              ref: main
          publicAccess: true
          deletionProtection: true
        ```

    - Object Storage для DAG и логов

        Пример создает отдельные бакеты для DAG-файлов и логов задач. DAG-файлы загружаются из префикса `dags/` в бакете.

        ```yaml
        apiVersion: airflow.stackland.yandex.cloud/v1alpha1
        kind: AirflowCluster
        metadata:
          name: airflow-demo
        spec:
          version: "3.1.8"
          dags:
            source: s3
            s3:
              type: stackland-storage
              stacklandStorage:
                subPath: dags/
          taskLogs:
            type: stackland-storage
            stacklandStorage:
              subPath: logs/
          publicAccess: true
          deletionProtection: true
        ```

    {% endlist %}

1. Укажите имя кластера в `metadata.name` и доступную версию в `spec.version`. Для Git-источника замените URL репозитория и значение `ref` на свои.

    В обоих примерах включены публичный доступ к веб-интерфейсу (`spec.publicAccess: true`) и [защита от удаления](../../concepts/components/airflow.md#deletion-protection) (`spec.deletionProtection: true`). При необходимости измените эти параметры.

1. Примените манифест:

    ```bash
    kubectl apply -f airflow-cluster.yaml -n <пространство_имен>
    ```

    Пространство имен также можно указать в `metadata.namespace` манифеста и не передавать параметр `-n` в команде.

1. Дождитесь состояния `Ready`, подставив имя кластера из `metadata.name`:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -w
    ```

1. Если кластер долго остается в `Provisioning` или переходит в `Failed`, проверьте условия состояния в `status.conditions`:

    ```bash
    kubectl describe airflowcluster <имя_кластера> -n <пространство_имен>
    ```

    Рекомендации приведены в разделе [Устранение неполадок](troubleshooting.md).

## Приватный Git-репозиторий {#private-git}

Для HTTPS создайте Secret с фиксированными ключами `username` и `password`:

```bash
kubectl create secret generic airflow-git-auth \
  -n <пространство_имен> \
  --from-literal=username=<имя_пользователя> \
  --from-literal=password=<токен_или_пароль>
```

Добавьте ссылку в `spec.dags.git.authSecretRef` манифеста:

```yaml
spec:
  dags:
    source: git
    git:
      repo: https://git.example.com/team/airflow-dags.git
      ref: main
      authSecretRef:
        name: airflow-git-auth
```

Для SSH Secret должен содержать ключ `ssh-privatekey`, а ConfigMap — ключ `known_hosts`:

```yaml
spec:
  dags:
    source: git
    git:
      repo: git@git.example.com:team/airflow-dags.git
      ref: main
      authSecretRef:
        name: airflow-git-ssh
      knownHostsConfigMapRef:
        name: airflow-git-known-hosts
```

Интервал синхронизации Git и S3 составляет 60 секунд и не настраивается.

## Внешнее S3-хранилище {#external-s3}

Создайте Secret с ключами доступа:

```bash
kubectl create secret generic airflow-s3-credentials \
  -n <пространство_имен> \
  --from-literal=access-key-id=<идентификатор_ключа> \
  --from-literal=secret-access-key=<секретный_ключ>
```

Для DAG-файлов задайте в `spec`:

```yaml
spec:
  dags:
    source: s3
    s3:
      type: s3
      s3:
        bucket: airflow-dags
        region: ru-central1
        endpointUrl: https://storage.yandexcloud.net
        credentialsSecretRef:
          name: airflow-s3-credentials
          accessKeyIdPath: access-key-id
          secretAccessKeyPath: secret-access-key
        subPath: dags/
```

Для удаленных логов задайте в `spec` поле `taskLogs`:

```yaml
spec:
  taskLogs:
    type: s3
    s3:
      bucket: airflow-logs
      region: ru-central1
      endpointUrl: https://storage.yandexcloud.net
      credentialsSecretRef:
        name: airflow-s3-credentials
        accessKeyIdPath: access-key-id
        secretAccessKeyPath: secret-access-key
      subPath: logs/
```

## Дальнейшие действия {#next-steps}

* [Получите учетные данные администратора](get-admin-credentials.md).
* [Откройте веб-интерфейс Apache Airflow™](connect-ui.md).
* [Измените настройки кластера](edit-cluster.md), если требуется настроить ресурсы или зависимости.