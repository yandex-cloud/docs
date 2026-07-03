# Создать резервную копию

Если у вас есть кластер [PostgreSQL](../../concepts/components/postgresql.md) в [проекте](../projects/create-project.md)), вы можете создать для него резервную копию.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл ресурса `PostgresqlBackup`. Например, с помощью команды `touch postgresqlbackup.yaml`.
  1. Откройте файл и вставьте конфигурацию:

      {% include notitle [YAML-файл для создания резервной копии](../../_includes/yamls/operations/postgresql/new-copy.md) %}

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

Чтобы восстановить удаленный кластер из резервной копии, см. инструкцию [Восстановить кластер](recover-copy.md).

{% endnote %}
