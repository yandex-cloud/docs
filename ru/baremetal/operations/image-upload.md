---
title: Как загрузить собственный образ в {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете добавить собственный образ и развернуть из него сервер.
---

# Загрузить образ

Вы можете добавить собственный образ и развернуть сервер на его основе. Для этого нужно сначала загрузить файл образа в бакет сервиса {{ objstorage-full-name }}.

## Загрузите файл образа в {{ objstorage-name }} {#upload-file}

Загрузите файл с образом в сервис {{ objstorage-name }} и получите ссылку на загруженный образ:

1. Если у вас еще нет [бакета](../../storage/concepts/bucket.md) в {{ objstorage-name }}, [создайте](../../storage/operations/buckets/create.md) его с ограниченным доступом.
1. Загрузите образ в ваш бакет, например, [через консоль управления](../../storage/operations/objects/upload.md), с помощью [AWS CLI](../../storage/tools/aws-cli.md) или [WinSCP](../../storage/tools/winscp.md). В терминах {{ objstorage-name }} загружаемый файл образа будет называться _объектом_.
1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на загруженный образ. Используйте эту ссылку при создании образа в {{ baremetal-name }}.

## Создайте образ в {{ baremetal-name }} {#create-image}

Создайте новый образ по ссылке, полученной в {{ objstorage-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать образ.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. На панели слева выберите ![icon](../../_assets/console-icons/layers.svg) **Загрузочные образы**.
  1. Нажмите кнопку **Загрузить образ**.
  1. Введите имя образа. Требования к имени:

     * длина — от 2 до 63 символов;
     * может содержать строчные буквы латинского алфавита, цифры и дефисы;
     * первый символ — буква, последний — не дефис.

  1. (Опционально) Добавьте описание образа.
  1. Вставьте ссылку на образ, полученную в {{ objstorage-name }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.images.popup-upload_button_upload }}**.

{% endlist %}

## Удалите образ из {{ objstorage-name }} {#delete-image}

После создания образа можно [удалить файл образа](../../storage/operations/objects/delete.md) из сервиса {{ objstorage-name }}. Также можно [удалить бакет](../../storage/operations/buckets/delete.md), если в нем не осталось объектов.
