---
title: Создание источника данных в {{ dspm-name }}
description: Следуя данной инструкции, вы узнаете, как из бакетов {{ objstorage-full-name }} и дисков в {{ yandex-360 }} создавать источники данных в модуле {{ dspm-name }} сервиса {{ sd-full-name }}.
---

# Создать источник данных {{ dspm-name }}

[Источник данных](../../concepts/dspm.md#data-source) содержит информацию о хранилищах, в которых будет выполняться сканирование, а также дополнительные настройки. В качестве хранилищ доступны [бакеты](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} и [Яндекс Дисков]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) в {{ yandex-360 }}. В одном источнике данных нельзя одновременно использовать хранилища [{{ objstorage-name }}](../../../storage/) и [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/).

Прежде чем начать работать с {{ dspm-name }}, [настройте](../../quickstart-overview.md#configure-sd) каталог по умолчанию для хранения данных сервиса {{ sd-name }}.


## Создать источник данных для {{ objstorage-name }} {#object-storage}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_data-sources }}**.
  1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud_org.dspm.data-sources.label_create-source }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![storage-logo](../../../_assets/storage/storage-logo.svg) **{{ ui-key.yacloud_org.security.dspm.dataSourceTypes.object_storage_meF3x }}**.
  1. Добавьте к источнику данных ресурсы, в которых вы хотите выполнять сканирование:
      * Чтобы добавить отдельные бакеты, нажмите ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.dspm.scan-resource-group.button_select_bucket }}** и выберите один или несколько бакетов в одном или нескольких доступных вам каталогах.

          При необходимости используйте фильтры по настройкам доступа (`{{ ui-key.yacloud_org.storage.value_private-bucket }}` или `{{ ui-key.yacloud_org.storage.value_public-bucket }}`) и по имени бакета.

      * Чтобы добавить к источнику данных [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder), нажмите ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.dspm.scan-resource-group.button_select_cloud_catalog }}** и выберите сразу все или некоторые из доступных вам облаков и/или каталогов.

          После выбора облаков и каталогов в блоке **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_include_in_scan }}** выберите, какие бакеты нужно сканировать:

          * **{{ ui-key.yacloud_org.dspm.scan-resource-group.title_all_buckets }}**
             К источнику данных будут добавлены все бакеты, имеющиеся в выбранных облаках и каталогах. При этом в сканирование попадут не только те бакеты, которые существуют в выбранных облаках и каталогах в момент создания источника данных, но и бакеты, которые появятся в них к моменту запуска сканирования в будущем.
          * **{{ ui-key.yacloud_org.dspm.scan-resource-group.public_buckets }}**
             К источнику данных будут добавлены бакеты с настроенным [публичным доступом](../../../storage/operations/buckets/bucket-availability.md). Сканироваться на наличие персональных данных будет содержимое только таких бакетов. Если для этих бакетов отключить публичный доступ, они автоматически исключаются из сканирования.

  1. В блоке **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_include_files }}** задайте одну или несколько областей сканирования:

      {% include [datasource-filetypes](../../../_includes/security-deck/datasource-filetypes.md) %}

  1. Если вы хотите добавить к этому же источнику данных ресурсы с другими параметрами выборки областей сканирования, нажмите **{{ ui-key.yacloud_org.dspm.data-sources.action_add_resources }}** и в появившемся блоке повторно выполните шаги `4` и `5`.

      К одному источнику данных можно добавить любое количество групп ресурсов для сканирования.

  1. {% include [source-info](../../../_includes/security-deck/source-info.md) %}
  1. Нажмите **{{ ui-key.yacloud_org.dspm.data-sources.action_create-source }}**.

  В результате в списке источников данных появится вновь созданный источник, который вы сможете выбирать при [создании сканирования](./create-scan.md).

{% endlist %}


## Создать источник данных для {{ yandex-360 }} {#yandex-360}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_data-sources }}**.
  1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud_org.dspm.data-sources.label_create-source }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![storage-logo](../../../_assets/security-deck/yandex360-logo.svg) **{{ ui-key.yacloud_org.security.dspm.dataSourceTypes.yandex_360_1TUsr }}**.
  1. Нажмите **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.action_configure-connection_v6Gjm }}** и задайте параметры для корректной работы с организацией {{ yandex-360 }}:
      1. Укажите идентификатор [Организации 360]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/org-admin).

          Получить идентификатор можно в [профиле компании](https://admin.yandex.ru/company-profile) в аккаунте администратора организации.

      1. Введите [OAuth-токен]({{ ya-oauth-url }}/authorize?response_type=token&client_id=c0e37287a72a43658011f68ef6e70def).
      1. (Опционально) Чтобы обеспечить доступ к пользовательским ресурсам, например для сканирования пользовательских дисков, [создайте]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/security-service-applications) сервисное приложение и укажите параметры:
          * **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.field_client_id_iVUvK }}**
          * **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.field_client_secret_pcFGg }}**

          {% note info %}

          Функциональность недоступна для [тарифа]({{ link-yandex }}/support/yandex-360/business/purchase/{{ lang }}/plans/payment-plans-ru) {{ yandex-360 }} Минимальный.

          {% endnote %}

      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  1. Добавьте к источнику данных ресурсы, в которых вы хотите выполнять сканирование:
      * Чтобы добавить общие диски в организации, в разделе **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.section_organization_resources_title_5u8qX }}** нажмите **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.action_add_resources_2qrRH }}**. Выберите или исключите нужные диски в одном или нескольких каталогах.
      * Чтобы добавить к источнику данных пользовательские диски, в разделе **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.section_user_resources_title_aN75p }}** нажмите **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.action_add_resources_2qrRH }}**. Выберите или исключите нужные пользовательские диски.
      * Чтобы добавить к источнику данных все доступные диски, нажмите **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.label_all_disks_5KEY9 }}** в разделе **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.section_organization_resources_title_5u8qX }}** или **{{ ui-key.yacloud_org.security.dspm.Yandex360DataSourceForm.section_user_resources_title_aN75p }}**. На сканирование попадут не только те диски, которые существуют в выбранной организации в момент создания источника данных, но и диски, которые появятся в ней позднее (на момент выполнения сканирования).

  1. В блоке **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_include_files }}** задайте одну или несколько областей сканирования:

      {% include [datasource-filetypes](../../../_includes/security-deck/datasource-filetypes.md) %}

  1. Если вы хотите добавить к этому же источнику данных ресурсы с другими параметрами выборки областей сканирования, нажмите **{{ ui-key.yacloud_org.dspm.data-sources.action_add_resources }}** и в появившемся блоке повторно выполните шаги `6` и `7`.

      К одному источнику данных можно добавить любое количество групп ресурсов для сканирования.

  1. {% include [source-info](../../../_includes/security-deck/source-info.md) %}
  1. Нажмите **{{ ui-key.yacloud_org.dspm.data-sources.action_create-source }}**.

  В результате в списке источников данных появится вновь созданный источник, который вы сможете выбирать при [создании сканирования](./create-scan.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](./create-scan.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)