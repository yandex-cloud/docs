---
title: Управлять результатами сканирования в {{ dspm-name }}
description: Следуя данной инструкции, вы узнаете об операциях, которые можно выполнить с результатами сканирования в модуле {{ dspm-name }} сервиса {{ sd-full-name }}.
---

# Управлять результатами сканирования в {{ dspm-name }}

После завершения [сканирования](../../concepts/dspm.md#scanning) доступны следующие операции с его результатами:

* [просмотр](#view);
* [скачивание](#download);
* [экспорт](#export);
* [просмотр ошибок](#errors);
* [удаление](#delete).

## Посмотреть результаты сканирования {#view}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}**.
  1. Выберите сканирование.
  1. На вкладке **{{ ui-key.yacloud_org.security-center.dspm.scan_results-title }}** отобразятся чувствительные данные, если они были найдены при сканировании. Информация о каждом найденном объекте представлена в следующих столбцах:

     * `{{ ui-key.yacloud_org.dspm.scan.label_data-type }}` — категория поиска, к которой принадлежат данные. Например, `FULL-NAME-RU-ML` — полное имя.
     * `{{ ui-key.yacloud_org.dspm.scan.label_found-occurrence }}` — чувствительные данные, которые удалось найти.
     * `{{ ui-key.yacloud_org.dspm.scan.scan-issue_data-source }}` — имя источника данных;
     * `{{ ui-key.yacloud_org.dspm.scan.results_resource-name }}` — имя ресурса, в котором были найдены данные;
     * `{{ ui-key.yacloud_org.dspm.scan.scan-issue_object-path }}` — путь до файла, в котором были найдены данные.

{% endlist %}

## Скачать результаты сканирования {#download}

При скачивании CSV-файл с результатами сканирования сохраняется локально на вашем компьютере.

{% note info %}

Файл может содержать не более 10 000 записей о найденных чувствительных данных. Для выгрузки большего числа записей используйте [экспорт](#export) в {{ objstorage-name }}.

{% endnote %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}**.
  1. Справа от сканирования нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.dspm.scan.action_download-results }}**.

     Вы также можете перейти на страницу сканирования, нажать **{{ ui-key.yacloud_org.common.more }}** ![image](../../../_assets/console-icons/chevron-down.svg) и выбрать ![image](../../../_assets/console-icons/arrow-shape-down-to-line.svg) **{{ ui-key.yacloud_org.dspm.scan.action_download-results }}**.

  1. В поле **{{ ui-key.yacloud_org.dspm.scan.header_scan-result_sensitive-data }}** укажите, как отображать имена, контактные данные и другую личную информацию.
  1. Нажмите **{{ ui-key.yacloud_org.dspm.scan.action_button_apply }}**.

{% endlist %}

## Экспортировать результаты сканирования {#export}

При экспорте файл с результатами сканирования сохраняется в выбранный бакет.

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}**.
  1. Справа от сканирования нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud_org.dspm.scan.action_export-results }}**.

     Вы также можете перейти на страницу сканирования, нажать **{{ ui-key.yacloud_org.common.more }}** ![image](../../../_assets/console-icons/chevron-down.svg) и выбрать ![image](../../../_assets/console-icons/folder-arrow-up-in.svg) **{{ ui-key.yacloud_org.dspm.scan.action_export-results }}**.

  1. В открывшемся окне задайте настройки экспорта:
  
     * В поле **{{ ui-key.yacloud_org.security.dspm.label_field-bucket_3mM6u }}** выберите бакет, в котором будут сохранены результаты.
     * В поле **{{ ui-key.yacloud_org.security.dspm.field_bucket-path_5qRqM }}** задайте [префикс](../../../storage/concepts/object.md#folder) объекта, в который будут сохранены результаты.
     * В поле **{{ ui-key.yacloud_org.security.dspm.field_file-name_kWRPK }}** задайте имя файла, в который будут сохранены результаты. Файлу будет автоматически присвоено расширение `.csv`.
     * В поле **{{ ui-key.yacloud_org.security.dspm.field_service-account_rTeXv }}** выберите сервисный аккаунт, которому назначены [роли](../../../iam/concepts/access-control/roles.md) `storage.uploader` на выбранный бакет и `kms.keys.encrypter` на [ключ шифрования](../../../kms/concepts/key.md), если бакет [зашифрован](../../../storage/concepts/encryption.md).
     * Нажмите кнопку **{{ ui-key.yacloud_org.dspm.scan.action_button_export }}**, чтобы экспортировать результаты с проверкой параметров.

       Если у выбранного сервисного аккаунта окажется недостаточно прав для выполнения операции, на вкладке **{{ ui-key.yacloud_org.security.dspm.tab_issues_title_hLQN2 }}** отобразится информация об этом.

       Разверните блок с информацией об отсутствующих ролях, выберите сервисный аккаунт и нажмите ![list-check](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud_org.security.dspm.ScanForm.table_action_assign_roles_bw4am }}**, чтобы предоставить этому сервисному аккаунту недостающие права. Затем повторно нажмите кнопку **{{ ui-key.yacloud_org.dspm.scan.action_button_export }}**.

     Вы также можете экспортировать результаты без проверки параметров, нажав кнопку **{{ ui-key.yacloud_org.security.dspm.ScanExportDialog.action_button_export_without_validation_pFWLZ }}**. Если у выбранного сервисного аккаунта окажется недостаточно прав для выполнения операции, вы увидите ошибку.

{% endlist %}

## Посмотреть ошибки сканирования {#errors}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}**.
  1. Выберите сканирование и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.scan-issues-title }}**.

  Подробнее про ошибки сканирования см. на странице [{#T}](../../diagnostics/dspm-diagnostics.md).

{% endlist %}

## Удалить результаты сканирования {#delete}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![Database-Magnifier](../../../_assets/console-icons/database-magnifier.svg) **{{ ui-key.yacloud_org.security-center.label_dspm }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security-center.dspm.title_scans }}**.
  1. Справа от сканирования нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

     Вы также можете перейти на страницу сканирования, нажать **{{ ui-key.yacloud_org.common.more }}** ![image](../../../_assets/console-icons/chevron-down.svg) и выбрать ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

  1. В открывшемся окне подтвердите удаление.

{% endlist %}