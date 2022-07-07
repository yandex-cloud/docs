# Изменение сервисного аккаунта

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите на вкладку **Сервисные аккаунты**.
  1. Нажмите значок ![image](../../../_assets/options.svg) напротив сервисного аккаунта и выберите **Редактировать**.
  1. Измените имя сервисного аккаунта.

     Требования к формату имени:
      
     {% include [name-format](../../../_includes/name-format.md) %}

  1. Измените описание сервисного аккаунта.
  1. Нажмите кнопку **Сохранить**.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. Посмотрите описание команды изменения сервисного аккаунта:

      ```bash
      yc iam service-account update --help
      ```

  1. Выберите сервисный аккаунт, например `my-robot`:

      ```bash
      yc iam service-account list
      ```
      
      Результат:

      ```bash
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2h6g9a33s | my-robot         |                               |
      | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
      +----------------------+------------------+-------------------------------+
      ```

  1. Измените параметры сервисного аккаунта, например имя и описание:

      ```bash
      yc iam service-account update my-robot \
        --new-name my-service-account \
        --description "this is my service account"
      ```
      
      Требования к формату имени:
      
      {% include [name-format](../../../_includes/name-format.md) %}

- API

  Чтобы изменить сервисный аккаунт, воспользуйтесь методом [update](../../api-ref/ServiceAccount/update.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

{% endlist %}
