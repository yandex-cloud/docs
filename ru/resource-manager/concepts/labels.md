# Метки ресурсов сервисов


Большая часть сервисов {{ yandex-cloud }} поддерживает использование меток для маркировки ресурсов.

_Метка_ — это пара ключ-значение в формате `<имя_метки>=<значение_метки>`. Вы можете использовать метки для разделения ресурсов на логические группы.

На метку накладываются следующие ограничения:

* Максимальное количество меток на один ресурс: 64.
* Для ключа:
   * Длина — от 1 до 63 символов.
   * Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.
   * Первый символ — буква.
* Для значения:
   * Длина — до 63 символов.
   * Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.

## Примеры использования меток {#examples}

* [Просмотр детализации использования сервисов по меткам](../../billing/operations/check-charges.md#labels_1).

    Например, можно [посмотреть детализацию расходов {{ ml-platform-name }}](../../datasphere/operations/community/billing-details.md).
  
* Поиск ресурсов, принадлежащих одному проекту, владельцу, окружению и т. д.

    Например, с помощью метки `project:app` можно найти ресурсы {{ yandex-cloud }}, которые используются в проекте `app`.

* Группирование ресурсов по различным критериям: проекту, команде, среде, приложению и т. д. 

    Например, с помощью меток `environment:production` и `environment:test` можно обозначить принадлежность ресурсов {{ yandex-cloud }} к производственной и тестовой среде.

* Автоматизация выполнения действий с группой ресурсов: запуск, остановка или удаление маркированных ресурсов.
  
    Например, можно [управлять группой ресурсов с помощью функции {{ sf-full-name }}](../../tutorials/infrastructure-management/serverless-trigger-budget-vm.md).

## Сервисы, в которых поддержаны метки {#services}

Список сервисов, ресурсы которых поддерживают использование меток:
* [{{ api-gw-full-name }}](../../api-gateway/index.yaml)
* [{{ alb-full-name }}](../../application-load-balancer/index.yaml)
* [{{ certificate-manager-full-name }}](../../certificate-manager/index.yaml)
* [{{ dns-full-name }}](../../dns/index.yaml)
* [{{ sf-full-name }}](../../functions/index.yaml)
* [{{ cloud-logging-full-name }}](../../logging/index.yaml)
* [{{ compute-full-name }}](../../compute/index.yaml)
* [{{ container-registry-full-name }}](../../container-registry/index.yaml)
* [{{ dataproc-full-name }}](../../data-proc/index.yaml)
* [{{ ml-platform-full-name }}](../../datasphere/index.yaml)
* [{{ iot-full-name }}](../../iot-core/index.yaml)
* [{{ kms-full-name }}](../../kms/index.yaml)
* [{{ lockbox-full-name }}](../../lockbox/index.yaml)
* [{{ mkf-full-name }}](../../managed-kafka/index.yaml)
* [{{ mch-full-name }}](../../managed-clickhouse/index.yaml)
* [{{ mgp-full-name }}](../../managed-greenplum/index.yaml)
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml)
* [{{ mmg-full-name }}](../../managed-mongodb/index.yaml)
* [{{ mmy-full-name }}](../../managed-mysql/index.yaml)
* [{{ mpg-full-name }}](../../managed-postgresql/index.yaml)
* [{{ mrd-full-name }}](../../managed-redis/index.yaml)
* [{{ ydb-full-name }}](../../ydb/index.yaml)
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/index.yaml)
* [{{ objstorage-full-name }}](../../storage/index.yaml)
* [{{ resmgr-full-name }}](../../resource-manager/index.yaml)
* [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)
* [{{ vpc-full-name }}](../../vpc/index.yaml)

#### См. также {#see-also}

* [Управление метками](../operations/manage-labels.md)
* [Управление метками в сообществах {{ ml-platform-full-name }}](../../datasphere/operations/community/manage-community-labels.md)
* [Управление метками в проектах {{ ml-platform-full-name }}](../../datasphere/operations/projects/manage-project-labels.md)


{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}