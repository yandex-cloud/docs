[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Managed Service for ClickHouse® > Создать пользователя

# Создать пользователя

Если у вас есть [кластер](create-cluster.md) [ClickHouse®](../../concepts/components/clickhouse.md), вы можете создать в нем пользователя с помощью кастомного ресурса `ClickhouseUser`.

Пароль пользователя хранится в Kubernetes Secret с ключом `password`. Имя ресурса `ClickhouseUser` и Secret должно соответствовать шаблону `<название_кластера>-<имя_пользователя>`. Если поле `spec.authentication.secretName` не задано, оператор использует Secret с таким же именем по умолчанию.

Ресурсы `ClickhouseUser` и Secret должны находиться в том же пространстве имен, что и кластер `ClickhouseCluster`.

## Через CLI {#cli}

1. Создайте файл ресурсов `ClickhouseUser` и Secret. Например, с помощью команды `touch clickhouseuser.yaml`.
1. Откройте файл и вставьте конфигурацию ниже:

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
      name: <название_кластера>-<имя_пользователя>
    type: Opaque
    stringData:
      password: "<пароль>"
    ---
    apiVersion: clickhouse.stackland.yandex.cloud/v1alpha1
    kind: ClickhouseUser
    metadata:
      name: <название_кластера>-<имя_пользователя>
    spec:
      cluster: <название_кластера>
      name: <имя_пользователя>
      roles:
        - name: <название_кластера>-reader
        - name: <название_кластера>-writer
      authentication:
        secretName: <название_кластера>-<имя_пользователя>
    ```

    Где:

    * `spec.cluster` — название кластера `ClickhouseCluster`.
    * `spec.name` — имя пользователя в ClickHouse®.
    * `spec.roles` — список ролей, назначенных пользователю. В каждом элементе указывается `name` — имя ресурса `ClickhouseRole` в том же пространстве имен.
    * `spec.authentication.secretName` — имя Secret с паролем. Необязательное поле; если не задано, используется Secret с именем `<название_кластера>-<имя_пользователя>`.
    * В Secret в поле `stringData.password` задается пароль пользователя.

1. Примените манифест: `kubectl apply -f clickhouseuser.yaml -n <название_проекта>`.

## Через консоль управления {#console}

1. Если вы еще не открыли проект, выберите проект.
1. В левом меню выберите **ClickHouse® Clusters**.
1. Выберите кластер.
1. Перейдите на вкладку **Пользователи**.
1. Нажмите **Создать**.
1. Заполните поля:

    * **Имя** — имя пользователя в ClickHouse®.
    * **Пароль** — пароль пользователя. Консоль управления создает Kubernetes Secret с паролем автоматически.
    * **Роли** — список ролей, которые назначаются пользователю. Можно выбрать несколько ролей из тех, что созданы в этом кластере.

1. Нажмите **Создать**.

Готово, пользователь появится в списке на вкладке **Пользователи**.