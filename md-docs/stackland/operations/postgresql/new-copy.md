# Создать резервную копию

Если у вас есть кластер [PostgreSQL](../../concepts/components/postgresql.md) в [проекте](../projects/create-project.md)), вы можете создать для него резервную копию.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл ресурса `PostgresqlBackup`. Например, с помощью команды `touch postgresqlbackup.yaml`.
  1. Откройте файл и вставьте конфигурацию:

      ```yaml
      apiVersion: postgresql.stackland.yandex.cloud/v1alpha1
      kind: PostgresqlBackup
      metadata:
        name: cluster-backup
      spec:
        cluster:
          name: cluster
      ```

  1. Примените манифест: `kubectl apply -f postgresqlbackup.yaml -n <название проекта>`. При необходимости можно прописать название проекта в параметр ресурса `metadata.namespace` и не использовать в команде.


- Консоль управления {#console}

  1. Если вы еще не открыли проект, выберите проект.
  1. В левом меню выберите **PostgreSQL Clusters**.
  1. Выберите кластер.
  1. Нажмите **Создать резервную копию**.
  1. Подтвердите создание резервной копии.

{% endlist %}

Готово, резервная копия создана.

{% note info %}

Чтобы восстановить удаленный кластер из резервной копии, следуйте инструкции [Восстановить кластер](recover-copy.md).

{% endnote %}