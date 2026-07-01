# История изменений в Yandex Object Storage

## I квартал 2026 {#q1-2026}

* Функциональность [выгрузки метаданных объектов (S3 Inventory)](concepts/s3-inventory.md) перешла на стадию [General Availability](../overview/concepts/launch-stages.md) в [регионе Россия](../overview/concepts/region.md), и за ее использование теперь взимается плата в соответствии с [правилами тарификации](./pricing.md). [Управлять конфигурациями выгрузки](operations/buckets/manage-s3-inventory.md) можно с помощью [Yandex Cloud CLI](cli-ref/bucket/create-inventory-configuration.md) и [API](api-ref/Bucket/createInventoryConfiguration.md).
* Появилась возможность [получить подписанную ссылку (pre-signed URL) на загрузку объекта](operations/objects/link-for-upload.md) в бакет с ограниченным доступом с помощью [Yandex Cloud CLI](cli-ref/s3/presign.md).

## IV квартал 2025 {#q4-2025}

* Поддержана [аутентификация в Object Storage](api-ref/authentication.md) с помощью [IAM-токена](../iam/concepts/authorization/iam-token.md) и [эфемерных ключей доступа](operations/buckets/manage-ephemeral-keys.md).
* Реализована возможность [запретить доступ в бакет с помощью статических ключей](operations/buckets/disable-statickey-auth.md).
* Добавлены параметры политики доступа для [обязательного использования условной записи объектов](concepts/policy.md#conditional-writes-rules).
* Появилась возможность при [настройке доступа в бакет только из сервисных подключений VPC на уровне сервиса](operations/buckets/access-via-vpc.md#enable-service-restriction) оставить бакет доступным через [консоль управления](https://console.yandex.cloud).
* Реализована функциональность настройки сервисных подключений VPC в [консоли управления](https://console.yandex.cloud).
* Добавлены новые [условия](s3/api-ref/policy/conditions.md) для политики доступа:
  * `yc:originip` — сравнивает исходный IP-адрес, с которого пришел запрос, с заданным в политике. 
  
    В отличие от условия `aws:sourceip` _не учитываются_ IP-адреса обратных прокси-серверов, например переданных в заголовке `X-Forwarded-For`.
  * `yc:access-key-id` — сравнивает идентификатор [статического ключа доступа](../iam/concepts/authorization/access-key.md) с заданным в политике.
* Поддержано использование query-параметра `range` в методах S3 API для работы с объектами [Get](s3/api-ref/object/get.md) и [getObjectMeta](s3/api-ref/object/getobjectmeta.md).
* В команде Yandex Cloud CLI `yc storage s3 cp`:
  * Исправлена ошибка фильтрации загружаемых объектов.
  * Добавлена проверка на максимальный размер объекта.

## III квартал 2025 {#q3-2025}

* Прекращена поддержка протокола TLS версий 1.0 и 1.1.
* В S3 API реализована поддержка [условий записи объектов (conditional writes)](concepts/object.md#conditional-writes).
* В провайдер Terraform добавлены новые ресурсы:
  * [yandex_storage_bucket_iam_binding](../terraform/resources/storage_bucket_iam_binding.md) — [настройка](operations/buckets/iam-access.md) прав доступа к бакету с помощью Identity and Access Management;
  * [yandex_storage_bucket_grant](../terraform/resources/storage_bucket_grant.md) — [настройка](operations/buckets/edit-acl.md) прав доступа к бакету с помощью [ACL Object Storage](concepts/acl.md);
  * [yandex_storage_bucket_policy](../terraform/resources/storage_bucket_policy.md) — [управление](operations/buckets/policy.md) политикой доступа ([bucket policy](concepts/policy.md)) бакета.
* В [Yandex Cloud CLI](../cli/quickstart.md) добавлена команда [yc storage s3 presign](cli-ref/s3/presign.md) — для создания [подписанных (pre-signed) URL](concepts/pre-signed-urls.md).
* В командах Yandex Cloud CLI [yc storage bucket create](cli-ref/bucket/create.md) и [yc storage bucket update](cli-ref/bucket/update.md) добавлен параметр `--tags` для управления [метками](concepts/tags.md) бакета.
* Исправлена ошибка, при которой в некоторых случаях при удалении объектов по префиксу через консоль управления не учитывались правила политики доступа.

## II квартал 2025 {#q2-2025}

* В [консоли управления](https://console.yandex.cloud) появилась возможность включить [шифрование](concepts/encryption.md) и [версионирование](concepts/versioning.md) при создании [бакета](concepts/bucket.md).
* В [Yandex Cloud CLI](../cli/quickstart.md) добавлены команды:
  * [yc storage s3api get-bucket-acl](cli-ref/s3api/get-bucket-acl.md) — для получения [ACL](security/acl.md) бакета;
  * [yc storage s3api put-bucket-acl](cli-ref/s3api/put-bucket-acl.md) — для изменения ACL бакета;
  * [yc storage s3api get-object-acl](cli-ref/s3api/get-object-acl.md) — для получения ACL [объекта](concepts/object.md);
  * [yc storage s3api put-object-acl](cli-ref/s3api/put-object-acl.md) — для изменения ACL объекта;
  * [yc storage s3api list-objects](cli-ref/s3api/list-objects.md) — для получения списка объектов;
  * [yc storage s3 cp](cli-ref/s3/cp.md) — для копирования объектов;
  * [yc storage s3 mv](cli-ref/s3/mv.md) — для перемещения объектов;
  * [yc storage s3 rm](cli-ref/s3/rm.md) — для удаления объектов.
* В провайдер [Terraform](../tutorials/infrastructure-management/terraform-quickstart.md) включены новые ресурсы:
  * [yandex_storage_bucket_grant](../terraform/resources/storage_bucket_grant.md) — для [управления](operations/buckets/edit-acl.md) [ACL](security/acl.md) бакета с помощью отдельного ресурса.
  * [yandex_storage_bucket_iam_binding](../terraform/resources/storage_bucket_iam_binding.md) — для [назначения](operations/buckets/iam-access.md) пользователям [ролей](security/index.md) Yandex Identity and Access Management на конкретный бакет.
* Реализована возможность организации доступа к бакету только из [сервисных подключений VPC](../vpc/concepts/private-endpoint.md).
* Добавлена возможность просмотра [меток](concepts/tags.md) бакета пользователями с [ролью](security/index.md#storage-config-viewer) `storage.configViewer`.

## I квартал 2025 {#q1-2025}

* В [Yandex Cloud CLI](../cli/quickstart.md) добавлена поддержка команд для работы с [метками объектов](concepts/tags.md#object-tags), а также с [составной загрузкой объектов](concepts/multipart.md).
* Реализована возможность аутентификации в Object Storage из Terraform с помощью [IAM-токена](../iam/concepts/authorization/iam-token.md). Подробнее читайте в [документации провайдера](../terraform/resources/storage_bucket.md).
* Поддержана работа сервиса с актуальными версиями [AWS SDK](tools/sdk/index.md) и [AWS CLI](tools/aws-cli.md).

## IV квартал 2024 {#q4-2024}

* Анонсировано прекращение поддержки протокола TLS версий 1.0 и 1.1 с 1 июля 2025 года. Подробнее на странице [Протокол TLS](concepts/tls.md).
* В [Yandex Cloud CLI](../cli/quickstart.md) добавлена группа команд [yc storage s3api](../cli/cli-ref/storage/cli-ref/s3api/index.md) для работы с [объектами](concepts/object.md).

## III квартал 2024 {#q3-2024}

* Добавлена поддержка доступа к сервису с помощью [временных ключей Security Token Service](operations/buckets/create-sts-key.md).
* Реализована функциональность прямого доступа к бакетам из облачных сетей с помощью [сервисного подключения Yandex Virtual Private Cloud](operations/buckets/access-via-vpc.md) без использования доступа в интернет. В [политику доступа (bucket policy)](security/policy.md) добавлено специальное условие `yc:private-endpoint-id` для осуществления доступа к бакету только по внутренним IP-адресам VPC.

## II квартал 2024 {#q2-2024}

Улучшен дизайн консоли управления: настройки бакета теперь сгруппированы на вкладках ![image](../_assets/console-icons/wrench.svg) **Настройки** и ![image](../_assets/console-icons/persons-lock.svg) **Безопасность**.

## I квартал 2024 {#q1-2024}

* Улучшена работа с [жизненными циклами](concepts/lifecycles.md) объектов в бакете:
  * добавлена поддержка новых фильтров для группировки объектов: [метки объекта](concepts/tags.md#object-tags) и оператор `AND`.
  * работа с новыми фильтрами реализована в консоли управления, CLI, Terraform и с помощью [инструментов](tools/index.md) с поддержкой S3 API.
* Поддержана работа с [метками бакета](concepts/tags.md#bucket-tags) в консоли управления, CLI и Terraform.
* Реализована возможность добавлять [группы пользователей](../organization/concepts/groups.md) Yandex Identity Hub в [список управления доступом (ACL)](security/acl.md) и [политику доступа (bucket policy)](security/policy.md) в консоли управления, CLI и Terraform.
* Улучшена работа в консоли управления:
  * добавлен фильтр по префиксу в списке объектов бакета;
  * добавлена возможность скачивания объектов из списка.