# Способы работы с кластерами Apache Spark™ в {{ ml-platform-name }}

Сервис [{{ dataproc-full-name }}](../../data-proc/) позволяет разворачивать кластеры Apache Spark™. Вы можете использовать кластеры {{ dataproc-name }}, чтобы запускать распределенные обучения на кластерах.

## Варианты развертывания кластеров {#types}

Чтобы работать в {{ ml-platform-name }} с кластерами {{ dataproc-name }}, вы можете использовать:

* [коннектор Spark](data-proc-operations.md#spark-with-existing-cluster);
* [Livy-сессию](data-proc-operations.md#livy-sessions).

Если у вас нет существующих кластеров {{ dataproc-name }} или кластер нужен на непродолжительное время, вы можете использовать временные кластеры {{ dataproc-name }}. Их можно создать с помощью:

* [коннектора Spark](temporary-data-proc-clusters.md#spark-with-temporary-cluster) (предпочтительный способ);
* [шаблона {{ dataproc-name }}](temporary-data-proc-clusters.md#template).

Все кластеры {{ dataproc-name }} вне зависимости от варианта развертывания тарифицируются по [правилам сервиса {{ dataproc-name }}](../../data-proc/pricing.md).

## Настройки проекта {{ ml-platform-name }} для работы с кластерами {{ dataproc-name }} {#settings}

{% include [preferences](../../_includes/datasphere/settings-for-dataproc.md) %}

#### См. также {#see-also}

* [{#T}](data-proc-template.md)
* [{#T}](../tutorials/data-proc-integration.md)
* [{#T}](spark-connector.md)
