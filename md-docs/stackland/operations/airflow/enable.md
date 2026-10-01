[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Оркестрация данных > Managed Service for Apache Airflow™ > Включить Managed Service for Apache Airflow™

# Включить Managed Service for Apache Airflow™

Компонент [Managed Service for Apache Airflow™](../../concepts/components/airflow.md) по умолчанию отключен. Чтобы создавать кластеры Apache Airflow™, администратор установки должен включить его через ресурс `ManagedAirflowConfig main`.

## Через CLI {#enable}

1. Включите [Managed Service for PostgreSQL](../../concepts/components/postgresql.md) и дождитесь готовности компонента:

    ```bash
    kubectl patch managedpostgresconfig main \
      --type=merge \
      -p '{"spec":{"enabled":true}}'
    kubectl get componentinstallation managed-postgres-main -w
    ```

    Компонент Managed Service for PostgreSQL необходим для хранения метаданных Apache Airflow™ и должен оставаться включенным до удаления всех кластеров Apache Airflow™.

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

1. Проверьте доступность каталога версий Apache Airflow™:

    ```bash
    kubectl get airflowimagecatalog airflow
    ```

## Дальнейшие действия {#next-steps}

После включения компонента [создайте кластер Apache Airflow™](create-cluster.md).