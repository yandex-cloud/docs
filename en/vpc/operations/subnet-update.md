# Updating a subnet

After creating a subnet, you can change its name, description, and tags.

{% list tabs %}

- CLI
  
  If you don't have the Yandex.Cloud command line interface yet, [install it](../../cli/quickstart#install).
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  1. See the description of the CLI command for updating subnet parameters:
  
      ```
      $ yc vpc subnet update --help
      ```
  
  1. Get a list of all subnets in the default folder:
  
      ```
      $ yc vpc subnet list
      +----------------------+-----------------------+----------------------+
      |          ID          |         NAME          |         ...          |
      +----------------------+-----------------------+----------------------+
      ...
      | e2l2prrbkbimvjuuhht2 |     test-subnet-1     |         ...          |
      ...
      +----------------------+-----------------------+----------------------+
      ```
  
  1. Select the `ID` or `NAME` of the subnet you need.
  
  1. Change the subnet parameters, for example:
  
      ```
      $ yc vpc subnet update e2l2prrbkbimvjuuhht2 \
          --new-name test-subnet-renamed \
          --labels new_label=test_label
      id: e2l2prrbkbimvjuuhht2
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-24T13:54:10Z"
      name: test-subnet-renamed
      description: My test subnet
      labels:
        new_label: test_label
      network_id: enplom7a98s1t0lhass8
      zone_id: ru-central1-b
      v4_cidr_blocks:
      - 192.168.0.0/24
      ```
  
{% endlist %}

## Examples

### Changing a subnet using the name flag

{% list tabs %}

- CLI
  
  You can change a subnet by using its name instead of its ID:
  
  ```
  $ yc vpc subnet update test-subnet-1 \
      --new-name test-subnet-renamed \
      --labels new_label=test_label
  id: e2l2prrbkbimvjuuhht2
  folder_id: b1g6ci08ma55klukmdjs
  created_at: "2018-10-24T13:54:10Z"
  name: test-subnet-renamed
  description: My test subnet
  labels:
    new_label: test_label
  network_id: enplom7a98s1t0lhass8
  zone_id: ru-central1-b
  v4_cidr_blocks:
  - 192.168.0.0/24
  ```
  
  You can pass the subnet ID and name as positional arguments, or you can use the `--id` and `--name` flags:
  
  ```
  $ yc vpc network update --id enpavfmgapumnl7cqin8 \
  --new-name test-network-renamed \
  --labels new_label=test_label
  ```
  
  ```
  $ yc vpc network update --name test-network-1 \
  --new-name test-network-renamed \
  --labels new_label=test_label
  ```
  
{% endlist %}

