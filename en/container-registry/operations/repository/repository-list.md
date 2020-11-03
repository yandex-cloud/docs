# Getting information about existing repositories

Find out how to get:

* [A list of repositories in a registry](#repository-list)
* [Information about a repository by its name](#repository-get-by-name)

## Getting a list of repositories in a registry {#repository-list}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get a list of repositories in the current registry:

  ```
  $ yc container repository list
  +----------------------+-----------------------------+
  |          ID          |               NAME          |
  +----------------------+-----------------------------+
  | crt3cpm16edqql0t30s2 | crp2hlbs67tj4ggrfodb/ubuntu |
  +----------------------+-----------------------------+
  ```

- API

  You can get a list of repositories in a registry by using the [list](../../api-ref/Repository/list.md) method for the [Repository](../../api-ref/Repository/) resource.

{% endlist %}

## Getting information about a repository by its name {#repository-get-by-name}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get information about a repository passing its name as an argument (starting with the registry ID):

  ```
  $ yc container repository get crp2hlbs67tj4ggrfodb/ubuntu
  name: crp2hlbs67tj4ggrfodb/ubuntu
  id: crt3cpm16edqql0t30s2
  ```

{% endlist %}