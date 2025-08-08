---
title: Как загрузить собственный образ в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете добавить собственный образ и развернуть из него сервер.
---

# Загрузить образ

Вы можете добавить собственный образ и развернуть сервер на его основе. Для этого нужно сначала загрузить файл образа в бакет сервиса {{ objstorage-full-name }}.

## Загрузите файл образа в {{ objstorage-name }} {#upload-file}

{% note alert %}

Размер загружаемого в {{ objstorage-name }} файла образа не может превышать 50 ГБ.

{% endnote %}

{% include [upload-iso-to-bucket](../../_includes/baremetal/upload-iso-to-bucket.md) %}

## Создайте образ в {{ baremetal-name }} {#create-image}

Создайте новый образ по ссылке, полученной в {{ objstorage-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать образ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.baremetal.label_images }}**.
  1. Нажмите кнопку **Загрузить образ**.
  1. Введите имя образа. Требования к имени:

       {% include [name-format](../../_includes/name-format.md) %}

  1. (Опционально) Добавьте описание образа.
  1. Вставьте ссылку на образ, полученную в {{ objstorage-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.baremetal.label_create-image }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды для загрузки образа:

      ```bash
      yc baremetal boot-image create --help
      ```

   1. Загрузите образ:

      ```bash
      yc baremetal boot-image create \
        --name demo-boot-image \
        --description "Boot image for BareMetal" \
        --uri "<ссылка_на_образ>" \
        --labels <ключ_метки>=<значение_метки>
      ```

      Где:
      * `--name` — имя образа. Требования к имени:
        
        {% include [name-format](../../_includes/name-format.md) %}

      * `--description` — описание образа. Необязательный параметр.
      * `--uri` — ссылка на образ, полученная в {{ objstorage-name }}.
      * `--labels` — метки образа. Необязательный параметр.

{% endlist %}

## Удалите образ из {{ objstorage-name }} {#delete-image}

После создания образа можно [удалить файл образа](../../storage/operations/objects/delete.md) из сервиса {{ objstorage-name }}. Также можно [удалить бакет](../../storage/operations/buckets/delete.md), если в нем не осталось объектов.
