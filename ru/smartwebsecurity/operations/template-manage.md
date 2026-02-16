---
title: Как изменить и удалить шаблон ответа
description: Следуя данной инструкции, вы сможете изменить параметры или удалить шаблон страницы ответа на запрос клиента.
---

# Управлять шаблоном страницы ответа

## Изменить шаблон {#change-template}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с шаблоном.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите **Шаблоны ответов**.
  1. В строке с нужным шаблоном нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне измените параметры:

       * **Имя страницы**.
       * **Описание**.
       * **Код ответа** — один из стандартных [HTTP-кодов ответов](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), для которого клиенту будет возвращена страница по вашему шаблону.
       * **Формат ответа**: **HTML**, **JSON**, **XML** или **Custom**.

          Каждому из форматов будет соответствовать свой HTTP-заголовок [Content-Type](https://www.rfc-editor.org/rfc/rfc9110.html#name-content-type): `text/html`, `application/json`, `application/xml`.

          Чтобы указать произвольный заголовок, выберите **Custom**. Для формата **Custom** можно изменить **Content-Type**.

       * Чтобы добавить HTTP-заголовок, нажмите **Добавить заголовок ответа** и укажите его **Ключ** (название заголовка) и **Значение**. Для одного шаблона можно добавить не более 10 заголовков.
       
          Чтобы удалить заголовок, нажмите ![options](../../_assets/console-icons/xmark.svg) напротив его строки.
       
       * **Тело ответа** — измените содержимое страницы, которое будет возвращено клиенту. Объем ответа должен быть не более `2 КБ` (примерно 2000 символов в кодировке UTF-8). Вводите содержимое в соответствии с выбранным форматом ответа и сохранением разметки.
       * Добавьте или удалите из тела ответа пресеты — дополнительные параметры, которые могут передаваться клиенту на странице ответа.

  1. Чтобы увидеть финальную страницу на стороне клиента, вверху справа нажмите **Предпросмотр**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Получить информацию о шаблоне {#get-template-info}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с шаблоном.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите **Шаблоны ответов**.
  1. Выберите нужный шаблон.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о шаблоне.

{% endlist %}


## Удалить шаблон {#delete-template}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) с шаблоном.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите **Шаблоны ответов**.
  1. В строке с нужным шаблоном нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

   Если шаблон добавлен в профиль или правило, удалить его нельзя. При попытке удаления появится список объектов с этим шаблоном. Перейдите в настройки каждого объекта и выберите другой шаблон.

{% endlist %}
