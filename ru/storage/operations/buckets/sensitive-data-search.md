---
title: Поиск чувствительных данных в бакете {{ objstorage-name }}
description: Следуя данной инструкции, вы узнаете, как создавать сканирование бакета и работать с результатами сканирования в {{ objstorage-full-name }}.
---

# Поиск чувствительных данных в бакете

{% include [note-preview](../../../_includes/note-preview.md) %}

[Модуль контроля данных](../../../security-deck/concepts/dspm.md) ({{ dspm-full-name }}) находит [чувствительную информацию](../../concepts/sensitive-data-search.md) в хранилищах с помощью сканирования [бакетов](../../../storage/concepts/bucket.md). Вы можете создавать сканирование бакетов и работать с результатами сканирования в сервисе {{ objstorage-name }} через [консоль управления]({{ link-console-main }}).


## Перед началом работы {#before-begin}

Убедитесь, что [сервисному аккаунту](../../../iam/concepts/service-control.md#service-agent), от имени которого выполняется сканирование бакета и работа с результатами сканирования, назначены следующие роли:

* для создания сканирований — [`dspm.editor`](../../../security-deck/security/dspm-roles.md#dspm-editor) и выше;
* для просмотра результатов сканирований со скрытыми данными — [`dspm.admin`](../../../security-deck/security/dspm-roles.md#dspm-admin), с открытыми данными — [`dspm.viewer`](../../../security-deck/security/dspm-roles.md#dspm-viewer) и выше;
* для скачивания результатов сканирований — [`dspm.viewer`](../../../security-deck/security/dspm-roles.md#dspm-viewer) и выше;
* для экспорта результатов — [`dspm.viewer`](../../../security-deck/security/dspm-roles.md#dspm-viewer) и выше, а также права на запись в выбранный бакет у сервисного аккаунта, указанного для экспорта.

## Создать сканирование {#create}

{% note tip %}

Поиск чувствительных данных в интерфейсе {{ objstorage-name }} позволяет сканировать отдельный бакет. Если вам необходимо контролировать данные в нескольких бакетах, на уровне каталога, облака или организации, воспользуйтесь модулем [{{ dspm-name }}](../../../security-deck/concepts/dspm.md) в составе сервиса [{{ sd-full-name }}](../../../security-deck/).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите имя бакета, для которого вы хотите создать сканирование.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Нажмите **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_run_scan_af4cy }}**.

      {% note info %}

      Если доступ к бакету контролируется [политикой](../../security/policy.md#conditional-writes-policy), разрешите доступ к IP-адресам {{ sd-name }} в настройках политики бакета. Список адресов в разделе [Диапазоны публичных IP-адресов](../../../overview/concepts/public-ips.md#security-deck-ips).

      {% endnote %}

  1. В блоке **{{ ui-key.yacloud.storage.Bucket.BucketSecurityScanForm.title_profiles }}** выберите [категории данных](../../../security-deck/concepts/dspm.md#data-source), которые необходимо искать при сканировании. Вы можете выбрать все доступные категории одновременно и любую их комбинацию.

  1. (Опционально) В блоке **{{ ui-key.yacloud.storage.Bucket.BucketSecurityScanForm.title_file-filter }}** укажите [ключи объектов](*bucket-object-key) и [префиксы](*bucket-object-prefix), которые нужно включить в сканирование. По умолчанию сканируются все поддерживаемые форматы файлов.

      {% note info %}

      В настоящий момент не сканируются объекты, зашифрованные [ключом {{ kms-short-name }}](../../../kms/concepts/key.md).

      {% endnote %}

  1. Нажмите **{{ ui-key.yacloud.storage.Bucket.BucketSecurityScanForm.button_submit }}**.

  Сканирование запустится автоматически. Чтобы повторить сканирование, нажмите **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_repeat_scan_fN7pL }}**.

{% endlist %}


## Посмотреть результаты сканирования {#view}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя нужного бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. На вкладке **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.sub_tab_results }}** отобразятся чувствительные данные, если они были найдены при сканировании. Информация о каждом найденном объекте представлена в следующих столбцах:

      * `{{ ui-key.yacloud_org.dspm.scan.label_data-type }}` — категория поиска, к которой принадлежат данные. Например, `FULL-NAME-RU-ML` — полное имя.
      * `{{ ui-key.yacloud_org.dspm.scan.label_found-occurrence }}` — чувствительные данные, которые удалось найти.
      * `Объект` — путь до файла, в котором были найдены данные.

{% endlist %}


## Скачать результаты сканирования {#download}

{% include [download-scan-intro](../../../_includes/security-deck/download-scan-intro.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя нужного бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Нажмите ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud.shared.layout.PageActions.button_more_sGEBS }}** → **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_download_hR9sN }}**.
  1. В открывшемся окне укажите, как отображать имена, контактные данные и другую личную информацию, и нажмите **{{ ui-key.yacloud_components.security.dspm.action_button_apply }}**.

{% endlist %}


## Экспортировать результаты сканирования {#export}

{% include [export-scan-intro](../../../_includes/security-deck/export-scan-intro.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя нужного бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}**.
  1. Нажмите ![image](../../../_assets/console-icons/chevron-down.svg) **{{ ui-key.yacloud.shared.layout.PageActions.button_more_sGEBS }}** → **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.button_export_gQ8rM }}**.
  1. В открывшемся окне задайте настройки экспорта:

      * В поле **{{ ui-key.yacloud_org.security.dspm.label_field-bucket_3mM6u }}** выберите бакет, в котором будут сохранены результаты.
      * В поле **{{ ui-key.yacloud_org.security.dspm.field_bucket-path_5qRqM }}** задайте [префикс](../../concepts/object.md#folder) объекта, в который будут сохранены результаты.
      * В поле **{{ ui-key.yacloud_org.security.dspm.field_file-name_kWRPK }}** задайте имя файла, в который будут сохранены результаты. Файлу будет автоматически присвоено расширение `.csv`.
      * В поле **{{ ui-key.yacloud_org.security.dspm.field_service-account_rTeXv }}** выберите сервисный аккаунт, которому назначены [роли](../../../iam/concepts/access-control/roles.md) `storage.uploader` на выбранный бакет и `kms.keys.encrypter` на [ключ шифрования](../../../kms/concepts/key.md), если бакет [зашифрован](../../concepts/encryption.md).
      * В блоке **{{ ui-key.yacloud_components.security.dspm.header_scan_result_sensitive_data }}** укажите, как отображать имена, контактные данные и другую личную информацию.
      * Нажмите **{{ ui-key.yacloud_components.security.dspm.action_export }}**, чтобы экспортировать результаты проверки параметров.

{% endlist %}


## Посмотреть ошибки сканирования {#errors}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя нужного бакета.
  1. Перейдите на вкладку **{{ ui-key.yacloud.storage.bucket.switch_security }}** → **{{ ui-key.yacloud.storage.bucket.switch_sensitive-data-search }}** → **{{ ui-key.yacloud.storage.Bucket.BucketSecuritySensitiveDataTab.sub_tab_issues }}**.

{% endlist %}

{% include [errors-scan-outro](../../../_includes/security-deck/errors-scan-outro.md) %}

[*bucket-object-key]: [Ключ объекта](../../concepts/object.md#key) — это полное имя файла внутри бакета, часто записанное как путь в файловой системе. Примеры ключей: `docs/reports/2026/april.pdf`, `photos/trips/paris/img001.jpg`.

[*bucket-object-prefix]: [Префикс](../../concepts/object.md#folder) — это начальная часть ключа, которую интерфейс показывает как папку. Примеры префиксов: `photos/`, `photos/trips/`, `photos/trips/paris/`.