# Работа с механизмом логирования действий с бакетом


Чтобы отслеживать работу с [бакетом](../../concepts/bucket.md), включите [механизм логирования](../../concepts/server-logs.md).

Подробная информация о запросах к _исходному_ бакету будет сохранена в [объекте](../../concepts/object.md) в _целевом_ бакете. Исходный и целевой бакеты должны различаться. 

{{ objstorage-name }} [не гарантирует](../../concepts/server-logs.md) полноту и своевременность записи логов.

По умолчанию механизм логирования отключен. После его включения, {{ objstorage-name }} будет записывать информацию о действиях с бакетом раз в час.

## Включите механизм логирования {#enable}

Чтобы логировать обращения к бакету:

1. Используйте существующий или создайте новый целевой бакет. В этот бакет будут записываться логи.

   {% cut "Как создать бакет" %}

   Чтобы создать [бакет](../../concepts/bucket.md), у вас должна быть _минимальная_ [роль](../../security/index.md#storage-editor) `storage.editor` на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).
   
   {% list tabs group=instructions %}
   
   - Консоль управления {#console}
   
     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
     1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
     1. На панели сверху нажмите **{{ ui-key.yacloud.storage.buckets.button_create }}**.
     1. На странице создания бакета:
   
         1. Введите имя бакета в соответствии с [правилами именования](../../concepts/bucket.md#naming).
   
             
             По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите собственный сертификат безопасности](../hosting/certificate.md) в {{ objstorage-name }}.
   
   
         1. При необходимости добавьте [метки](../../concepts/tags.md):
   
             1. Нажмите **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
             1. Введите метку в формате `ключ: значение`.
             1. Нажмите **Enter**.
   
         1. При необходимости ограничьте максимальный размер бакета.
   
             Размер `0` означает отсутствие ограничений и аналогичен включенной опции **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
   
         1. Задайте параметры [публичного доступа](../../security/public-access.md) на чтение [объектов](../../concepts/object.md) в бакете, получение списка объектов и чтение настроек бакета:
   
             * `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}` — доступ только для авторизованных пользователей {{ yandex-cloud }}.
             * `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}` — доступ для любых пользователей.
   
             {% note warning %}
             
             Публичный доступ предоставляется неограниченному кругу анонимных пользователей. Используйте его только в случае, когда нет возможности применить другие механизмы предоставления доступа.
             
             {% endnote %}
   
         1. Выберите [класс хранилища](../../concepts/storage-class.md) по умолчанию:
   
             * `{{ ui-key.yacloud.storage.value_standard }}`
             * `{{ ui-key.yacloud.storage.value_cold }}`
             * `{{ ui-key.yacloud.storage.value_ice }}`
   
             Более «холодные» классы предназначены для длительного хранения объектов, работать с которыми планируется реже. Чем «холоднее» хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.
   
         
         1. При необходимости включите шифрование: в поле **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** выберите [симметричный ключ](../../../kms/concepts/key.md) или [создайте](../../../kms/operations/key.md#create) новый.
   
   
         1. Нажмите **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.
   
   - {{ yandex-cloud }} CLI {#cli}
   
     Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
   
     По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
   
     1. Посмотрите описание команды CLI для создания бакета:
     
         ```bash
         yc storage bucket create --help
         ```
     
     1. Создайте бакет в каталоге по умолчанию:
     
         ```bash
         yc storage bucket create --name <имя_бакета>
         ```
     
         Где `--name` — имя бакета. Обязательный параметр. Подробнее см. [Правила именования бакетов](../../concepts/bucket.md#naming).
     
         
         По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../hosting/certificate.md) собственный сертификат безопасности в {{ objstorage-name }}.
     
     
         Результат:
     
         ```text
         name: example
         folder_id: b1gmit33ngp6********
         anonymous_access_flags:
         read: false
         list: false
         default_storage_class: STANDARD
         versioning: VERSIONING_DISABLED
         max_size: "53687091200"
         acl: {}
         created_at: "2022-12-16T14:05:12.196007Z"
         ```
     
         {% cut "Опциональные параметры" %}
     
         * `--default-storage-class` — [класс хранилища](../../concepts/storage-class.md). Доступные значения:
         * `standard` — стандартное хранилище. Устанавливается по умолчанию.
         * `cold` — холодное хранилище.
         * `ice` — ледяное хранилище.
     
         Более <q>холодные</q> классы предназначены для длительного хранения [объектов](../../concepts/object.md), работать с которыми планируется реже. Чем <q>холоднее</q> хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.
     
         * `--max-size` — максимальный размер бакета в байтах. Значение по умолчанию — `0` (без ограничений).
         * Параметры для включения [публичного доступа](../../security/public-access.md) к бакету:
         * `--public-read` — включить публичный доступ на чтение объектов в бакете.
         * `--public-list` — включить публичный доступ на просмотр списка объектов в бакете.
         * `--public-config-read` — включить публичный доступ на чтение настроек в бакете.
     
         По умолчанию публичный доступ к бакету выключен.
     
         {% note warning %}
         
         Публичный доступ предоставляется неограниченному кругу анонимных пользователей. Используйте его только в случае, когда нет возможности применить другие механизмы предоставления доступа.
         
         {% endnote %}
     
         * Параметры для настройки [ACL](../../concepts/acl.md) бакета:
         * `--acl` — предопределенный ACL. Список возможных значений см. в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls). Нельзя использовать одновременно с параметром `--grants`.
         * `--grants` — настройки разрешений для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Нельзя использовать одновременно с параметром `--acl`. Значение параметра указывается в формате: `grant-type=<тип_получателя_разрешения>,grantee-id=<идентификатор_получателя>,permission=<тип_разрешения>`, где:
             * `grant-type` — тип получателя разрешения. Возможные значения:
             * `grant-type-account` — пользователь, [сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) или [группа пользователей](../../../organization/concepts/groups.md);
             * `grant-type-all-authenticated-users` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }};
             * `grant-type-all-users` — публичная группа всех пользователей интернета.
             * `grantee-id` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение. Указывается, только если `grant-type=grant-type-account`.
             * `permission` — тип разрешения ACL. Возможные значения: `permission-full-control`, `permission-write`, `permission-read`. Подробнее о разрешениях см. в разделе [Виды разрешений](../../concepts/acl.md#permissions-types).
     
             Чтобы настроить несколько разрешений, укажите параметр `--grants` несколько раз.
     
         По умолчанию для каждого нового бакета создается пустой ACL.
     
         {% endcut %}
     
         Подробнее о команде `yc storage bucket create` см. в [Справочнике YC CLI](../../../cli/cli-ref/storage/cli-ref/bucket/create.md).
   
   - AWS CLI {#aws-cli}
   
     Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).
   
     Чтобы создать бакет, [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../security/index.md#storage-editor) `storage.editor`.
   
     В терминале выполните команду:
   
     ```bash
     aws s3api create-bucket \
       --endpoint-url=https://{{ s3-storage-host }} \
       --bucket <имя_бакета>
     ```
   
     Где:
   
     * `--endpoint-url` — эндпоинт {{ objstorage-name }}.
     * `--bucket` — имя бакета.
   
     
     {% note info %}
   
     По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите](../hosting/certificate.md) собственный сертификат безопасности в {{ objstorage-name }}. Подробнее см. [Правила именования бакетов](../../concepts/bucket.md#naming).
   
     {% endnote %}
   
   
     Результат:
   
     ```text
     {
       "Location": "/<имя_бакета>"
     }
     ```
   
     Будет создан бакет со следующими параметрами:
     * без ограничения максимального размера;
     * с ограниченным [доступом](../../concepts/bucket.md#bucket-access) на чтение объектов, к списку объектов и на чтение настроек;
     * с [классом хранилища](../../concepts/storage-class.md) `Стандартное`.
   
     {% cut "Опциональные параметры" %}
   
     Вы можете применить к бакету [предопределенный ACL](../../concepts/acl.md#predefined-acls) или настроить разрешения для отдельных пользователей, [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md), [групп пользователей](../../../organization/concepts/groups.md) и [публичных групп](../../concepts/acl.md#public-groups) (группа всех пользователей интернета, группа всех аутентифицированных пользователей {{ yandex-cloud }}). Эти настройки несовместимы: у бакета должен быть либо предопределенный ACL, либо набор отдельных разрешений.
   
     {% note info %}
   
     Чтобы управлять настройками [ACL](../../concepts/acl.md) бакета, [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту, через который работает AWS CLI, [роль](../../security/index.md#storage-admin) `storage.admin`.
   
     {% endnote %}
   
     **Предопределенный ACL**
   
     ```bash
     aws s3api create-bucket \
       --endpoint-url=https://{{ s3-storage-host }} \
       --bucket <имя_бакета> \
       --acl <предопределенный_ACL>
     ```
   
     Где `--acl` — предопределенный ACL. Список значений см. в разделе [Предопределенные ACL](../../concepts/acl.md#predefined-acls).
   
     **Отдельные разрешения**
   
     ```bash
     aws s3api create-bucket \
       --endpoint-url=https://{{ s3-storage-host }} \
       --bucket <имя_бакета> \
       <тип_разрешения> <получатель_разрешения>
     ```
   
     Где:
     * Возможные типы разрешений ACL:
       * `--grant-read` — доступ к списку объектов в бакете, чтению различных настроек бакета (жизненный цикл, CORS, статический хостинг), чтению всех объектов в бакете.
       * `--grant-write` — доступ к записи, перезаписи и удалению объектов в бакете. Используется только совместно с `--grant-read`.
       * `--grant-full-control` — полный доступ к бакету и объектам в нем.
   
       Вы можете задать несколько разрешений в одной команде.
     * Возможные получатели разрешений:
       * `id=<идентификатор_получателя>` — идентификатор пользователя, сервисного аккаунта или группы пользователей, которым нужно дать разрешение.
       * `uri=http://acs.amazonaws.com/groups/global/AuthenticatedUsers` — [публичная группа](../../concepts/acl.md#public-groups) всех аутентифицированных пользователей {{ yandex-cloud }}.
       * `uri=http://acs.amazonaws.com/groups/global/AllUsers` — публичная группа всех пользователей интернета.
   
     По умолчанию для каждого нового бакета создается пустой ACL.
   
     {% endcut %}
   
     Подробнее о команде `aws s3api create-bucket` см. в [документации AWS](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/create-bucket.html).
   
   - {{ TF }} {#tf}
   
     {% note info %}
     
     Если вы работаете с {{ objstorage-name }} через {{ TF }} от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
     
     {% endnote %}
   
     [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
     
     {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
     
     Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).
   
     
     Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.
   
   
   
     
     По умолчанию для аутентификации в {{ objstorage-name }} {{ TF }} использует IAM-токен. Кроме IAM-токена для аутентификации в {{ objstorage-name }} можно использовать сервисный аккаунт и статические ключи доступа. Более подробную информацию об особенностях аутентификации {{ TF }} в {{ objstorage-name }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).
   
     **Создание бакета с использованием IAM-токена**
   
     1. [Получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и добавьте их в переменные окружения.
     1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
   
         ```hcl
         # Создание бакета с использованием IAM-токена
   
         resource "yandex_storage_bucket" "iam-bucket" {
           bucket    = "<имя_бакета>"
           folder_id = "<идентификатор_каталога>"
         }
         ```
   
         Где:
         * `bucket` — имя бакета. Обязательный параметр.
   
           По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите собственный сертификат безопасности](../hosting/certificate.md) в {{ objstorage-name }}.
         
         * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   
           {% note info %}
   
           Если вы используете IAM-токен учетной записи пользователя, то в ресурсе `yandex_storage_bucket` необходимо указывать идентификатор каталога `folder_id`.
   
           В случае использования IAM-токена сервисного аккаунта или статических ключей доступа, `folder_id` указывать необязательно — он потребуется только если вы хотите создать ресурс в каталоге, отличном от каталога сервисного аккаунта.
   
           {% endnote %}
   
         Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).
   
     1. Создайте ресурсы:
   
           1. В терминале перейдите в директорию с конфигурационным файлом.
           1. Проверьте корректность конфигурации с помощью команды:
           
              ```bash
              terraform validate
              ```
           
              Если конфигурация является корректной, появится сообщение:
           
              ```bash
              Success! The configuration is valid.
              ```
           
           1. Выполните команду:
           
              ```bash
              terraform plan
              ```
           
              В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
           1. Примените изменения конфигурации:
           
              ```bash
              terraform apply
              ```
           
           1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
   
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).
   
   
     **Создание бакета с использованием статического ключа**
   
     1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
   
         {% cut "Создание бакета с использованием статического ключа" %}
   
         ```hcl
         terraform {
           required_providers {
             yandex = {
               source = "yandex-cloud/yandex"
             }
           }
           required_version = ">= 0.13"
         }
   
         # Настройка провайдера
         
         provider "yandex" {
           zone      = "{{ region-id }}-a"
         }
   
         # Создание сервисного аккаунта
         
         resource "yandex_iam_service_account" "sa" {
           name = "<имя_сервисного_аккаунта>"
         }
   
         # Назначение роли сервисному аккаунту
         
         resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
           folder_id = "<идентификатор_каталога>"
           role      = "storage.admin"
           member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
         }
   
         # Создание статического ключа доступа
         
         resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
           service_account_id = yandex_iam_service_account.sa.id
           description        = "static access key for object storage"
         }
   
         # Создание бакета с использованием статического ключа
         
         resource "yandex_storage_bucket" "test" {
           access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
           secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
           bucket                = "<имя_бакета>"
           max_size              = <максимальный_размер_бакета>
           default_storage_class = "<класс_хранилища>"
           anonymous_access_flags {
             read        = <true|false>
             list        = <true|false>
             config_read = <true|false>
           }
           tags = {
             <ключ_1> = "<значение_1>"
             <ключ_2> = "<значение_2>"
             ...
             <ключ_n> = "<значение_n>"
           }
         }
         ```
   
         Где:
         * `yandex_iam_service_account` — описание [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), который создаст [бакет](../../concepts/bucket.md) и будет работать с ним:
   
           * `name` — имя сервисного аккаунта. Обязательный параметр.
           * `bucket` — имя бакета.
   
             
             По умолчанию бакет с точкой в имени доступен только по протоколу HTTP. Чтобы поддержать для бакета протокол HTTPS, [загрузите собственный сертификат безопасности](../hosting/certificate.md) в {{ objstorage-name }}.
   
   
           * `max_size` — максимальный размер бакета в байтах. Значение по умолчанию — `0`, без ограничений. 
           * `default_storage_class` — [класс хранилища](../../concepts/storage-class.md). Доступные значения:
   
             * `standard` — стандартное хранилище. Значение по умолчанию.
             * `cold` — холодное хранилище.
             * `ice` — ледяное хранилище.
   
             Более <q>холодные</q> классы предназначены для длительного хранения объектов, работать с которыми планируется реже. Чем <q>холоднее</q> хранилище, тем дешевле хранить в нем данные, но тем дороже их читать и записывать.
   
           * `anonymous_access_flags` — настройки [доступа](../../concepts/bucket.md#bucket-access):
   
             * `read` — публичный доступ на чтение объектов в бакете.
             * `list` — публичный доступ на просмотр списка объектов в бакете.
             * `config_read` — публичный доступ на чтение настроек в бакете. По умолчанию выключен.
   
           * `tags` — [метки](../../concepts/tags.md) бакета в формате `ключ = "значение"`.
   
         Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).
   
         {% endcut %}
   
     1. Создайте ресурсы:
   
         1. В терминале перейдите в директорию с конфигурационным файлом.
         1. Проверьте корректность конфигурации с помощью команды:
         
            ```bash
            terraform validate
            ```
         
            Если конфигурация является корректной, появится сообщение:
         
            ```bash
            Success! The configuration is valid.
            ```
         
         1. Выполните команду:
         
            ```bash
            terraform plan
            ```
         
            В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
         1. Примените изменения конфигурации:
         
            ```bash
            terraform apply
            ```
         
         1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.
   
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).
   
   - API {#api}
   
     Чтобы создать бакет, воспользуйтесь методом REST API [create](../../api-ref/Bucket/create.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Create](../../api-ref/grpc/Bucket/create.md) или методом S3 API [create](../../s3/api-ref/bucket/create.md).
   
   {% endlist %}

   {% endcut %}

   {% note info %}
   
   Чтобы записывать логи в целевой бакет, для которого настроена [политика доступа](../../concepts/policy.md), [добавьте](policy.md#apply-policy) в нее правило, разрешающее всем учетным записям выполнять действие `PutObject`, а в качестве ресурса укажите имя бакета с [префиксом ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например `<имя_бакета>/logs/*`.
   
   {% endnote %}

1. Включите механизм логирования в исходном бакете, который вы хотите отслеживать.

   {% list tabs group=instructions %}

   - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог.
      1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
      1. Выберите бакет, для которого хотите настроить логирование.
      1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}**.
      1. Включите опцию **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_server-logs_mfGpj }}**.
      1. Выберите **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_target-bucket_jEJ5E }}**.
      1. В поле **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_prefix_4JTZG }}** укажите префикс, с которым будут сохраняться логи.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

   - AWS CLI {#cli}

     Чтобы включить логирование с помощью [AWS CLI](../../tools/aws-cli.md):

     1. Создайте файл с настройками логирования в формате JSON. Например:

         ```json
         {
            "LoggingEnabled": {
               "TargetBucket": "<имя_целевого_бакета>",
               "TargetPrefix": "<префикс_ключа>"
            }
         }
         ```

         Где:

         * `TargetBucket` — имя целевого бакета, в который будут записываться логи.
         * `TargetPrefix` — [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например, `logs/`.
     
     1. Включите логирование в бакете:

         ```bash
         aws s3api put-bucket-logging \
           --bucket <имя_исходного_бакета> \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket-logging-status file://<путь_к_файлу_настроек>
         ```

         Где:

         * `--bucket` — имя исходного бакета, для которого нужно включить логирование действий.
         * `--bucket-logging-status` — путь к файлу с настройками логирования.

   - {{ TF }} {#tf}

     {% note info %}
     
     Если вы работаете с {{ objstorage-name }} через {{ TF }} от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
     
     {% endnote %}

     [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
     
     {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
     
     Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

     
     Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
     
     
     Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.



     Чтобы включить механизм логирования в бакете, который вы хотите отслеживать:

     1. Откройте файл конфигурации {{ TF }} и добавьте блок `logging` во фрагмент с описанием бакета.

        ```hcl
        resource "yandex_storage_bucket" "log_bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_бакета_для_хранения_логов>"
        }

        resource "yandex_storage_bucket" "bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_исходного_бакета>"
          acl        = "private"

          logging {
            target_bucket = yandex_storage_bucket.log_bucket.id
            target_prefix = "log/"
          }
        }
        ```

        Где:
        * `access_key` — идентификатор статического ключа доступа.

           {% note info %}
           
           Кроме статических ключей доступа для аутентификации в {{ objstorage-name }} можно использовать IAM-токен. Подробнее смотрите в разделе [{#T}](create.md) и в [документации провайдера]({{ tf-provider-resources-link }}/storage_object). 
           
           {% endnote %}

        * `secret_key` — значение секретного ключа доступа.
        * `target_bucket` — указание на бакет для хранения логов.
        * `target_prefix` — [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.

        Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#enable-logging).

     1. Примените изменения:

        1. В терминале перейдите в директорию с конфигурационным файлом.
        1. Проверьте корректность конфигурации с помощью команды:
        
           ```bash
           terraform validate
           ```
        
           Если конфигурация является корректной, появится сообщение:
        
           ```bash
           Success! The configuration is valid.
           ```
        
        1. Выполните команду:
        
           ```bash
           terraform plan
           ```
        
           В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
        1. Примените изменения конфигурации:
        
           ```bash
           terraform apply
           ```
        
        1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

   - API {#api}

     Чтобы включить механизм логирования в бакете, воспользуйтесь методом S3 API [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md).

     Пример тела HTTP-запроса:

     ```xml
     <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
       <LoggingEnabled>
         <TargetBucket>имя целевого бакета</TargetBucket>
         <TargetPrefix>префикс ключа</TargetPrefix>
       </LoggingEnabled>
     </BucketLoggingStatus>
     ```

     Где:

     * `TargetBucket` – имя целевого бакета;
     * `TargetPrefix` – [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.

   {% endlist %}

Если вы захотите удалить целевой бакет, сначала [выключите механизм логирования](#stop-logging) или выберите другой целевой бакет для хранения логов. [Удалить](delete.md) можно только пустой бакет.

## Получите настройки логирования {#get-settings}

Чтобы получить имя целевого бакета и префикс ключа объекта с логами, выполните следующее действие:

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Выберите исходный бакет.
   1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
   1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}**
   1. В списке **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_target-bucket_jEJ5E }}** содержится имя целевого бакета.
   1. В поле **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_prefix_4JTZG }}** содержится префикс, с которым сохраняются логи.

- AWS CLI {#cli}

   Чтобы получить настройки логирования с помощью [AWS CLI](../../tools/aws-cli.md):

   Выполните команду:

   ```bash
   aws s3api get-bucket-logging \
     --bucket <имя_бакета> \
     --output json \
     --endpoint-url https://{{ s3-storage-host }}
   ```

   Результат:

   ```json
   {
       "LoggingEnabled": {
         "TargetBucket": "<имя_бакета>",
         "TargetPrefix": "<префикс_ключа>"
       }
   }
   ```

- {{ TF }} {#tf}


  Чтобы получить настройки логирования в бакете, который вы хотите отслеживать:

     1. Откройте файл конфигурации {{ TF }} и найдите блок `logging` в фрагменте с описанием бакета.

        ```hcl
        resource "yandex_storage_bucket" "log_bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_бакета_для_хранения_логов>"
        }

        resource "yandex_storage_bucket" "bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_исходного_бакета>"
          acl        = "private"

          logging {
            target_bucket = yandex_storage_bucket.log_bucket.id
            target_prefix = "log/"
          }
        }
        ```

        Где:
        * `access_key` — идентификатор статического ключа доступа.
        * `secret_key` — значение секретного ключа доступа.
        * `target_bucket` — указание на бакет для хранения логов.
        * `target_prefix` — [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.

        Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#enable-logging).

  1. Примените изменения:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом S3 API [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md).

  Пример тела HTTP-ответа:

  ```xml
  HTTP/1.1 200
  <?xml version="1.0" encoding="UTF-8"?>
  <BucketLoggingStatus>
     <LoggingEnabled>
        <TargetBucket>имя целевого бакета</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
     </LoggingEnabled>
  </BucketLoggingStatus>
  ```

{% endlist %}

## Получите логи {#get-logs}

Чтобы получить логи, скачайте из целевого бакета объект с префиксом `logs/`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите целевой бакет с логами.
  1. Перейдите в папку `logs/`.
  1. Напротив объекта с логами, который вы хотите скачать, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.storage.bucket.button_download }}**.
  
  {% note info %}

  Также чтобы скачать объекты с помощью графического интерфейса, вы можете использовать инструменты [CyberDuck](../../tools/cyberduck.md) или [WinSCP](../../tools/winscp.md).

  {% endnote %}

- AWS CLI {#cli}

  Чтобы получить логи с помощью [AWS CLI](../../tools/aws-cli.md), скачайте объекты с префиксом `logs/`, следуя [инструкции](../objects/download.md#cli). 

- API {#api}

  Воспользуйтесь методом S3 API [get](../../s3/api-ref/object/get.md) сервиса Object.

{% endlist %}

## Выключить механизм логирования {#stop-logging}

Чтобы выключить логирование, выполните следующее действие:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Выберите бакет, для которого хотите выключить логирование.
  1. На панели слева выберите ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}**.
  1. Выключите опцию **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_server-logs_mfGpj }}**.
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  Чтобы выключить логирование с помощью [AWS CLI](../../tools/aws-cli.md), воспользуйтесь командой:

     ```bash
     aws s3api put-bucket-logging \
         --bucket <имя_бакета> \
         --endpoint-url https://{{ s3-storage-host }} \
         --bucket-logging-status {}
     ```

     Где `--bucket` — имя исходного бакета, для которого нужно выключить логирование действий.

- {{ TF }} {#tf}


  Чтобы выключить механизм логирования:

  1. В файле конфигураций {{ TF }} удалите блок `logging` во фрагменте с описанием бакета.

      {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "<идентификатор_статического_ключа>"
        secret_key = "<секретный_ключ>"
        bucket     = "<имя_бакета_для_хранения_логов>"
      }

      resource "yandex_storage_bucket" "bucket" {
        access_key = "<идентификатор_статического_ключа>"
        secret_key = "<секретный_ключ>"
        bucket     = "<имя_исходного_бакета>"
        acl        = "private"

        logging {
          target_bucket = yandex_storage_bucket.log_bucket.id
          target_prefix = "log/"
        }
      }
      ...
      ```

      {% endcut %}

  1. Примените изменения в конфигурации:

     1. В терминале перейдите в директорию с конфигурационным файлом.
     1. Проверьте корректность конфигурации с помощью команды:
     
        ```bash
        terraform validate
        ```
     
        Если конфигурация является корректной, появится сообщение:
     
        ```bash
        Success! The configuration is valid.
        ```
     
     1. Выполните команду:
     
        ```bash
        terraform plan
        ```
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом S3 API [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md). В теле запроса передайте параметр `<BucketLoggingStatus>` с пустым значением.

  Пример тела HTTP-запроса:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
  ```

{% endlist %}