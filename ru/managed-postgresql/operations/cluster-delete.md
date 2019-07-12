# Удаление кластера

{% note important %}

Удаленный кластер баз данных невозможно восстановить: вместе с кластером удаляются все его резервные копии.

{% endnote %}

{% list tabs %}

- Консоль управления
  
  1. Откройте страницу каталога в консоли управления.
  1. Выберите сервис **Managed Service for PostgreSQL**.
  1. Нажмите значок ![image](../../_assets/vertical-ellipsis.svg) для нужного кластера и выберите пункт **Удалить**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить кластер, выполните команду:
  
  ```
  $ yc managed-postgresql cluster delete <имя или идентификатор кластера>
  ```
  
  Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](#list-clusters).
  
{% endlist %}


