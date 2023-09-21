---
title: "Создание навыка Алисы"
description: "Пример создания навыка Алисы на двух языках программирования: Python и Node.js. В качестве примера будет создан навык Алисы — <q>Попугай</q>, который повторяет все, что ему написал или сказал пользователь."
keywords:
  - создание навыка алисы
  - навык алисы
  - пример создания навыка алисы
---

# Создание навыка Алисы

В качестве примера будет создан навык <q>Попугай</q>, который повторяет все, что ему написал или сказал пользователь. Пример реализован на двух языках программирования: Python и Node.js.

Чтобы добавить навык Алисы на основе [функции](../concepts/function.md):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте код навыка](#prepare-code).
1. [Создайте функцию](#create-function).
1. [Создайте версию функции](#create-version). 
1. [Добавьте ссылку на функцию в навык Алисы](#add-link).
1. [Протестируйте работу навыка](#test).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

Подробнее о [разработке навыка Алисы](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте код для навыка Алисы {#prepare-code}

Для создания [версии](../../functions/concepts/function.md#version) функции вы можете воспользоваться одним из [форматов загрузки кода](../../functions/concepts/function.md#upload). Для примера код будет загружен в формате ZIP-архива.

{% list tabs %}

- Python

    1. Скачайте с GitHub файл с примером: [parrot.py](https://github.com/yandex-cloud/examples/blob/master/serverless/functions/alice/python/parrot/parrot.py).
    1. Создайте ZIP-архив `parrot-py.zip` с файлом `parrot.py`.

- Node.js

    1. Скачайте с GitHub файл с примером: [index.js](https://github.com/yandex-cloud/examples/blob/master/serverless/functions/alice/nodejs/parrot/index.js).
    1. Создайте ZIP-архив `parrot-js.zip` с файлом `index.js`.

{% endlist %}

## Создайте функцию {#create-function}

После создания функция будет содержать только информацию о себе: имя, описание, уникальный идентификатор и т. д. Непосредственно код навыка будет добавлен в функцию на шаге [создания версии](#create-version).

1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создана функция.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}**.
1. Выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
1. Введите имя функции. Требования к нему:

    {% include [name-format](../../_includes/name-format.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

## Создайте версию функции {#create-version}

Выберите язык программирования и создайте [версию функции](../concepts/function.md#version).

{% list tabs %}

- Python

  1. В [консоли управления]({{ link-console-main }}) откройте **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** в каталоге, где вы хотите создать версию функции.
  1. Выберите функцию, для которой необходимо создать версию.
  1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
  1. Задайте параметры версии:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python37`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
  1. Подготовьте код функции:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: `parrot-py.zip`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `parrot.handler`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- Node.js

  1. В [консоли управления]({{ link-console-main }}) откройте **{{ sf-name }}** в каталоге, где вы хотите создать версию функции.
  1. Выберите функцию, для которой необходимо создать версию.
  1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
  1. Задайте параметры версии:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs12`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
  1. Подготовьте код функции:
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: `parrot-js.zip`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}

## Добавьте ссылку на функцию в навык Алисы {#add-link}

1. Перейдите на страницу навыка Алисы в [личном кабинете](https://dialogs.yandex.ru/developer/).
1. Нажмите **Создать диалог**. В открывшемся окне выберите **Навык в Алисе**.
1. На вкладке **Настройки**, в поле **Backend**, выберите вариант **Функция в {{ yandex-cloud }}**. В выпадающем списке выберите нужную функцию.

    {% note warning %}
    
    В списке отображаются функции, которые вы имеете право просматривать. Чтобы прикрепить функцию к навыку, вам необходимо разрешение на запуск функции. Это разрешение входит в роли [{{ roles-functions-ivoker }}](../security/index.md#serverless-functions-invoker), [{{ roles-editor}} ](../security/index.md#functions-editor) и выше.
    
    {% endnote %}
1. Нажмите кнопку **Сохранить** внизу страницы и сохраните изменения.

## Протестируйте работу навыка {#test}

1. Откройте вкладку **Тестирование** на странице навыка в [личном кабинете](https://dialogs.yandex.ru/developer/).
1. Если все настроено правильно, в разделе **Чат** будет сообщение с приглашением начать беседу: `Hello! I'll repeat anything you say to me.`. 
1. Отправьте сообщение с любым текстом и убедитесь, что вам пришел ответ с таким же содержанием.

## Как удалить созданные ресурсы {#clear-out}

Чтобы прекратить работу навыка, [удалите](../operations/function/function-delete.md) функцию.