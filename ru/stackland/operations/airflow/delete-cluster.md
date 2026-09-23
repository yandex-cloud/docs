---
title: Удалить кластер {{ AF }}
description: Как удалить кластер {{ AF }} и связанные с ним данные
---

# Удалить кластер {{ AF }}

При удалении `AirflowCluster` удаляется кластер [{{ AF }}](../../concepts/components/airflow.md) и его база метаданных. Автоматически созданные бакеты также удаляются вместе с хранящимися в них DAG-файлами и логами задач.

Объекты, явно подключенные через `bucketRef` или `accessKeyRef`, не удаляются и не очищаются.

{% note alert %}

Перед удалением сохраните необходимые DAG-файлы и логи. История и настройки из базы метаданных будут удалены вместе с кластером. Операция необратима.

{% endnote %}

## Через CLI {#delete}

1. Проверьте [защиту от удаления](../../concepts/components/airflow.md#deletion-protection):

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -o jsonpath='{.spec.deletionProtection}'
    ```

1. Если защита включена, отключите ее:

    ```bash
    kubectl patch airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      --type=merge \
      -p '{"spec":{"deletionProtection":false}}'
    ```

1. Удалите ресурс:

    ```bash
    kubectl delete airflowcluster <имя_кластера> \
      -n <пространство_имен>
    ```

1. Дождитесь удаления:

    ```bash
    kubectl get airflowcluster <имя_кластера> \
      -n <пространство_имен> \
      -w
    ```

Во время удаления `status.phase` принимает значение `Deleting`. Дождитесь завершения операции. Если кластер долго остается в этом состоянии, воспользуйтесь [инструкцией по диагностике](troubleshooting.md#deletion).
