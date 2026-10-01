[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > [Пошаговые инструкции](../index.md) > Оркестрация данных > Managed Service for Apache Airflow™ > Отключить Managed Service for Apache Airflow™

# Отключить Managed Service for Apache Airflow™

Компонент [Managed Service for Apache Airflow™](../../concepts/components/airflow.md) отключает администратор установки. Перед отключением удалите все ресурсы `AirflowCluster` и дождитесь завершения их удаления.

{% note warning %}

Не отключайте компонент, пока существуют `AirflowCluster`, в том числе находящиеся в состоянии `Deleting`.

{% endnote %}

## Через CLI {#disable}

1. Найдите все кластеры:

    ```bash
    kubectl get airflowcluster --all-namespaces
    ```

1. Удалите каждый кластер по инструкции [Удалить кластер Apache Airflow™](delete-cluster.md) и дождитесь завершения очистки.

1. Отключите компонент:

    ```bash
    kubectl patch managedairflowconfig main \
      --type=merge \
      -p '{"spec":{"enabled":false}}'
    ```

1. Следите за удалением установки:

    ```bash
    kubectl get componentinstallation managed-airflow-main -w
    ```

После успешного отключения ресурс `ComponentInstallation managed-airflow-main` будет удален.