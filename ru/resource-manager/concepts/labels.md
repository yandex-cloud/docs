# Метки ресурсов сервисов

Большая часть сервисов {{ yandex-cloud }} поддерживает использование меток для маркировки ресурсов.

_Метка_ — это пара ключ-значение в формате `<имя метки>=<значение метки>`. Вы можете использовать метки для логического разделения ресурсов.

На метку накладываются следующие ограничения:

* Максимальное количество меток на один ресурс: 64.
* Для ключа:
   * Длина — от 1 до 63 символов.
   * Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.
   * Первый символ — буква.
* Для значения:
   * Длина — до 63 символов.
   * Может содержать строчные буквы латинского алфавита, цифры, дефисы и нижние подчеркивания.

## Сервисы, в которых поддержаны метки {#services}

Список сервисов, ресурсы которых поддерживают использование меток:
* [{{ api-gw-full-name }}](../../api-gateway/)
* [{{ alb-full-name }}](../../application-load-balancer/)
* [{{ certificate-manager-full-name }}](../../certificate-manager/)
* [{{ dns-full-name }}](../../dns/)
{% if product == "yandex-cloud" %}* [{{ sf-full-name }}](../../functions/){% endif %}
{% if product == "yandex-cloud" %}* [{{ cloud-logging-full-name }}](../../logging/){% endif %}
* [{{ compute-full-name }}](../../compute/)
* [{{ container-registry-full-name }}](../../container-registry/)
{% if product == "yandex-cloud" %}* [{{ dataproc-full-name }}](../../data-proc/){% endif %}
{% if product == "yandex-cloud" %}* [{{ iot-full-name }}](../../iot-core/){% endif %}
* [{{ kms-full-name }}](../../kms/)
* [{{ lockbox-full-name }}](../../lockbox/)
* [{{ mkf-full-name }}](../../managed-kafka/)
* [{{ mch-full-name }}](../../managed-clickhouse/)
{% if product == "yandex-cloud" %}* [{{ mes-full-name }}](../../managed-elasticsearch/){% endif %}
{% if product == "yandex-cloud" %}* [{{ mgp-full-name }}](../../managed-greenplum/){% endif %}
* [{{ managed-k8s-full-name }}](../../managed-kubernetes/)
{% if product == "yandex-cloud" %}* [{{ mmg-full-name }}](../../managed-mongodb/){% endif %}
* [{{ mmy-full-name }}](../../managed-mysql/)
* [{{ mpg-full-name }}](../../managed-postgresql/)
{% if product == "yandex-cloud" %}* [{{ mrd-full-name }}](../../managed-redis/){% endif %}
{% if product == "yandex-cloud" %}* [{{ ydb-full-name }}](../../ydb/){% endif %}
* [{{ network-load-balancer-full-name }}](../../network-load-balancer/)
* [{{ resmgr-full-name }}](../../resource-manager/)
* [{{ serverless-containers-full-name }}](../../serverless-containers/)
* [{{ vpc-full-name }}](../../vpc/)

#### См. также {#see-also}

* [Управление метками](../operations/manage-labels.md)

{% if product == "yandex-cloud" %}

{% include [Greenplum trademark](../../_includes/mdb/mgp/trademark.md) %}

{% endif %}