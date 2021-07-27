---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создать внутреннюю зону DNS

Чтобы создать внутреннюю [зону DNS](../concepts/dns-zone.md):

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ dns-name }}** в каталоге, где требуется создать зону DNS.
  1. Нажмите кнопку **Создать зону**.
  1. Задайте настройки зоны:
     1. **Имя** зоны.
     1. **Зона** — доменная зона. Название зоны должно заканчиваться точкой.
     1. **Тип** — внутренняя. 
     1. Укажите сети, ресурсы их которых будут входить в создаваемую зону.
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать новую зону DNS:

  1. Посмотрите описание команды CLI для создания зоны:

     ```
     yc dns zone create --help
     ```

  1. Создайте новую внутреннюю зону DNS в каталоге по умолчанию:

     ```
     yc dns zone create --name test-zone \
     --zone staging. \
     --private-visibility network-ids=<идентифиакторы сетей для зоны>
     ```

     Результат выполнения команды:

     ```
     id: aet29qhara5jeg45tbjg
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-02-21T09:21:03.935Z"
     name: test-zone
     zone: staging.
     private_visibility:
       network_ids:
       - <идентификатор сети>
     ```

{% endlist %}

{% list tabs %}