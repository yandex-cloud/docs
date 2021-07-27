---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Создать публичную зону DNS

Чтобы создать публичную [зону DNS](../concepts/dns-zone.md):

{% list tabs %}

- Консоль управления

  1. Откройте раздел **{{ dns-name }}** в каталоге, где требуется создать зону DNS.
  1. Нажмите кнопку **Создать зону**.
  1. Задайте настройки зоны:
     1. **Имя** зоны.
     1. **Зона** — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя.
     1. **Тип** — **Публичная**. 
  1. Нажмите кнопку **Создать**.

- CLI

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать новую зону DNS:

  1. Посмотрите описание команды CLI для создания зоны:

     ```
     yc dns zone create --help
     ```

  1. Создайте новую публичную зону DNS в каталоге по умолчанию:

     ```
     yc dns zone create --name production-zone --zone www.example.com. --public-visibility
     ```

     Результат выполнения команды:

     ```
     id: aet2q4fn8i8icfug97p0
     folder_id: aoerb349v3h4bupphtaf
     created_at: "2021-03-03T19:07:08.685Z"
     name: production-zone
     zone: www.example.com.
     public_visibility: {}
     ```

{% endlist %}

Чтобы получить доступ к именам из публичной зоны, вам нужно делегировать домен. Укажите адреса серверов `ns1.yandexcloud.net` и `ns2.yandexcloud.net` в личном кабинете вашего регистратора.