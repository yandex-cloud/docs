---
title: Управление анализом данных в {{ sd-full-name }}
description: Следуя данной инструкции, вы узнаете о работе с анализом данных в модуле {{ dspm-name }} сервиса {{ sd-full-name }}.
---

# Управление анализом данных {{ dspm-name }}

{% include [analysis-preview-mode](../../../_includes/security-deck/analysis-preview-mode.md) %}

[Анализ данных](../../concepts/dspm.md#discovery-mode) — это начальный этап работы модуля [Контроль данных](../../concepts/dspm.md) ({{ dspm-name }}). Модуль находит, идентифицирует и каталогизирует все бакеты {{ objstorage-short-name }} в пределах выбранного [окружения](../../concepts/workspace.md).

Анализ запускается автоматически после активации модуля {{ dspm-full-name }}.


## Перед началом работы {#before-begin}

{% include [dspm-before-begin-section](../../../_includes/security-deck/dspm-before-begin-section.md) %}


## Посмотреть результаты анализа {#view-results}

Результаты предварительного анализа ресурсов в окружении доступны в Интерфейсе v2.0 в разделе **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}** модуля {{ dspm-name }}. Чтобы посмотреть их:

{% list tabs group=instructions %}

- Интерфейс v2.0 {#cloud-sd-v2}

  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. На странице модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** выберите `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_discovery_kkTCM }}` и перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}**.

      На странице представлена информация о количестве и суммарном объеме файлов, найденных в ресурсах окружения, которые могут потенциально содержать чувствительные данные:

      * Список облаков, каталогов и бакетов, в которых найдены объекты, потенциально содержащие чувствительную информацию.

          Для каждого облака, каталога и бакета указано количество найденных в них файлов и их суммарный объем.
      * Инфографика с информацией о количестве найденных файлов разных типов и их объеме в процентном соотношении.

          Нажмите **{{ ui-key.yacloud_org.security.discovery.AnalyticsDashboard.details_button_1ZfAk }}** ![chevrons-up](../../../_assets/console-icons/chevrons-up.svg), чтобы расширить диаграмму и показать более подробную информацию.
  1. При необходимости используйте фильтры, чтобы получить конкретизированные сведения о ресурсах и типах обнаруженных в них файлов:

      * (Опционально) В блоке **{{ ui-key.yacloud_org.security.discovery.header_resource_kDJFW }}** отметьте те ресурсы, по которым вы хотите получить анализ.

          При необходимости воспользуйтесь фильтром **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.searchResource_cGkdQ }}**, чтобы отфильтровать ресурсы по имени облака, каталога или бакета.
      * (Опционально) В блоке **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.buckets_jwots }}** выберите **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.public_2C56E }}**, чтобы отображать в анализе информацию только об объектах, расположенных в бакетах с [публичным доступом](../../../storage/concepts/bucket.md#bucket-access).
      * (Опционально) В блоке **{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.mediaTypes_r8ro5 }}** выберите те [MIME-типы](https://ru.wikipedia.org/wiki/Список_MIME-типов) файлов, по которым вы хотите получить анализ:

          * `{{ ui-key.yacloud_org.security.dspm.AnalyticsPage.scannable_jWMD6 }}` — файлы всех поддерживаемых MIME-типов.
          * `Документы`:
              * `Текстовые документы` — текстовые файлы c MIME-типами `text/plain`, `application/rtf` и т.п.
              * `Документы текстовых процессоров` — текстовые файлы с MIME-типами `application/macwriteii`, `application/msword` и т.п.
              * `PDF и другие документы для печати` — файлы MIME-типов `application/pdf`, `image/vnd.djvu` и т.п.
              * `Презентации` — файлы презентаций c MIME-типами `application/vnd.apple.keynote`, `application/vnd.ms-powerpoint` и т.п.
              * `Электронные книги` — текстовые файлы с MIME-типами `application/epub+zip`, `application/hwp+zip` и т.п.
          * `Графика и дизайн`:
              * `Растровая графика` — файлы изображений c MIME-типами `image/bmp`, `image/gif` и т.п.
              * `Векторная графика` — файлы изображений c MIME-типами `application/coreldraw`, `image/cgm` и т.п.
              * `3D-модели` — файлы изображений c MIME-типами `image/x-3ds`, `model/e57` и т.п.
          * `Мультимедиа`:
              * `Аудиофайлы` — файлы аудио c MIME-типами `audio/32kadpcm`, `audio/3gpp` и т.п.
              * `Видеофайлы` — файлы видео c MIME-типами `application/mp4`, `application/mpeg4-generic` и т.п.
          * `Код и служебные файлы`:
              * `Исходный код` — файлы кода `application/sieve`, `application/x-bat` и т.п.
              * `Конфигурационные файлы` — конфигурационные файлы c MIME-типами `text/x-config`, `text/x-ini` и т.п.
              * `Сертификаты и ключи` — файлы с секретами MIME-типов `application/pgp-encrypted`, `application/pgp-keys` и т.п.
              * `Исполняемые и бинарные файлы` — служебные файлы c MIME-типами `application/applefile`, `application/java-vm` и т.п.
          * `Наборы данных`:
              * `Структурированные данные` — файлы с данными MIME-типов `application/cbor`, `application/json` и т.п.
              * `Табличные форматы` — файлы таблиц MIME-типов `application/vnd.apple.numbers`, `application/vnd.ms-excel` и т.п.
              * `Файлы баз данных` — файлы баз данных c MIME-типами `application/vnd.lotus-approach`, `application/vnd.oasis.opendocument.base` и т.п.
              * `ГИС` — файлы с MIME-типами `application/vnd.google-earth.kml+xml`, `application/vnd.google-earth.kmz` и т.п.
          * `Архивы и контейнеры`: 
              * `Архивы` — файлы c архивами MIME-типов `application/gzip`, `application/java-archive` и т.п.
              * `Образы дисков` — файлы образов с MIME-типами `application/vnd.msa-disk-image`, `application/x-apple-diskimage` и т.п.
          * `Цифровые коммуникации`:
              * `Веб` — веб-файлы MIME-типов `application/ecmascript`, `text/html` и т.п.
              * `Почта и сообщения` — файлы с MIME-типами `application/activemessage`, `message/cpim` и т.п.
              * `Шрифты` — файлы шрифтов с MIME-типами `application/font-tdpfr`, `application/x-font-bdf` и т.п.
          * `Узкоспециализированные форматы`:
              * `Научные данные` — файлы с научными данными с MIME-типами `application/cellml+xml`, `chemical/x-cdx` и т.п.
          * `Медицинские изображения` — файлы с MIME-типами `application/dicom`.
          * `Прочее` — прочие файлы с MIME-типами. 

      Чтобы сбросить установленные фильтры, нажмите кнопку ![arrow-rotate-left](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.common.reset }}**.

{% endlist %}

После того как анализ данных выявил потенциально опасные ресурсы, нажмите **{{ ui-key.yacloud_org.security.discovery.action_include-in-scan_2wT6B }}**, чтобы [создать](create-scan.md#cloud-sd-v2) для них непрерывное сканирование изменений.


## Сохранить результаты анализа {#save-results}

Чтобы сохранить результаты предварительного анализа ресурсов окружения в файл или бакет:

{% list tabs group=instructions %}

- Интерфейс v2.0 {#cloud-sd-v2}

  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}**.
  1. На странице модуля **{{ ui-key.yacloud_org.security-center.dspm.label_dspm }}** выберите `{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_prefix_iWUEX }}{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_discovery_kkTCM }}` и перейдите на вкладку **{{ ui-key.yacloud_org.security.dspm.DspmPageLayout.title_analytics_vaYT5 }}**.
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


#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/dspm.md)
* [{#T}](../../concepts/workspace.md)
* [{#T}](./create-data-source.md)
* [{#T}](./create-scan.md)