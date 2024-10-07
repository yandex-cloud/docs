---
title: Получение информации об объекте в бакете в {{ objstorage-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию об объекте в бакете в {{ objstorage-name }}.
---

# Получение информации об объекте

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) в списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** и перейдите в нужный бакет.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Нажмите на имя нужного объекта.
  
- API {#api}

  Чтобы получить информацию об объекте, воспользуйтесь методом S3 API [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md).

{% endlist %}
