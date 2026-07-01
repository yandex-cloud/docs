---
title: Создание сканирования в {{ dspm-name }}
description: Следуя данной инструкции, вы узнаете как создавать сканирования в модуле {{ dspm-name }} сервиса {{ sd-full-name }}.
---

# Создать сканирование {{ dspm-name }}

[Модуль контроля данных](../../concepts/dspm.md) ({{ dspm-full-name }}) находит чувствительную информацию в хранилищах с помощью сканирования [бакетов](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} и [Яндекс Дисков]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) в {{ yandex-360 }}.


## Перед началом работы {#before-begin}

{% include [dspm-before-begin-section](../../../_includes/security-deck/dspm-before-begin-section.md) %}


## Создать сканирование {#change-scaning}

При активации модуля {{ dspm-name }} автоматически запускается [анализ данных](discovery-mode.md). По результатам анализа для бакетов вы можете создать [непрерывное сканирование изменений](#cloud-sd-v2) в Интерфейсе v2.0.

В Интерфейсе v1.0 можно создать [регулярное сканирование](#cloud-sd-v1) для бакетов и дисков.

{% list tabs group=instructions %}

- Интерфейс v2.0 {#cloud-sd-v2}

  Чтобы создать непрерывное сканирование изменений, создайте область сканирования:
  
  {% include [create-scan-area](../../../_includes/security-deck/dspm-create-scan-area.md) %}

- Интерфейс v1.0 {#cloud-sd-v1}

  Для создания регулярного сканирования нужен [источник данных](../../concepts/dspm.md#data-source). [Создайте](create-data-source.md#create-data-source) его заранее или во время создания сканирования.

  Чтобы создать регулярное сканирование для {{ objstorage-name }} или {{ yandex-360 }}:

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. На странице модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** выберите `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_dspm_xm8pa }}` и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scan-jobs }}**.
  1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud_org.dspm.scans.label_new-scan }}**.
  1. В блоке **{{ ui-key.yacloud_org.dspm.scan-jobs.field_data-sources }}** выберите нужный источник данных: бакет [{{ objstorage-name }}](../../../storage/) или диск [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/).
      
      При необходимости [создайте](./create-data-source.md) новый источник данных.
      
      {% note info %}

      Если доступ к бакету контролируется [политикой](../../../storage/security/policy.md#conditional-writes-policy), разрешите доступ к IP-адресам {{ sd-name }} в настройках политики бакета. Список адресов в разделе [Диапазоны публичных IP-адресов](../../../overview/concepts/public-ips.md#security-deck-ips).

      {% endnote %}

  1. Если в качестве источника используется бакет, то в блоке **{{ ui-key.yacloud_org.dspm.scans.section_access_title }}** выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться сканирование. При необходимости нажмите **{{ ui-key.yacloud_components.security.dspm.dialog_select-service-account_create-new-action }}**, чтобы создать новый сервисный аккаунт.

     {% include [sa-scan-roles-warning](../../../_includes/security-deck/sa-scan-roles-warning.md) %}

  1. В блоке **{{ ui-key.yacloud_org.dspm.scans.section_search-categories_title }}** отдельно для текста и для изображений выберите [категории данных](../../concepts/dspm.md#data-source), которые необходимо искать при сканировании:

      {% include [scan-data-types](../../../_includes/security-deck/scan-data-types.md) %}

      Вы можете выбрать все доступные категории одновременно и любую их комбинацию.

  1. {% include [scan-settings](../../../_includes/security-deck/scan-settings.md) %}
  1. Нажмите **{{ ui-key.yacloud_org.security.dspm.ScanForm.action_create-scan_dvakP }}**.

  В результате в списке сканирований появится созданное сканирование, которое вы сможете запускать.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)
