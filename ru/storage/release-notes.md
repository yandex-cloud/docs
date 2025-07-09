---
title: История изменений в {{ objstorage-full-name }}
description: В разделе представлена история изменений сервиса {{ objstorage-name }}.
---

# История изменений в {{ objstorage-full-name }}

## II квартал 2025 {#q2-2025}

* В [консоли управления]({{ link-console-main }}) появилась возможность включить [шифрование](./concepts/encryption.md) и [версионирование](./concepts/versioning.md) при создании [бакета](./concepts/bucket.md).
* В [{{ yandex-cloud }} CLI](../cli/quickstart.md) добавлены команды:
  * [yc storage s3api get-bucket-acl](./cli-ref/s3api/get-bucket-acl.md) — для получения [ACL](./security/acl.md) бакета;
  * [yc storage s3api put-bucket-acl](./cli-ref/s3api/put-bucket-acl.md) — для изменения ACL бакета;
  * [yc storage s3api get-object-acl](./cli-ref/s3api/get-object-acl.md) — для получения ACL [объекта](./concepts/object.md);
  * [yc storage s3api put-object-acl](./cli-ref/s3api/put-object-acl.md) — для изменения ACL объекта;
  * [yc storage s3api list-objects](./cli-ref/s3api/list-objects.md) — для получения списка объектов;
  * [yc storage s3 cp](./cli-ref/s3/cp.md) — для копирования объектов;
  * [yc storage s3 mv](./cli-ref/s3/mv.md) — для перемещения объектов;
  * [yc storage s3 rm](./cli-ref/s3/rm.md) — для удаления объектов.
* В провайдер [{{ TF }}](../tutorials/infrastructure-management/terraform-quickstart.md) включены новые ресурсы:
  * [yandex_storage_bucket_grant]({{ tf-provider-resources-link }}/storage_bucket_grant) — для управления [ACL](./security/acl.md) бакета с помощью отдельного ресурса.
  * [yandex_storage_bucket_iam_binding]({{ tf-provider-resources-link }}/storage_bucket_iam_binding) — для назначения пользователям [ролей](./security/index.md) {{ iam-full-name }} на конкретный бакет.
* Реализована возможность организации доступа к бакету только из [сервисных подключений {{ vpc-short-name }}](../vpc/concepts/private-endpoint.md).
* Добавлена возможность просмотра [меток](./concepts/tags.md) бакета пользователями с [ролью](./security/index.md#storage-config-viewer) `storage.configViewer`.

## I квартал 2025 {#q1-2025}

* В [{{ yandex-cloud }} CLI](../cli/quickstart.md) добавлена поддержка команд для работы с [метками объектов](./concepts/tags.md#object-tags), а также с [составной загрузкой объектов](./concepts/multipart.md).
* Реализована возможность аутентификации в {{ objstorage-name }} из {{ TF }} с помощью [IAM-токена](../iam/concepts/authorization/iam-token.md). Подробнее см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket).
* Поддержана работа сервиса с актуальными версиями [AWS SDK](./tools/sdk/index.md) и [AWS CLI](./tools/aws-cli.md).

## IV квартал 2024 {#q4-2024}

* Анонсировано прекращение поддержки протокола TLS версий 1.0 и 1.1 с 1 июля 2025 года. Подробнее см. на странице [{#T}](./concepts/tls.md).
* В [{{ yandex-cloud }} CLI](../cli/quickstart.md) добавлена группа команд [yc storage s3api](../cli/cli-ref/storage/cli-ref/s3api/index.md) для работы с [объектами](./concepts/object.md).

## III квартал 2024 {#q3-2024}

* Добавлена поддержка доступа к сервису с помощью [временных ключей {{ sts-name }}](./operations/buckets/create-sts-key.md).
* Реализована функциональность прямого доступа к бакетам из облачных сетей с помощью [сервисного подключения {{ vpc-full-name }}](./operations/buckets/access-via-vpc.md) без использования доступа в интернет. В [политику доступа (bucket policy)](./security/policy.md) добавлено специальное условие `yc:private-endpoint-id` для осуществления доступа к бакету только по внутренним IP-адресам {{ vpc-short-name }}.

## II квартал 2024 {#q2-2024}

Улучшен дизайн консоли управления: настройки бакета теперь сгруппированы на вкладках ![image](../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}** и ![image](../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.

## I квартал 2024 {#q1-2024}

* Улучшена работа с [жизненными циклами](./concepts/lifecycles.md) объектов в бакете:
  * добавлена поддержка новых фильтров для группировки объектов: [метки объекта](./concepts/tags.md#object-tags) и оператор `AND`.
  * работа с новыми фильтрами реализована в консоли управления, CLI, {{ TF }} и с помощью [инструментов](./tools/) с поддержкой S3 API.
* Поддержана работа с [метками бакета](./concepts/tags.md#bucket-tags) в консоли управления, CLI и {{ TF }}.
* Реализована возможность добавлять [группы пользователей](../organization/concepts/groups.md) {{ org-full-name }} в [список управления доступом (ACL)](./security/acl.md) и [политику доступа (bucket policy)](./security/policy.md) в консоли управления, CLI и {{ TF }}.
* Улучшена работа в консоли управления:
  * добавлен фильтр по префиксу в списке объектов бакета;
  * добавлена возможность скачивания объектов из списка.
