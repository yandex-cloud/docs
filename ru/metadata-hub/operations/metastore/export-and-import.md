# Экспорт и импорт метаданных Hive в кластере {{ metastore-name }}

## Перед началом работы {#before-you-begin}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) `my-account` с ролью `storage.uploader`.
1. [Создайте статический ключ доступа](../../../iam/operations/sa/create-access-key.md) для сервисного аккаунта `my-account`. Сохраните идентификатор и секретный ключ — они понадобятся для работы с [{{ objstorage-full-name }}](../../../storage/index.yaml).
1. [Настройте сеть и создайте кластер](cluster-create.md) {{ metastore-name }}. При создании укажите параметры статического ключа доступа.

   {% note warning %}

   Экспорт и импорт данных доступны в кластерах {{ metastore-name }} только со статическим ключом доступа.

   {% endnote %}

1. [Создайте бакет](../../../storage/operations/buckets/create.md) `my-bucket` в {{ objstorage-name }}. В нем будет храниться файл с метаданными для импорта и экспорта.
1. [Выдайте разрешение](../../../storage/operations/buckets/edit-acl.md) `READ и WRITE` сервисному аккаунту `my-account` на бакет `my-bucket`.

{% note warning %}

Не назначайте на бакет [политику доступа](../../../storage/security/policy.md), иначе кластер {{ metastore-name }} не сможет записывать данные в бакет.

{% endnote %}

## Экспортируйте данные {#export}

{% list tabs group=instructions %}

* Консоль управления {#console}

   1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/arrow-up-from-square.svg) **{{ ui-key.yacloud.metastore.action_export }}**.
   1. В открывшемся окне укажите:

      * Бакет `my-bucket`, куда будут экспортированы данные кластера.
      * Название файла `.sql`, куда будут записаны данные кластера. Если файл с таким названием уже существует, он будет перезаписан.

   1. Нажмите кнопку **{{ ui-key.yacloud.metastore.dialog.import-export.action_export }}**.

{% endlist %}

## Импортируйте данные {#import}

Перед импортом [загрузите файл](../../../storage/operations/objects/upload.md#simple) `.sql` с метаданными в бакет `my-bucket`. О том, как подготовить файл и как устроен процесс импорта, читайте в разделе [{#T}](../../tutorials/metastore-import.md).

Чтобы импортировать данные в кластер:

{% list tabs group=instructions %}

* Консоль управления {#console}

   1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
   1. На левой панели выберите страницу ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
   1. Нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) для нужного кластера и выберите пункт ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud.metastore.action_import }}**.
   1. В открывшемся окне выберите бакет `my-bucket` и файл, откуда будут импортированы данные кластера.
   1. Нажмите кнопку **{{ ui-key.yacloud.metastore.dialog.import-export.action_import }}**.

{% endlist %}
