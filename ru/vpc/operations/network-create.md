---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Создать облачную сеть

Помимо облачной сети в каталоге по умолчанию вы можете создавать дополнительные облачные сети в других каталогах.

{% list tabs %}

- Консоль управления

  Чтобы создать [облачную сеть](../concepts/network.md):
  1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
  1. Нажмите кнопку **Создать сеть.**
  1. Задайте имя сети.

      {% include [name-format](../../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать сеть**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать [облачную сеть](../concepts/network.md):
  1. Посмотрите описание команды CLI для создания облачной сети:

      ```
      $ yc vpc network create --help
      ```

  1. Создайте облачную сеть в каталоге по умолчанию:

      ```
      $ yc vpc network create --name test-network-1 \
          --description "My test network"
      ```

      {% include [name-format](../../_includes/name-format.md) %}

      Флаги `--name` и `--description` необязательные — можно создать сеть без имени и описания и обращаться к ней по идентификатору.

  1. Получите список всех облачных сетей в каталоге по умолчанию:

      ```
      $ yc vpc network list
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpiuvhhd4t80k4n80i8 | test-network-1 |
      | enplom7a98s1t0lhass8 | default        |
      +----------------------+----------------+
      ```

      Получите тот же список c большим количеством деталей в формате YAML:

      ```
      $ yc vpc network list --format yaml
      - id: enpiuvhhd4t80k4n80i8
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-10-23T11:12:51Z"
        name: test-network-1
        description: My first network
      - id: enplom7a98s1t0lhass8
        folder_id: b1g6ci08ma55klukmdjs
        created_at: "2018-09-24T08:23:00Z"
        name: default
        description: Auto-created default network
      ```

{% endlist %}

## Примеры {#examples}

Создайте облачную сеть с именем и описанием в выбранном каталоге:

{% list tabs %}

- CLI

  ```
  $ yc vpc network create --name test-network-1 \
    --description "My test network" \
    --folder-id b1gnbfd11bq5g5vnjgr4
  ```

{% endlist %}
