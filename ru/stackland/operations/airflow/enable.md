---
title: Включить {{ maf-name }}
description: Как включить компонент {{ maf-name }} и проверить его готовность
---

# Включить {{ maf-name }}

Компонент [{{ maf-name }}](../../concepts/components/airflow.md) по умолчанию отключен. Чтобы создавать кластеры {{ AF }}, администратор установки должен включить его через ресурс `ManagedAirflowConfig main`.

## Через CLI {#enable}

1. Включите [{{ mpg-name }}](../../concepts/components/postgresql.md) и дождитесь готовности компонента:

    ```bash
    kubectl patch managedpostgresconfig main \
      --type=merge \
      -p '{"spec":{"enabled":true}}'
    kubectl get componentinstallation managed-postgres-main -w
    ```

    Компонент {{ mpg-name }} необходим для хранения метаданных {{ AF }} и должен оставаться включенным до удаления всех кластеров {{ AF }}.

1. Убедитесь, что ресурс существует:

    ```bash
    kubectl get managedairflowconfig main
    ```

1. Включите компонент:

    ```bash
    kubectl patch managedairflowconfig main \
      --type=merge \
      -p '{"spec":{"enabled":true}}'
    ```

1. Дождитесь готовности установки:

    ```bash
    kubectl get componentinstallation managed-airflow-main -w
    ```

    Компонент готов, когда поле `status.phase` принимает значение `Ready`.

1. Проверьте доступность каталога версий {{ AF }}:

    ```bash
    kubectl get airflowimagecatalog airflow
    ```

## Дальнейшие действия {#next-steps}

После включения компонента [создайте кластер {{ AF }}](create-cluster.md).
