---
title: "Инструкция по скачиванию объекта из бакета {{ objstorage-full-name }}"
description: "Из статьи вы узнаете, как скачать объект в {{ objstorage-full-name }}."
---

# Скачивание объекта


{% list tabs %}

- Консоль управления
  
  1. В [консоли управления]({{ link-console-main }}) выберите каталог.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя необходимого бакета.
  1. Нажмите на имя объекта.
  1. В правом верхнем углу нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.file.button_download }}**.

- API

  Чтобы скачать объект, воспользуйтесь методом S3 API [get](../../s3/api-ref/object/get.md).

{% endlist %}
