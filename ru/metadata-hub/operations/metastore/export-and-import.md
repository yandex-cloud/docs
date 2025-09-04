---
title: Экспорт и импорт метаданных Hive в кластере {{ metastore-full-name }}
description: Следуя данной инструкции, вы научитесь экспортировать и импортировать метаданные Hive в кластере {{ metastore-name }}.
---

# Экспорт и импорт метаданных Hive в кластере {{ metastore-name }}

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `my-account`  ролями `storage.uploader` и `managed-metastore.integrationProvider`.
1. [Настройте сеть и создайте кластер](cluster-create.md) {{ metastore-name }}. При создании укажите сервисный аккаунт `my-account`.
1. [Создайте бакет](../../../storage/operations/buckets/create.md) `my-bucket` в {{ objstorage-full-name }}. В нем будет храниться файл с метаданными для импорта и экспорта.
1. [Выдайте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` сервисному аккаунту `my-account` на бакет `my-bucket`.

Подробнее о подключении к бакету, в котором настроены политики доступа, см. в [инструкции](s3-policy-connect.md).

## Экспорт данных {#export}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.metastore.action_export }}**.
   1. В открывшемся окне укажите:

      * Бакет `my-bucket`, куда будут экспортированы данные кластера.
      * Название файла `.sql`, куда будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

   1. Нажмите кнопку **{{ ui-key.yacloud.metastore.dialog.import-export.action_export }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы экспортировать метаданные из кластера {{ metastore-name }}, выполните команду:

   ```bash
   {{ yc-metastore }} cluster export-data <имя_или_идентификатор_кластера> \
      --bucket <имя_бакета> \
      --filepath <файл_для_данных>
   ```

   Где:

   * `--bucket` — бакет {{ objstorage-name }}, куда будут экспортированы данные кластера.
   * `--filepath` — путь к файлу `.sql`, в который будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

   Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Импорт данных {#import}

Перед импортом [загрузите файл](../../../storage/operations/objects/upload.md#simple) `.sql` с метаданными в бакет `my-bucket`. О том, как подготовить файл и как устроен процесс импорта, читайте в разделе [{#T}](../../tutorials/metastore-import.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

   Чтобы импортировать данные в кластер {{ metastore-name }}:

   1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud.metastore.action_import }}**.
   1. В открывшемся окне выберите бакет `my-bucket` и файл, откуда будут импортированы данные кластера.
   1. Нажмите кнопку **{{ ui-key.yacloud.metastore.dialog.import-export.action_import }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   Чтобы импортировать метаданные в кластер {{ metastore-name }}, выполните команду:

   ```bash
   {{ yc-metastore }} cluster import-data <имя_или_идентификатор_кластера> \
      --bucket <имя_бакета> \
      --filepath <файл_для_данных>
   ```

   Где:

   * `--bucket` — бакет {{ objstorage-name }}, откуда будут импортированы данные кластера.
   * `--filepath` — путь к файлу `.sql`, из которого будут импортированы данные кластера.

   Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}
