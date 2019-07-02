# Изменить реестр

Вы можете изменить [имя](registry-update.md#update-name) или [описание](registry-update.md#update-description) реестра, а также [управлять метками реестра](registry-update.md#manage-label).

Для обращения к реестру используйте его идентификатор или имя. Как узнать идентификатор или имя реестра, читайте в разделе [#T](registry-list.md).

## Изменить имя реестра {#update-name}

{% list tabs %}

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

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Измените метку реестра:
  
  {% note important %}
  
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
