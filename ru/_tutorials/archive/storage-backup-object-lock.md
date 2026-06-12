# Защита резервных копий от удаления и перезаписи с помощью блокировок версий объектов

Резервные копии в [{{ objstorage-full-name }}](../../storage/) — последний рубеж защиты данных при сбоях оборудования, ошибках администрирования и атаках. Однако сами резервные копии тоже уязвимы: злоумышленник, получивший доступ к хранилищу (например, через [скомпрометированный статический ключ доступа](../../iam/operations/compromised-credentials.md)), может удалить или перезаписать копии перед атакой на основную инфраструктуру. Так действуют операторы вирусов-шифровальщиков: сначала уничтожают резервные копии, затем шифруют рабочие данные, чтобы лишить жертву возможности восстановиться без выкупа.

[Версионирование](../../storage/concepts/versioning.md) бакета защищает от части таких сценариев, но не от всех: пользователь с достаточными правами может удалить и предыдущие версии объектов. Полную неизменяемость обеспечивает механизм [блокировки версий объектов](../../storage/concepts/object-lock.md) (object lock). Заблокированную версию нельзя удалить или перезаписать до окончания срока блокировки, а при строгой блокировке (compliance-mode) это не может сделать даже пользователь с ролью `storage.admin`. Такая схема хранения соответствует модели WORM (Write Once Read Many): данные записываются один раз и доступны только для чтения.

В этом руководстве вы настроите хранилище резервных копий, защищенное от удаления и перезаписи, и убедитесь, что защита работает.

Чтобы защитить резервные копии с помощью блокировок версий объектов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте бакет](#create-bucket).
1. [Включите версионирование и блокировки версий объектов](#enable-object-lock).
1. [Настройте блокировку по умолчанию](#default-lock).
1. [Создайте сервисный аккаунт с минимальными правами](#create-sa).
1. [Создайте статический ключ доступа](#create-static-key).
1. [Загрузите резервную копию и проверьте блокировку](#upload-backup).
1. [Проверьте защиту от удаления](#test-protection).
1. [Настройте жизненный цикл для устаревших версий](#lifecycle).
1. [Усильте защиту в рабочей среде](#recommendations).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

Для выполнения шагов руководства вам понадобятся [роли](../../storage/security/index.md):

* `storage.admin` — чтобы создать бакет, включить версионирование и настроить блокировки;
* `iam.serviceAccounts.admin` — чтобы создать сервисный аккаунт и статический ключ доступа.


### Необходимые платные ресурсы {#paid-resources}

{% include [paid-resources](../_tutorials_includes/storage-backup/paid-resources.md) %}

{% note info %}

При включенном версионировании в бакете хранятся все версии объектов, в том числе неактуальные. Плата взимается за суммарный объем всех версий, поэтому настройте [жизненный цикл](#lifecycle) для удаления версий, у которых закончился срок блокировки.

{% endnote %}


## Создайте бакет {#create-bucket}

{% include [create-bucket](../_tutorials_includes/storage-backup/create-bucket.md) %}


## Включите версионирование и блокировки версий объектов {#enable-object-lock}

Блокировки версий объектов работают только в [версионируемых](../../storage/concepts/versioning.md) бакетах, поэтому сначала включите версионирование, а затем — механизм блокировок.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя созданного бакета.
  1. Включите версионирование:

     1. На панели слева выберите ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
     1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_versioning }}**.
     1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketVersioningFormSection.label_versioning-disabled_ngMWc }}**.
     1. Нажмите **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

  1. Включите возможность блокировок:

     1. На панели слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
     1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
     1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_temp-object-lock-enabled_v3heA }}**.
     1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../storage/tools/aws-cli.md).

  1. Включите версионирование бакета:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-bucket-versioning \
       --bucket <имя_бакета> \
       --versioning-configuration 'Status=Enabled'
     ```

  1. Включите механизм блокировок:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-object-lock-configuration \
       --bucket <имя_бакета> \
       --object-lock-configuration ObjectLockEnabled=Enabled
     ```

{% endlist %}

Включение механизма блокировок не устанавливает блокировки на уже загруженные версии объектов, а только позволяет их устанавливать.


## Настройте блокировку по умолчанию {#default-lock}

Чтобы каждая загружаемая резервная копия была защищена автоматически, настройте [блокировку по умолчанию](../../storage/concepts/object-lock.md#default): она будет устанавливаться на все новые версии объектов в бакете. Так вы исключите ситуацию, когда копия загружена без защиты из-за ошибки в скрипте резервного копирования.

Выберите [тип блокировки](../../storage/concepts/object-lock.md#types):

* временная управляемая (`GOVERNANCE`) — пользователь с ролью `storage.admin` может обойти, сократить или снять блокировку, явно подтвердив действие;
* временная строгая (`COMPLIANCE`) — обойти, сократить или снять блокировку до ее окончания не может никто, в том числе пользователь с ролью `storage.admin`. Для защиты от шифровальщиков используйте этот тип: даже полная компрометация учетных данных не позволит злоумышленнику уничтожить резервные копии.

Срок блокировки выберите равным сроку хранения резервных копий, например 14 дней.

{% note alert %}

Строгую блокировку (`COMPLIANCE`) невозможно снять до окончания ее срока. Версии объектов будут храниться и тарифицироваться весь срок блокировки, а удалить бакет получится только после удаления всех версий. Если вы выполняете руководство в тестовых целях, укажите минимальный срок — 1 день — или используйте управляемую блокировку (`GOVERNANCE`).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите на имя бакета.
  1. На панели слева выберите ![image](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}**.
  1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_default-rules-enabled_qtmC8 }}**.
  1. Выберите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:

     * **{{ ui-key.yacloud.storage.file.value_object-lock-mode-governance }}** — временная управляемая блокировка;
     * **{{ ui-key.yacloud.storage.file.value_object-lock-mode-compliance }}** — временная строгая блокировка.

  1. Установите **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** в днях или годах.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  1. Создайте файл `default-object-lock.json` с конфигурацией блокировок по умолчанию:

     ```json
     {
       "ObjectLockEnabled": "Enabled",
       "Rule": {
         "DefaultRetention": {
           "Mode": "COMPLIANCE",
           "Days": 14
         }
       }
     }
     ```

     Где:

     * `Mode` — [тип](../../storage/concepts/object-lock.md#types) блокировки: `GOVERNANCE` или `COMPLIANCE`;
     * `Days` — срок блокировки в днях от момента загрузки версии объекта. Вместо него можно указать срок в годах в параметре `Years`.

  1. Загрузите конфигурацию в бакет:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }} \
       s3api put-object-lock-configuration \
       --bucket <имя_бакета> \
       --object-lock-configuration file://default-object-lock.json
     ```

{% endlist %}

{% note info %}

Если для бакета настроены блокировки по умолчанию, при загрузке каждой версии объекта в запросе должен передаваться заголовок `Content-MD5`. AWS CLI добавляет его автоматически. Если ваш инструмент резервного копирования обращается к [REST API](../../glossary/rest-api.md) напрямую, вычислите [MD5-хеш](https://ru.wikipedia.org/wiki/MD5) загружаемых данных, закодируйте его по схеме [Base64](https://ru.wikipedia.org/wiki/Base64) и передайте в этом заголовке.

{% endnote %}


## Создайте сервисный аккаунт с минимальными правами {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого скрипт или система резервного копирования будет загружать копии в бакет. Назначьте ему [роль](../../storage/security/index.md#storage-uploader) `storage.uploader`: она позволяет загружать объекты и устанавливать блокировки, но не позволяет изменять настройки бакета, снимать блокировки или обходить управляемую блокировку. Даже если ключ этого сервисного аккаунта будет скомпрометирован, злоумышленник не сможет удалить заблокированные версии резервных копий.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** укажите `sa-backup-uploader`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `storage.uploader`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Создайте сервисный аккаунт:

     ```bash
     yc iam service-account create --name sa-backup-uploader
     ```

     Результат:

     ```yaml
     id: ajeab0cnib1p********
     folder_id: b0g12ga82bcv********
     created_at: "2026-06-11T09:44:35.989446Z"
     name: sa-backup-uploader
     ```

  1. Назначьте сервисному аккаунту роль `storage.uploader` на каталог:

     ```bash
     yc resource-manager folder add-access-binding <имя_каталога> \
       --service-account-name sa-backup-uploader \
       --role storage.uploader
     ```

- API {#api}

  1. Создайте сервисный аккаунт `sa-backup-uploader`. Для этого воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).
  1. Назначьте сервисному аккаунту в текущем каталоге роль `storage.uploader`. Для этого воспользуйтесь методом REST API [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md).

{% endlist %}

{% note tip %}

Не используйте для загрузки резервных копий сервисные аккаунты с ролями `storage.editor`, `storage.admin` или примитивными ролями `editor` и `admin`. Чем меньше прав у ключа, который хранится на сервере резервного копирования, тем меньше ущерб от его компрометации.

{% endnote %}


## Создайте статический ключ доступа {#create-static-key}

Чтобы система резервного копирования могла обращаться к бакету по протоколу S3, создайте [статический ключ доступа](../../iam/concepts/authorization/access-key.md):

```bash
yc iam access-key create \
  --service-account-name sa-backup-uploader
```

Результат:

```text
access_key:
  id: aje726ab18go********
  service_account_id: ajecikmc374i********
  created_at: "2026-06-11T14:16:44.936656476Z"
  key_id: YCAJEOmgIxyYa54LY********
secret: YCMiEYFqczmjJQ2XCHMOenrp1s1-yva1********
```

Сохраните идентификатор `key_id` и секретный ключ `secret`: после закрытия сессии получить значение `secret` будет невозможно. Укажите полученный ключ в [настройках AWS CLI](../../storage/tools/aws-cli.md) или в конфигурации вашего инструмента резервного копирования.

Храните ключ в защищенном хранилище секретов, например в {{ lockbox-name }} — см. руководство [{#T}](../../tutorials/security/static-key-in-lockbox/index.md).


## Загрузите резервную копию и проверьте блокировку {#upload-backup}

1. Загрузите файл резервной копии в бакет от имени сервисного аккаунта `sa-backup-uploader`:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3 cp <путь_к_файлу_резервной_копии> s3://<имя_бакета>/<ключ_объекта>
   ```

   Результат:

   ```text
   upload: ./backup-2026-06-11.tar.gz to s3://backup-bucket/backup-2026-06-11.tar.gz
   ```

   Блокировка по умолчанию установится на загруженную версию автоматически.

   Чтобы автоматизировать регулярную загрузку копий, используйте одно из руководств серии [Резервное копирование в {{ objstorage-full-name }}](storage-backup-overview.md).

1. Получите идентификатор загруженной версии объекта:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3api list-object-versions \
     --bucket <имя_бакета> \
     --prefix <ключ_объекта>
   ```

   Сохраните значение поля `VersionId` из результата.

1. Убедитесь, что на версию установлена блокировка:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3api head-object \
     --bucket <имя_бакета> \
     --key <ключ_объекта> \
     --version-id <идентификатор_версии>
   ```

   В результате должны присутствовать поля с настройками блокировки:

   ```json
   {
     ...
     "ObjectLockMode": "COMPLIANCE",
     "ObjectLockRetainUntilDate": "2026-06-25T00:00:00+00:00"
     ...
   }
   ```


## Проверьте защиту от удаления {#test-protection}

Убедитесь, что заблокированную версию резервной копии действительно нельзя уничтожить.

1. Попробуйте удалить версию объекта:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3api delete-object \
     --bucket <имя_бакета> \
     --key <ключ_объекта> \
     --version-id <идентификатор_версии>
   ```

   Команда завершится ошибкой `AccessDenied`: версия защищена блокировкой. При строгой блокировке (`COMPLIANCE`) удалить версию не сможет даже пользователь с ролью `storage.admin`. При управляемой блокировке (`GOVERNANCE`) пользователь с ролью `storage.admin` может удалить версию, только явно подтвердив обход блокировки параметром `--bypass-governance-retention` — случайно сделать это не получится.

1. Попробуйте удалить объект без указания версии:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3api delete-object \
     --bucket <имя_бакета> \
     --key <ключ_объекта>
   ```

   Команда выполнится успешно, и объект перестанет отображаться в списке объектов бакета. Однако данные не удалены: в бакете создался [маркер удаления](../../storage/concepts/versioning.md), а все версии объекта сохранились. Именно так выглядит попытка злоумышленника или вредоносного скрипта «удалить» резервные копии в версионируемом бакете.

1. Восстановите объект, удалив маркер удаления. Получите идентификатор маркера в поле `DeleteMarkers` результата команды `list-object-versions`, затем выполните:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3api delete-object \
     --bucket <имя_бакета> \
     --key <ключ_объекта> \
     --version-id <идентификатор_маркера_удаления>
   ```

   Объект снова появится в списке объектов бакета. Подробнее см. [{#T}](../../storage/operations/objects/restore-object-version.md).

Таким образом, пока действует блокировка, резервные копии можно восстановить даже после атаки с полным доступом к бакету.


## Настройте жизненный цикл для устаревших версий {#lifecycle}

Чтобы не платить за хранение устаревших резервных копий, настройте [жизненный цикл](../../storage/concepts/lifecycles.md): он будет автоматически удалять неактуальные версии объектов после окончания срока блокировки. Удалить заблокированную версию жизненный цикл не может, поэтому укажите в правиле срок, равный сроку блокировки или больший.

1. Создайте файл `lifecycle-backup.json` с конфигурацией:

   ```json
   {
     "Rules": [
       {
         "ID": "delete-expired-backup-versions",
         "Filter": {
           "Prefix": ""
         },
         "Status": "Enabled",
         "NoncurrentVersionExpiration": {
           "NoncurrentDays": 14
         },
         "Expiration": {
           "ExpiredObjectDeleteMarker": true
         }
       }
     ]
   }
   ```

   Где:

   * `NoncurrentDays` — количество дней, по истечении которых неактуальная версия объекта будет удалена. Укажите значение, равное сроку блокировки по умолчанию или большее;
   * `ExpiredObjectDeleteMarker` — удаление маркеров, для которых не осталось неактуальных версий объекта.

1. Загрузите конфигурацию в бакет:

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} \
     s3api put-bucket-lifecycle-configuration \
     --bucket <имя_бакета> \
     --lifecycle-configuration file://lifecycle-backup.json
   ```

Подробнее о настройке жизненных циклов см. в [инструкции](../../storage/operations/buckets/lifecycles.md).


## Усильте защиту в рабочей среде {#recommendations}

Блокировки версий объектов — основа защиты, но в рабочей среде дополните их организационными мерами:

* Разместите бакет с резервными копиями в отдельном [каталоге](../../resource-manager/operations/folder/create.md) или облаке, доступ к которому есть только у администраторов резервного копирования. Так компрометация учетных записей основной инфраструктуры не даст доступа к настройкам бакета с копиями.
* Назначайте роли на бакет, а не на весь каталог, — см. [{#T}](../../storage/operations/buckets/iam-access.md).
* Используйте строгую блокировку (`COMPLIANCE`) и подбирайте срок так, чтобы он покрывал период, за который вы гарантированно заметите атаку и успеете восстановиться.
* Храните статические ключи доступа в {{ lockbox-name }} или другом защищенном хранилище секретов, а порядок действий на случай утечки ключа подготовьте заранее — см. [{#T}](../../iam/operations/compromised-credentials.md).
* Включите [логирование действий с бакетом](../../storage/operations/buckets/enable-logging.md) и отслеживайте события {{ objstorage-name }} в [{{ at-full-name }}](../../audit-trails/), чтобы вовремя заметить массовое удаление объектов или изменение настроек бакета.
* Регулярно проверяйте, что резервные копии восстанавливаются: неизменяемая, но неработоспособная копия не поможет при инциденте.


## Как удалить созданные ресурсы {#clear-out}

{% note alert %}

Версии объектов с действующей блокировкой удалить нельзя. Если вы настроили строгую блокировку (`COMPLIANCE`), дождитесь окончания ее срока. Версии с управляемой блокировкой (`GOVERNANCE`) пользователь с ролью `storage.admin` может удалить досрочно, подтвердив обход блокировки, — см. [{#T}](../../storage/operations/objects/delete.md#w-object-lock).

{% endnote %}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите объекты](../../storage/operations/objects/delete-all.md) из бакета, включая все версии.
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md) `sa-backup-uploader`.
