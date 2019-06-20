# Удалить сервисный аккаунт

{% note important %}

Удаление [сервисного аккаунта](../../concepts/users/service-accounts.md) — неотменяемая операция. Восстановить удаленный сервисный аккаунт невозможно, только [создать его заново](create.md).

{% endnote %}

{% list tabs %}

- Консоль управления
  
  1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
  2. Выберите вкладку **Сервисные аккаунты**.
  3. Нажмите значок ![image](../../../_assets/options.svg) напротив сервисного аккаунта и выберите **Удалить сервисный аккаунт**.
  4. Подтвердите удаление.
  
- CLI
  
  
  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  1. Посмотрите описание команды удаления сервисного аккаунта:
  
      ```
      $ yc iam service-account delete --help
      ```
  
  2. Выберите сервисный аккаунт, например `my-robot`:
  
      ```
      $ yc iam service-account list
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```
  3. Удалите сервисный аккаунт:
  
      ```
      yc iam service-account delete my-robot
      ```
  
- API
  
  Чтобы удалить сервисный аккаунт, воспользуйтесь методом [delete](../../api-ref/ServiceAccount/delete.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).
  
{% endlist %}
