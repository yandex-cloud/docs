# Создание реестра

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Создайте реестр:
  
     ```
     $ yc iot registry create --name my-registry
  
      id: b91ki3851hab9m0l68je
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2019-05-28T11:29:42.420Z"
      name: my-registry
     ```
  
     {% include [name-format](../../../_includes/name-format.md) %}
  
  1. Проверьте, что реестр создался:
  
      ```
      $ yc iot registry list
       +----------------------+-------------+
       |          ID          |    NAME     |
       +----------------------+-------------+
       | b91ki3851hab9m0l68je | my-registry |
       +----------------------+-------------+
      ```
  
{% endlist %}
