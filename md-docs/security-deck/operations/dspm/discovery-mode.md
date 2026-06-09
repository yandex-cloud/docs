# Управление анализом данных {{ dspm-name }}

{% note info %}

Функциональность анализа данных находится на [стадии Preview](../../../overview/concepts/launch-stages.md) и в настоящее время не тарифицируется.

После перехода в стадию общего доступа анализ данных будет тарифицироваться отдельно от [сканирований](../../concepts/dspm.md#scanning) источников данных.

{% endnote %}

[Анализ данных](../../concepts/dspm.md#discovery-mode) — это начальный этап работы модуля [Контроль данных](../../concepts/dspm.md) ({{ dspm-name }}). Основная задача анализа — автоматически находить, идентифицировать и каталогизировать ресурсы, где потенциально могут находиться чувствительные данные, в пределах выбранного [окружения](../../concepts/workspace.md).

Результаты анализа данных вы можете [сохранить](#save-results) в локальный файл или [бакет](../../../storage/concepts/bucket.md) {{ objstorage-full-name }}.

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

## Посмотреть результаты анализа {#view-results}

Результаты предварительного анализа ресурсов в окружении доступны в разделе **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** модуля {{ dspm-name }}. Чтобы посмотреть их:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#console}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}**.

      На странице представлена информация о количестве и суммарном объеме файлов, найденных в ресурсах окружения, которые могут потенциально содержать чувствительные данные:

      * Список облаков, каталогов и бакетов, в которых найдены объекты, потенциально содержащие чувствительную информацию.

          Для каждого облака, каталога и бакета указано количество найденных в них файлов и их суммарный объем.
      * Инфографика с информацией о количестве найденных файлов разных типов и их объеме в процентном соотношении.

          Нажмите **{{ ui-key.yacloud_org.security.discovery.more_details_button_aPdgv }}** ![chevrons-up](../../../_assets/console-icons/chevrons-up.svg), чтобы расширить диаграмму и показать более подробную информацию.
  1. При необходимости используйте фильтры, чтобы получить конкретизированные сведения о ресурсах и типах обнаруженных в них файлов:

      * (Опционально) В блоке **{{ ui-key.yacloud_org.security.discovery.header_resource_kDJFW }}** отметьте те ресурсы, по которым вы хотите получить анализ.

          При необходимости воспользуйтесь фильтром **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.searchResource_cGkdQ }}**, чтобы отфильтровать ресурсы по имени облака, каталога или бакета.
      * (Опционально) В блоке **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.buckets_jwots }}** выберите **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.public_2C56E }}**, чтобы отображать в анализе информацию только об объектах, расположенных в бакетах с [публичным доступом](../../../storage/concepts/bucket.md#bucket-access).
      * (Опционально) В блоке **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.mediaTypes_r8ro5 }}** выберите те [MIME-типы](https://ru.wikipedia.org/wiki/Список_MIME-типов) файлов, по которым вы хотите получить анализ:

          * `{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.scannable_jWMD6 }}` — файлы всех поддерживаемых MIME-типов.
          * `Text files` — текстовые файлы c MIME-типами `text/plain`, `application/rtf` и т.п.
          * `Office documents` — файлы документов, таблиц и презентаций c MIME-типами `application/msword`, `application/vnd.ms-excel` и т.п.
          * `PDF documents` — файлы документов c MIME-типом `application/pdf`.
          * `Images` — файлы изображений c MIME-типами `image/bmp`, `image/gif` и т.п.
          * `Email and messages` — файлы сообщений c MIME-типом `message/rfc822`.
          * `Specialized formats` — файлы в специализированных форматах таких как `application/x-x509-cert; format=pem` и т.п.

      Чтобы сбросить установленные фильтры, нажмите кнопку ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.common.reset }}**.

{% endlist %}

## Сохранить результаты анализа {#save-results}

Чтобы сохранить результаты предварительного анализа ресурсов окружения в файл или бакет:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#console}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}**.
  1. Нажмите кнопку ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.label_export_s4obE }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите:

      * ![arrow-down-to-line](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.label_download-analytics_8mgG8 }}**, чтобы сохранить результаты анализа в локальный файл.

          В открывшемся окне нажмите **{{ ui-key.yacloud.common.download }}**.

          {% note info %}

          В локальный файл можно сохранить не более 10 000 строк. Чтобы выгрузить большее количество строк, воспользуйтесь экспортом результатов анализа в бакет.

          {% endnote %}

      * ![folder-arrow-up-in](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.label_export-analytics_7ASg9 }}**, чтобы сохранить результаты анализа в бакет {{ objstorage-name }}. В открывшемся окне:

          * В поле **{{ ui-key.yacloud_org.security.dspm.label_field-bucket_3mM6u }}** выберите бакет, в котором будут сохранены результаты.
          * В поле **{{ ui-key.yacloud_org.security.dspm.field_bucket-path_5qRqM }}** задайте [префикс](../../../storage/concepts/object.md#folder) объекта, в который будут сохранены результаты.
          * В поле **{{ ui-key.yacloud_org.security.dspm.field_file-name_kWRPK }}** задайте имя файла, в который будут сохранены результаты. Файлу будет автоматически присвоено расширение `.csv`.
          * В поле **{{ ui-key.yacloud_org.security.dspm.field_service-account_rTeXv }}** выберите сервисный аккаунт, от имени которого будет выполняться экспорт. При этом у вас должно быть право использования выбранного сервисного аккаунта ([роль](../../../iam/security/index.md#iam-serviceAccounts-user) `iam.serviceAccounts.user` или выше), а самому этому сервисному аккаунту должны быть назначены следующие роли:
              * [`storage.uploader`](../../../storage/security/index.md#storage-uploader) на выбранный бакет;
              * [`kms.keys.encrypter`](../../../kms/security/index.md#kms-keys-encrypter) на [ключ шифрования](../../../kms/concepts/key.md), если бакет [зашифрован](../../../storage/concepts/encryption.md).
          * Нажмите кнопку **{{ ui-key.yacloud_org.security.dspm.action_button-export_pMSM8 }}**, чтобы экспортировать результаты анализа в бакет.

              Если у выбранного сервисного аккаунта окажется недостаточно прав для выполнения операции, на вкладке **{{ ui-key.yacloud_org.security.dspm.tab_issues_title_hLQN2 }}** отобразится информация об этом.

              Разверните блок с информацией об отсутствующих ролях, выберите сервисный аккаунт и нажмите ![list-check](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud_org.security.dspm.ScanForm.table_action_assign_roles_bw4am }}**, чтобы предоставить этому сервисному аккаунту недостающие права. Затем повторно нажмите кнопку **{{ ui-key.yacloud_org.security.dspm.action_button-export_pMSM8 }}**.

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../concepts/dspm.md)
* [{#T}](../../concepts/workspace.md)
* [{#T}](create-data-source.md)
* [{#T}](create-scan.md)