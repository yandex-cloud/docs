# Изменить облачную сеть

После создания облачной сети вы можете изменить ее имя, описание и метки.

{% list tabs %}

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для обновления параметров облачной сети:

      ```
      yc vpc network update --help
      ```

  1. Получите список всех сетей в каталоге по умолчанию:

      ```
      yc vpc network list
      ```
	  Результат:
      ```
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapumnl7cqin8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужной сети.
  1. Измените параметры облачной сети указав ее имя:

      ```
      yc vpc network update enpavfmgapumnl7cqin8 --new-name test-network-renamed
      ```
      Результат:
	  ```
      id: enpavfmgapumnl7cqin8
      folder_id: b1g6ci08ma55klukmdjs
      created_at: "2018-10-23T14:05:32Z"
      name: test-network-renamed
      description: My first network
      labels:
        new_label: test_label
      ```
  Идентификатор и имя можно передавать не только как позиционный аргумент, но и с помощью флагов `--id` и `--name`:

  ```
  yc vpc network update --name test-network-1 --new-name test-network-renamed --labels new_label=test_label
  yc vpc network update --id enpavfmgapumnl7cqin8 --new-name test-network-renamed --labels new_label=test_label
  ```

{% endlist %}

## Примеры {#examples}

### Изменение облачной сети с использованием имени {#using-name}

Можно изменять облачную сеть, используя имя вместо идентификатора:

{% list tabs %}

- CLI

  ```
  yc vpc network update test-network-1 --new-name test-network-renamed --labels new_label=test_label
  ```
  Результат:
  ```
  id: enpavfmgapumnl7cqin8
  folder_id: b1g6ci08ma55klukmdjs
  created_at: "2018-10-23T14:05:32Z"
  name: test-network-renamed
  description: My first network
  labels:
    new_label: test_label
  ```

{% endlist %}
