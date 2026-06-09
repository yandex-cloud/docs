# Создать сканирование {{ dspm-name }}

{% note info %}

Функциональность находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

[Модуль контроля данных](../../concepts/dspm.md) ({{ dspm-full-name }}) находит чувствительную информацию в хранилищах с помощью сканирования [источников данных](../../concepts/dspm.md#data-source) — [бакетов](../../../storage/concepts/bucket.md) {{ objstorage-full-name }} и [Яндекс Дисков]({{ link-yandex }}/support/yandex-360/business/disk/web/{{ lang }}/index.html) в {{ yandex-360 }}.

## Перед началом работы {#before-begin}

Прежде чем начать работать с модулем {{ dspm-name }}, настройте [окружение](../../concepts/workspace.md) и задайте каталог по умолчанию для хранения данных модуля [Контроль данных](../../concepts/dspm.md) ({{ dspm-name }}):

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#console}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![database-magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**.
  1. Если открылось окно настройки {{ sd-name }}, значит, каталог хранения данных модуля DSPM не настроен. В блоке **{{ ui-key.yacloud_org.security-center.onboarding.label_select-default-folder }}** выберите каталог, в котором по умолчанию будут сохраняться данные модуля, и внизу страницы нажмите **{{ ui-key.yacloud.common.save }}**.
  1. Если открылся интерфейс модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**, значит, каталог хранения данных модуля уже настроен, и вы можете продолжить работу.

      Вы можете изменить каталог хранения данных модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}**. Для этого перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.settings_wHmWK }}** и в блоке **{{ ui-key.yacloud_org.security-center.settings.general.section_default-storage_label }}** измените выбранный каталог.
  1. Активируйте модуль {{ dspm-name }} в текущем окружении. Для этого справа сверху нажмите кнопку ![wrench](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud_org.security.dspm.DiscoveryPageLayout.header_button_text_hefvE }}**.

      В открывшемся окне на вкладке **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabStandards_wSeaW }}** в блоке **{{ ui-key.yacloud_org.security.workspaces.title_security-modules_8MdQg }}** выберите модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** и нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  
      Если у вас еще нет окружения, [создайте](../workspaces/create.md) его, активировав модуль **{{ ui-key.yacloud_org.security.workspaces.module_dspm_xxxxx }}** при создании.

{% endlist %}

## Создать сканирование для {{ objstorage-name }} {#object-storage}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#console}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scan-jobs }}**.
  1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud_org.dspm.scans.label_new-scan }}**.
  1. В блоке **{{ ui-key.yacloud_org.dspm.scan-jobs.field_data-sources }}** выберите нужный источник данных с бакетами [{{ objstorage-name }}](../../../storage/index.md).

      При необходимости [создайте](create-data-source.md) новый источник данных.
      
      {% note info %}

      Если доступ бакету контролируется [политикой](../../../storage/security/policy.md#conditional-writes-policy), разрешите доступ к IP-адресам {{ sd-name }} в настройках политики бакета. Список адресов см. в разделе [Диапазоны публичных IP-адресов](../../../overview/concepts/public-ips.md#security-deck-ips).

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud_org.dspm.scans.section_access_title }}** выберите [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться сканирование. При необходимости нажмите **{{ ui-key.yacloud_components.security.dspm.dialog_select-service-account_create-new-action }}**, чтобы создать новый сервисный аккаунт.

      {% note warning %}
      
      Для выполнения сканирования сервисному аккаунту должна быть [назначена](../../../iam/operations/sa/assign-role-for-sa.md) [роль](../../security/dspm-roles.md#dspm-worker) `dspm.worker` на все сканируемые бакеты. Если бакеты [зашифрованы](../../../storage/concepts/encryption.md), сервисному аккаунту также необходима [роль](../../../kms/security/index.md#kms-keys-decrypter) `kms.keys.decrypter` на соответствующие [ключи шифрования](../../../kms/concepts/key.md) {{ kms-full-name }}.
      
      {% endnote %}

  1. В блоке **{{ ui-key.yacloud_org.dspm.scans.section_search-categories_title }}** отдельно для текста и для изображений выберите [категории данных](../../concepts/dspm.md#data-source), которые необходимо искать при сканировании:

      * **{{ ui-key.yacloud_components.security.dspm.card_title_text }}**:
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}` — ФИО, адреса электронной почты, номера телефонов, СНИЛС.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}` — данные банковских карт.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_secrets_4CdGy }}` — облачные ключи доступа, пароли, токены, SSH-ключи и т. п.
      * **{{ ui-key.yacloud_components.security.dspm.card_title_image }}**:
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}` — ФИО, адреса электронной почты, номера телефонов, СНИЛС.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}` — данные банковских карт.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_medical-data-images_7EQ2X }}` — данные медицинских документов и снимков.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_other_wUrAZ }}` — данные личных документов: военных билетов, пенсионных удостоверений, документов об образовании и т.п.

      Вы можете выбрать все доступные категории одновременно и любую их комбинацию.

  1. В блоке **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_title }}**:
     
     1. Выберите **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_method_label }}**:
        * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_full }}** — в источнике сканируются все объекты поддерживаемых типов. Этот метод гарантирует высокую точность обнаружения чувствительных данных.
        * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_partial }}** — выборочно сканируется только часть данных. Точность обнаружения чувствительных данных этого метода ниже, подходит для обработки больших объемов данных.
     
     1. В поле **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_label }}** выберите подходящую периодичность создаваемого сканирования: `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_single }}`, `Каждые 7 дней`, `Каждые 30 дней`, `Каждые 90 дней` или задайте свою периодичность, выбрав `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_custom }}`.
     1. В поле **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_job-name_label }}** задайте имя, по которому вы сможете находить создаваемое сканирование. Требования к имени:
     
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
  1. Нажмите **{{ ui-key.yacloud_org.security.dspm.ScanForm.action_create-scan_dvakP }}**.

  В результате в списке сканирований появится вновь созданное сканирование, которое вы сможете запускать.

{% endlist %}


## Создать сканирование для {{ yandex-360 }} {#yandex-360}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#console}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scan-jobs }}**.
  1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud_org.dspm.scans.label_new-scan }}**.
  1. В блоке **{{ ui-key.yacloud_org.dspm.scan-jobs.field_data-sources }}** выберите нужный источник данных с ресурсами [{{ yandex-360 }}]({{ link-yandex }}/support/yandex-360/business/admin/{{ lang }}/).

      При необходимости [создайте](create-data-source.md) новый источник данных.

  1. В блоке **{{ ui-key.yacloud_org.dspm.scans.section_search-categories_title }}** отдельно для текста и для изображений выберите [категории данных](../../concepts/dspm.md#data-source), которые необходимо искать при сканировании:

      * **{{ ui-key.yacloud_components.security.dspm.card_title_text }}**:
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}` — ФИО, адреса электронной почты, номера телефонов, СНИЛС.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}` — данные банковских карт.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_secrets_4CdGy }}` — облачные ключи доступа, пароли, токены, SSH-ключи и т. п.
      * **{{ ui-key.yacloud_components.security.dspm.card_title_image }}**:
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_personal-data_w5gVm }}` — ФИО, адреса электронной почты, номера телефонов, СНИЛС.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_financial-data_kTC5e }}` — данные банковских карт.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_medical-data-images_7EQ2X }}` — данные медицинских документов и снимков.
        * `{{ ui-key.yacloud_org.security.dspm.infoTypes.value_other_wUrAZ }}` — данные личных документов: военных билетов, пенсионных удостоверений, документов об образовании и т.п.

      Вы можете выбрать все доступные категории одновременно и любую их комбинацию.

  1. В блоке **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_title }}**:
     
     1. Выберите **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_method_label }}**:
        * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_full }}** — в источнике сканируются все объекты поддерживаемых типов. Этот метод гарантирует высокую точность обнаружения чувствительных данных.
        * **{{ ui-key.yacloud_org.dspm.scans.section.scan-method_title_partial }}** — выборочно сканируется только часть данных. Точность обнаружения чувствительных данных этого метода ниже, подходит для обработки больших объемов данных.
     
     1. В поле **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_label }}** выберите подходящую периодичность создаваемого сканирования: `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_single }}`, `Каждые 7 дней`, `Каждые 30 дней`, `Каждые 90 дней` или задайте свою периодичность, выбрав `{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_schedule_custom }}`.
     1. В поле **{{ ui-key.yacloud_org.dspm.scans.section_scan-settings_job-name_label }}** задайте имя, по которому вы сможете находить создаваемое сканирование. Требования к имени:
     
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.
  1. Нажмите **{{ ui-key.yacloud_org.security.dspm.ScanForm.action_create-scan_dvakP }}**.

  В результате в списке сканирований появится вновь созданное сканирование, которое вы сможете запускать.

{% endlist %}


#### См. также {#see-also}

* [{#T}](create-data-source.md)
* [{#T}](../../concepts/dspm.md)
* [{#T}](../../security/index.md)