---
title: Как создать загрузочный образ в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете создать собственный загрузочный ISO-образ в {{ baremetal-name }}, чтобы запустить с него сервер.
---

# Создать загрузочный образ

Вы можете добавить [собственный загрузочный ISO-образ](../concepts/images.md#user-images), чтобы запускать с него сервер. Для этого нужно сначала загрузить файл образа в [бакет](../../storage/concepts/bucket.md) сервиса {{ objstorage-full-name }}.

## Загрузите файл образа в {{ objstorage-name }} {#upload-file}

{% note alert %}

Размер загружаемого в {{ objstorage-name }} файла образа не может превышать 50 ГБ.

{% endnote %}

{% include [upload-iso-to-bucket](../../_includes/baremetal/upload-iso-to-bucket.md) %}

## Создайте загрузочный образ в {{ baremetal-name }} {#create-image}

Создайте новый загрузочный образ с помощью ссылки, полученной в {{ objstorage-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать образ.
  1. [Перейдите]({{ link-console-main }}/link/baremetal) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.baremetal.label_images_duoXD }}**.
  1. Нажмите кнопку **Загрузить образ**.
  1. Введите имя образа. Требования к имени:

       {% include [name-format](../../_includes/name-format.md) %}

  1. (Опционально) Добавьте описание образа.
  1. Вставьте ссылку на образ, полученную в {{ objstorage-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-image }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для создания загрузочного образа:

      ```bash
      yc baremetal v2 boot-image create --help
      ```

   1. Создайте загрузочный образ:

      ```bash
      yc baremetal v2 boot-image create \
        --boot-image '{
          name="demo-boot-image",
          description="Boot image for BareMetal",
          uri="<ссылка_на_образ>",
          annotations={<ключ_метки>="<значение_метки>"}
        }'
      ```

      В объекте `--boot-image` укажите:

      * `name` — имя образа. Требования к имени:
        
        {% include [name-format](../../_includes/name-format.md) %}

      * `description` — описание образа. Необязательный параметр.
      * `uri` — ссылка на образ, полученная в {{ objstorage-name }}.
      * `annotations` — метки образа. Необязательный параметр.

- API {#api}

  Чтобы создать загрузочный образ в {{ baremetal-name }}, воспользуйтесь методом REST API [create](../api-ref/Image/create.md) для ресурса [Image](../api-ref/Image/index.md) или вызовом gRPC API [ImageService/Create](../api-ref/grpc/Image/create.md).
  
  {% include [create-baremetal-image-api](../../_includes/baremetal/create-baremetal-image-api.md) %}

{% endlist %}

## Удалите образ из {{ objstorage-name }} (опционально) {#delete-image}

После создания загрузочного образа в {{ baremetal-name }} можно [удалить файл образа](../../storage/operations/objects/delete.md) из сервиса {{ objstorage-name }}. Также можно [удалить бакет](../../storage/operations/buckets/delete.md), если в нем не осталось объектов.
