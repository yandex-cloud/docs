---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Изменение реестра

Вы можете изменить [имя](registry-update.md#update-name) или [описание](registry-update.md#update-description) реестра, а также [управлять метками реестра](registry-update.md#manage-label).

Для обращения к реестру используйте его уникальный идентификатор или имя. Как узнать уникальный идентификатор или имя реестра, читайте в разделе [{#T}](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs %}

- Консоль управления

   Чтобы изменить имя реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить имя реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Имя**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените имя реестра:

  ```
  $ yc iot registry update my-registry --new-name test-registry

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: test-registry
  ```

{% endlist %}

## Изменить описание реестра {#update-description}

{% list tabs %}

- Консоль управления

   Чтобы изменить описание реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить описание реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поле **Описание**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените описание реестра:

  ```
  $ yc iot registry update my-registry --description "My test registry."

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  description: My test registry.
  labels:
    test_label: my_registry_label
  ```

{% endlist %}

## Управлять метками реестра {#manage-label}

Вы можете выполнять следующие действия с метками реестра:

- [Добавить](registry-update.md#add-label)
- [Изменить](registry-update.md#update-label)
- [Удалить](registry-update.md#remove-label)

### Добавить метку {#add-label}

{% list tabs %}

- Консоль управления

   Чтобы добавить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите добавить метку реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Заполните поля **Ключ**, **Значение** и нажмите кнопку **Добавить метку**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Добавьте метку реестру:

  ```
  $ yc iot registry add-labels my-registry --labels new_label=test_label

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    new_label: test_label
  ```

{% endlist %}

### Изменить метку {#update-label}

{% list tabs %}

- Консоль управления

   Чтобы изменить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить метку реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Измените поля **Ключ**, **Значение**.
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Измените метку реестра:

  {% note warning %}

  Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

  {% endnote %}

  ```
  $ yc iot registry update my-registry --labels test_label=my_registry_label

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  labels:
    test_label: my_registry_label
  ```

{% endlist %}

### Удалить метку {#remove-label}

{% list tabs %}

- Консоль управления

   Чтобы удалить метку реестра:

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить метку реестра.
   1. Выберите сервис **{{ iot-name }}**.
   1. Справа от имени нужного реестра нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg), в выпадающем списке выберите **Редактировать**.
   1. Справа от удаляемой метки нажмите значок ![image](../../../_assets/cross.svg).
   1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Удалите метку реестра:

  ```
  $ yc iot registry remove-labels my-registry --labels new_label

  id: b91ki3851hab9m0l68je
  folder_id: aoek49ghmknnpj1ll45e
  created_at: "2019-05-28T11:29:42.420Z"
  name: my-registry
  ```

{% endlist %}
