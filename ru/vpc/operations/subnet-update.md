---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Изменить подсеть

После создания подсети вы можете изменить ее имя, описание и метки.

{% list tabs %}

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров подсети:

      ```
      $ yc vpc subnet update --help
      ```

  1. Получите список всех подсетей в каталоге по умолчанию:

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

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной подсети.
  1. Измените параметры подсети, например:

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

## Примеры {#examples}

### Изменение подсети с использованием флага имени {#using-name-flag}

{% list tabs %}
- CLI

  Можно изменять подсеть, используя ее имя вместо идентификатора:

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

  Идентификатор и имя подсети можно передавать не только как позиционный аргумент, но и с помощью флагов `--id` и `--name`:

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
