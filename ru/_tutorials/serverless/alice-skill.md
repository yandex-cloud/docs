# Создание навыка Алисы


В качестве примера будет создан навык <q>Попугай</q>, который повторяет все, что ему написал или сказал пользователь. Пример реализован на двух языках программирования: Python и Node.js.

Чтобы добавить навык Алисы на основе [функции](../../functions/concepts/function.md):

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте код навыка](#prepare-code).
1. [Создайте функцию и версию функции](#create-function).
1. [Добавьте ссылку на функцию в навык Алисы](#add-link).
1. [Протестируйте работу навыка](#test).

Если созданные ресурсы больше не нужны, [удалите](#clear-out) их.

Подробнее о [разработке навыка Алисы](https://yandex.ru/dev/dialogs/alice/doc/development-docpage/#test__dev-cycle).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Подготовьте код для навыка Алисы {#prepare-code}

Для создания [версии](../../functions/concepts/function.md#version) функции вы можете воспользоваться одним из [форматов загрузки кода](../../functions/concepts/function.md#upload). Для примера код будет загружен в формате ZIP-архива.

{% list tabs group=programming_language %}

- Python {#python}

    1. Скачайте с GitHub файл с примером: [parrot.py](https://github.com/yandex-cloud-examples/yc-alice-skill-python/blob/main/parrot/parrot.py).
    1. Создайте ZIP-архив `parrot-py.zip` с файлом `parrot.py`.

- Node.js {#node}

    1. Скачайте с GitHub файл с примером: [index.js](https://github.com/yandex-cloud-examples/yc-alice-skill-node/blob/main/parrot/index.js).
    1. Создайте ZIP-архив `parrot-js.zip` с файлом `index.js`.

{% endlist %}

## Создайте функцию и версию функции {#create-function}

После создания функция будет содержать только информацию о себе: имя, описание, уникальный идентификатор и т. д. Непосредственно код навыка будет добавлен в версию функции.

1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана функция.
1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите ![curly-brackets-function](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.iam.folder.dashboard.value_serverless-functions }}**.
1. Введите имя функции. Требования к имени:

    {% include [name-format](../../_includes/name-format.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
1. Создайте [версию функции](../../functions/concepts/function.md#version):

    {% list tabs group=programming_language %}

    - Python {#python}

      1. В списке языков программирования выберите `{{ python-full-ver }}`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Подготовьте код функции:

          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и прикрепите созданный ранее архив `parrot-py.zip`.
          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `parrot.handler`.
      1. Задайте параметры версии:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
          * Значение остальных параметров оставьте по умолчанию.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

    - Node.js {#node}

      1. В списке языков программирования выберите `{{ nodejs-full-ver }}`.
      1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Подготовьте код функции:

          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и прикрепите созданный ранее архив `parrot-js.zip`.
          * В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** укажите `index.handler`.
      1. Задайте параметры версии:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `2`.
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud_portal.common.units.label_megabyte }}`.
          * Значение остальных параметров оставьте по умолчанию.
      1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

    {% endlist %}

## Добавьте ссылку на функцию в навык Алисы {#add-link}

1. Перейдите на страницу навыка Алисы в [личном кабинете](https://dialogs.yandex.ru/developer/).
1. Нажмите **Создать диалог**. В открывшемся окне выберите **Навык**.
1. На вкладке **Настройки**:

    1. В поле **Имя навыка** задайте уникальное имя создаваемого навыка.
    1. В поле **Backend** выберите вариант **Функция в {{ yandex-cloud }}**. В выпадающем списке выберите созданную ранее функцию.

    {% note warning %}
    
    В списке отображаются функции, которые вы имеете право просматривать. Чтобы прикрепить функцию к навыку, вам необходимо разрешение на запуск функции. Это разрешение входит в роли [{{ roles-functions-invoker }}](../../functions/security/index.md#serverless-functions-invoker), [{{ roles-editor }}](../../functions/security/index.md#functions-editor) и выше.
    
    {% endnote %}

    1. Внизу страницы нажмите кнопку **Сохранить**.

## Протестируйте работу навыка {#test}

1. Откройте вкладку **Тестирование** на странице навыка в [личном кабинете](https://dialogs.yandex.ru/developer/).
1. Если все настроено правильно, в разделе **Чат** будет сообщение с приглашением начать беседу: `Hello! I'll repeat anything you say to me.`. 
1. Отправьте сообщение с любым текстом и убедитесь, что вам пришел ответ с таким же содержанием.

## Как удалить созданные ресурсы {#clear-out}

Чтобы прекратить работу навыка, [удалите](../../functions/operations/function/function-delete.md) функцию.