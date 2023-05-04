# Работа с секретами

[Секреты](../../concepts/secrets.md) позволяют хранить чувствительные данные в зашифрованном виде и безопасно использовать их в коде проекта.

## Создать секрет {#create}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. В поле **{{ ui-key.yc-ui-datasphere.secret.name }}** задайте имя секрета.

   Имя может содержать строчные и заглавные буквы латинского алфавита, цифры и дефисы. Первый символ должен быть буквой. Последний символ не должен быть дефисом или нижним подчеркиванием. Допустимая длина – от 3 до 63 символов.

1. В поле **{{ ui-key.yc-ui-datasphere.secret.content }}** введите значение, которое будет храниться в зашифрованном виде.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном секрете.

## Поделиться секретом {#share}

Поделиться секретом в сообществе может только администратор сообщества. Подробнее о ролях, действующих в {{ ml-platform-name }}, см. в разделе [{#T}](../../security/index.md).

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Выберите нужный секрет в списке.
1. Перейдите на вкладку **{{ ui-key.yc-ui-datasphere.common.access }}**.
1. Включите опцию видимости напротив названия сообщества, в котором нужно поделиться секретом.

## Вызвать секрет в ячейке проекта {#call}

Созданный секрет можно использовать в ячейках проекта как переменные окружения.

{% list tabs %}

- Python

   ```python
   import os
   os.environ # Получить список всех переменных окружения
   os.environ['<имя_секрета>'] # Обратиться к секрету <имя_секрета> из переменных окружения
   ```

- bash

   ```bash
   #!:bash
   printenv <имя_секрета>
   ```

{% endlist %}

## Копировать секрет {#copy}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. В списке секретов выберите тот, который вы хотите скопировать в свой проект, нажмите ![options](../../../_assets/options.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.clone }}**.
1. Отредактируйте имя и контент секрета для копирования.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.create }}**. Откроется страница с информацией о созданном секрете.

{% include [context-copy-and-original-secret](../../../_includes/datasphere/context-copy-and-original-secret.md) %}

## Изменить секрет {#change}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. В списке секретов выберите тот, который вы хотите изменить, нажмите ![options](../../../_assets/options.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.edit }}**.
1. Измените секрет: отредактируйте имя и контент.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.save }}**.

{% include [other-project-secret-edit-rule](../../../_includes/datasphere/other-project-secret-edit-rule.md) %}

## Удалить секрет {#delete}

1. {% include [find project](../../../_includes/datasphere/ui-find-project.md) %}
1. В блоке **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}** нажмите ![secret](../../../_assets/datasphere/jupyterlab/secret.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. В списке секретов выберите тот, который хотите удалить, нажмите ![options](../../../_assets/options.svg) и выберите **{{ ui-key.yc-ui-datasphere.common.delete }}**.
1. Нажмите **{{ ui-key.yc-ui-datasphere.common.submit }}**.

Отобразится сообщение о том, что секрет удален. 