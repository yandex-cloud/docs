[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Базы данных > Managed Service for PostgreSQL > Создать пользователя

# Создать пользователя PostgreSQL

Если у вас есть кластер [PostgreSQL](../../concepts/components/postgresql.md) в [проекте](../projects/create-project.md), вы можете создать в нем пользователя — роль PostgreSQL с правом входа. Пользователь описывается ресурсом `PostgresqlRole`. Пароль пользователя хранится в Kubernetes Secret: оператор может сгенерировать его автоматически или вы можете указать собственный Secret с учетными данными.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл ресурса `PostgresqlRole`. Например, с помощью команды `touch postgresqlrole.yaml`.
  1. Откройте файл и вставьте конфигурацию ниже:

      Правила именования:

      * Имя роли в PostgreSQL (`spec.username`) должно начинаться с латинской буквы или нижнего подчеркивания и может содержать только латинские буквы, цифры и нижние подчеркивания.
      * Имя ресурса `PostgresqlRole` (`metadata.name`) должно иметь вид `<имя_кластера>-<имя_пользователя_с_тире_вместо_нижних_подчеркиваний>`.

      {% list tabs %}

      - Минимальная конфигурация

          ```yaml
          apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
          kind: PostgresqlRole
          metadata:
            name: test-cluster-test-user # имя ресурса PostgresqlRole в формате <имя-кластера>-<имя-пользователя-с-тире-вместо-нижних-подчеркиваний>
          spec:
            cluster: test-cluster # имя ресурса PostgresqlCluster
            username: test_user # имя роли в PostgreSQL
          ```

          В манифесте заданы только обязательные поля: имя кластера и имя роли в PostgreSQL. Пароль будет сгенерирован автоматически и сохранен в Kubernetes Secret с тем же именем, что и у ресурса `PostgresqlRole`.

      - Конфигурация с явным паролем

          ```yaml
          apiVersion: v1
          kind: Secret
          metadata:
            name: test-cluster-user-secret
          type: Opaque
          stringData:
            username: test_user # имя пользователя
            password: "<пароль_пользователя>" # пароль пользователя
          ---
          apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
          kind: PostgresqlRole
          metadata:
            name: test-cluster-test-user # имя ресурса PostgresqlRole в формате <имя-кластера>-<имя-пользователя-с-тире-вместо-нижних-подчеркиваний>
          spec:
            cluster: test-cluster # имя ресурса PostgresqlCluster
            username: test_user # имя роли в PostgreSQL
            authentication:
              type: password
              secretName: test-cluster-user-secret # имя Secret с учетными данными
          ```

          В манифесте описаны Secret с учетными данными и ресурс `PostgresqlRole` со ссылкой на этот Secret через `spec.authentication.secretName`. Secret должен содержать ключи `username` с именем пользователя и `password` с паролем пользователя.

      - Полная конфигурация

          ```yaml
          apiVersion: v1
          kind: Secret
          metadata:
            name: test-cluster-user-secret
          type: Opaque
          stringData:
            username: test_user # имя пользователя
            password: "<пароль_пользователя>" # пароль пользователя
          ---
          apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
          kind: PostgresqlRole
          metadata:
            name: test-cluster-test-user # имя ресурса PostgresqlRole в формате <имя-кластера>-<имя-пользователя-с-тире-вместо-нижних-подчеркиваний>
          spec:
            cluster: test-cluster
            username: test_user
            authentication:
              type: password
              secretName: test-cluster-user-secret
            membership: # родительские роли, в которые включается пользователь
              - test-parent-role
            options:
              superuser: false # права суперпользователя
              login: true # разрешить вход
              createdb: false # право создавать базы данных
              createrole: false # право создавать роли
              inherit: true # наследование прав родительских ролей
              replication: false # право использовать репликацию
              bypassRLS: false # обход политик row-level security
              connectionLimit: -1 # лимит одновременных подключений, -1 — без лимита
              validUntil: "2026-12-31T23:59:59Z" # срок действия пароля в формате RFC3339
          ```

          В блоке `spec.options` задаются права роли: `superuser`, `login`, `createdb`, `createrole`, `inherit`, `replication`, `bypassRLS`, `connectionLimit`, `validUntil`. В блоке `spec.membership` перечисляются родительские роли, в которые включается пользователь.

      {% endlist %}

  1. Примените манифест: `kubectl apply -f postgresqlrole.yaml -n <название_проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.

- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **PostgreSQL Clusters**.
  1. Выберите кластер.
  1. Перейдите на вкладку **Пользователи**.
  1. Нажмите **Создать**.
  1. Заполните поля:

      * **Имя** — имя роли в PostgreSQL. Должно начинаться с латинской буквы или `_`, может содержать латинские буквы, цифры и `_`. Максимальная длина — 63 символа.
      * **Пароль** — пароль пользователя. Сохраняется в Kubernetes Secret и в открытом виде после сохранения не отображается.
      * **Суперпользователь** — переключатель прав суперпользователя. По умолчанию выключен.

  1. При необходимости раскройте раздел **Дополнительные параметры** и измените значения:

      * **Разрешить вход** — разрешает роли подключаться к PostgreSQL. По умолчанию включено.
      * **Родительские роли** — список ролей, в которые будет включен пользователь.
      * **Создание баз данных** — право создавать новые базы данных. По умолчанию выключено.
      * **Создание ролей** — право создавать, изменять и удалять роли. По умолчанию выключено.
      * **Наследование прав ролей** — наследование прав родительских ролей. По умолчанию включено.
      * **Режим репликации** — право использовать репликацию и операции, связанные с передачей WAL. По умолчанию выключено.
      * **Обход политик RLS** — право обходить политики row-level security. По умолчанию выключено.
      * **Лимит подключений** — максимальное число одновременных подключений. Значение `-1` — без лимита, `0` — запретить новые подключения. По умолчанию `-1`.
      * **Пароль действителен до** — срок действия пароля в формате RFC3339.

  1. Нажмите **Создать**.

  Готово, пользователь появился на вкладке **Пользователи** выбранного кластера.

{% endlist %}