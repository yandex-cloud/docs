---
title: Создание источника данных в {{ dspm-name }}
description: Следуя данной инструкции, вы узнаете, как из бакетов {{ objstorage-full-name }} и дисков в {{ yandex-360 }} создавать источники данных в модуле {{ dspm-name }} сервиса {{ sd-full-name }}.
---

# Подготовить данные для сканирования в {{ dspm-name }}

Чтобы запустилось [непрерывное сканирование изменений](create-scan.md#cloud-sd-v2), создайте [область сканирования](#cloud-sd-v2) в Интерфейсе v2.0.

Перед тем, как [создать](create-scan.md#cloud-sd-v1) регулярное сканирование в {{ dspm-name }}, подготовьте для него [источник данных](#cloud-sd-v1) в Интерфейсе v1.0. Вы также можете сделать это во время создания сканирования.


## Перед началом работы {#before-begin}

{% include [dspm-before-begin-section](../../../_includes/security-deck/dspm-before-begin-section.md) %}


## Создать область сканирования или источник данных {#change-scaning}

{% list tabs group=instructions %}

- Интерфейс v2.0 {#cloud-sd-v2}

  При активации модуля {{ dspm-full-name }} автоматически запускается [анализ данных](discovery-mode.md) в [бакетах](../../../storage/concepts/bucket.md) {{ objstorage-full-name }}. После того как анализ данных выявил потенциально опасные ресурсы, вы можете создать для них область сканирования:
  
  {% include [create-scan-area](../../../_includes/security-deck/dspm-create-scan-area.md) %}

- Интерфейс v1.0 {#cloud-sd-v1}

  [Источник данных](../../concepts/dspm.md#data-source) содержит информацию о хранилищах, в которых будет выполняться сканирование, а также дополнительные настройки. В качестве хранилищ доступны [бакеты](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} и [диски]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) в {{ yandex-360 }}. В одном источнике данных нельзя одновременно использовать хранилища [{{ objstorage-name }}](../../../storage/) и [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/).

  Чтобы создать источник данных для {{ objstorage-name }} и {{ yandex-360 }}:
  
  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. На странице модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** выберите `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_dspm_xm8pa }}` и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_data-sources }}**.
  1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud_org.dspm.data-sources.label_create-source }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите ![storage-logo](../../../_assets/storage/storage-logo.svg) **{{ ui-key.yacloud_org.security.dspm.dataSourceTypes.object_storage_meF3x }}** или ![storage-logo](../../../_assets/security-deck/yandex360-logo.svg) **{{ ui-key.yacloud_org.security.dspm.dataSourceTypes.yandex_360_1TUsr }}**. 
 
      {% list tabs %}

      - {{ ui-key.yacloud_org.security.dspm.dataSourceTypes.object_storage_meF3x }}
          
        Добавьте к источнику данных ресурсы, в которых вы хотите выполнять сканирование:
           * Чтобы добавить отдельные бакеты, нажмите ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.dspm.scan-resource-group.button_select_bucket }}** и выберите один или несколько бакетов в одном или нескольких доступных вам каталогах.

              При необходимости используйте фильтры по настройкам доступа (`{{ ui-key.yacloud.storage.buckets.value_private-bucket }}` или `{{ ui-key.yacloud.storage.buckets.value_public-bucket }}`) и по имени бакета.

           * Чтобы добавить к источнику данных [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталоги](../../../resource-manager/concepts/resources-hierarchy.md#folder), нажмите ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.dspm.scan-resource-group.button_select_cloud_catalog }}** и выберите сразу все или некоторые из доступных вам облаков и/или каталогов.

             После выбора облаков и каталогов в блоке **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_include_in_scan }}** выберите, какие бакеты нужно сканировать:

             * **{{ ui-key.yacloud_org.dspm.scan-resource-group.title_all_buckets }}**
               К источнику данных будут добавлены все бакеты, имеющиеся в выбранных облаках и каталогах. При этом в сканирование попадут не только те бакеты, которые существуют в выбранных облаках и каталогах в момент создания источника данных, но и бакеты, которые появятся в них к моменту запуска сканирования в будущем.
             * **{{ ui-key.yacloud_org.dspm.scan-resource-group.public_buckets }}**
               К источнику данных будут добавлены бакеты с настроенным [публичным доступом](../../../storage/operations/buckets/bucket-availability.md). Сканироваться на наличие персональных данных будет содержимое только таких бакетов. Если для этих бакетов отключить публичный доступ, они автоматически исключаются из сканирования.

      - {{ ui-key.yacloud_org.security.dspm.dataSourceTypes.yandex_360_1TUsr }}        
        
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

      {% endlist %}

  1. В блоке **{{ ui-key.yacloud_org.dspm.scan-resource-group.label_include_files }}** задайте одну или несколько областей сканирования:

      {% include [datasource-filetypes](../../../_includes/security-deck/datasource-filetypes.md) %}

  1. Если вы хотите добавить к этому же источнику данных ресурсы с другими параметрами выборки областей сканирования, нажмите **{{ ui-key.yacloud_org.dspm.data-sources.action_add_resources }}** и в появившемся блоке повторно выполните шаги `6` и `7`.

      К одному источнику данных можно добавить любое количество групп ресурсов для сканирования.

  1. {% include [source-info](../../../_includes/security-deck/source-info.md) %}
  1. Нажмите **{{ ui-key.yacloud_org.dspm.data-sources.action_create-source }}**.

  В результате в списке источников данных появится вновь созданный источник, который вы сможете выбирать при [создании сканирования](create-scan.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](./create-scan.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)