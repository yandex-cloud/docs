# Создание реестра схем для поставки данных в формате Debezium CDC из {{ KF }}


В этом практическом руководстве вы сможете создать реестр схем, чтобы отслеживать эволюцию схем для источника {{ KF }} с помощью сервиса [{{ data-transfer-full-name }}](../../../data-transfer).


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы будете работать с реестром схем.
  1. Выберите сервис **{{ metadata-hub-full-name }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/layout-cells.svg) **{{ schema-registry-name }}** / **Пространство имён**.
  1. Нажмите кнопку **Создать пространство имён**. 
  1. Укажите [настройки пространства имен](../../../metadata-hub/operations/create-name-space.md). После сохранения пространства имен, вы сможете использовать его идентификатор для получения _URL Schema Registry_: `{namespace_id}.{{ schema-registry-endpoint }}`.
  1. В [консоли управления]({{ link-console-main }}) перейдите в сервис **{{ data-transfer-full-name }}**. 
  1. Настройте эндпоинт [{{ KF }}](../../../data-transfer/operations/endpoint/source/kafka.md). 
  1. Примените полученный _URL Schema Registry_ в настройках **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.format.title }}** для **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_debezium_cdc.title }}**.
  1. [Создайте и запустите](../../../data-transfer/operations/transfer.md) трансфер данных.

{% endlist %}

