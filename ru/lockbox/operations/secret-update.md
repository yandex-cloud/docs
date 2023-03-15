# Изменить секрет

Чтобы изменить секрет:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, которому принадлежит секрет.
    1. В списке сервисов выберите сервис **{{ lockbox-short-name }}**.
    1. В меню слева выберите **Секреты**.
    1. Напротив нужного секрета нажмите значок ![image](../../_assets/horizontal-ellipsis.svg).
    1. В открывшемся меню выберите пункт **Редактировать**.
    1. Скорректируйте имя и описание секрета, отметьте опцию **Запретить удаление секрета** при необходимости.
    1. Нажмите кнопку **Сохранить**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для добавления ресурсов в секрет:
     ```bash
     yc lockbox secret update --help
     ```

  1. Выполните команду, указав имя или идентификатор секрета:
     ```bash
     yc lockbox secret update \
       --id <идентификатор секрета> \
       --new-name <новое имя секрета> \
       --description <новое описание секрета>
     ```

     Результат:
     ```
     id: e6q2ig0u9b97tk2d251j
     folder_id: b1gyggt2th593evcld2a
     created_at: "2021-11-08T19:23:00.383Z"
     name: <новое имя секрета>
     description: <новое описание секрета>
     status: ACTIVE
     current_version:
       id: e6q8ma3b6pd1kckgtaib
       secret_id: e6q2ug0o9b24tk2d941j
       created_at: "2021-11-08T19:23:00.383Z"
       status: ACTIVE
       payload_entry_keys:
       - <ключ>
     ```

- API

  Чтобы изменить секрет, воспользуйтесь методом REST API [update](../api-ref/Secret/update.md) для ресурса [Secret](../api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Update](../api-ref/grpc/secret_service.md#Update).

{% endlist %}