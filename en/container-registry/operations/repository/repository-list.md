# Getting a list of repositories in a registry

{% list tabs %}

- CLI
  
  {% include [cli-install](../../../_includes/cli-install.md) %}
  
  Get the list of repositories in the registry:
  
  ```
  $ yc container repository list 
  +-----------------------------+
  |            NAME             |
  +-----------------------------+
  | crp3qleutgksvd1prhvb/ubuntu |
  +-----------------------------+
  ```
  
- API
  
  You can get a list of repositories in a registry by using the [list](../../api-ref/Repository/list.md) method for the [Repository](../../api-ref/Repository/) resource.
  
{% endlist %}

