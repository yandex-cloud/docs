---
title: Удаление частично загруженного объекта в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете удалить частично загруженный объект из бакета в {{ objstorage-name }}.
---

# Удаление частично загруженного объекта

Объект может быть загружен не полностью при использовании [составной загрузки](../../concepts/multipart.md).

{% include [auto-delete-all-multipart](../../../_includes/storage/auto-delete-all-multipart.md) %}

Чтобы удалить частично загруженный объект вручную:

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в бакет, содержащий частично загруженный объект.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Чтобы видеть все версии объектов в списке, справа от поля поиска объекта в бакете, включите опцию **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}**.
  1. Наведите указатель на желтое поле рядом с количеством объектов. 
  1. Нажмите появившуюся кнопку **{{ ui-key.yacloud.storage.buckets.button_open-multipart-uploads }}**.
  1. Отметьте незавершенные загрузки, которые нужно удалить.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

  В консоли управления информация о количестве объектов в бакете и занятом месте обновляется с задержкой в несколько минут.

- AWS CLI {#cli}

  Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../tools/aws-cli.md).

  Выполните следующую команду:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api abort-multipart-upload \
    --bucket <имя_бакета> \
    --key <ключ_объекта> \
    --upload-id <идентификатор_загрузки>
  ```

  Если вы не знаете идентификатор загрузки (`number`), найдите его в списке загрузок.

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api list-multipart-uploads \
    --bucket <имя_бакета>
  ```

- API {#api}

  Воспользуйтесь методом S3 API [abortUpload](../../s3/api-ref/multipart/abortupload.md).

{% endlist %}

