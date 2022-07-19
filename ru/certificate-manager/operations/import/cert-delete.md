# Удаление сертификата

Чтобы удалить сертификат:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сертификат.
    1. В списке сервисов выберите **{{ certificate-manager-name }}**.
    1. Найдите в списке сертификат, который необходимо удалить.
    1. Нажмите кнопку ![image](../../../_assets/options.svg).
    1. В открывшемся меню нажмите кнопку **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды:

        ```bash
        yc certificate-manager certificates delete --help
        ```

    1. Посмотрите список сертификатов:

        ```bash
        yc certificate-manager certificate list
        +----------------------+---------------+-------------+---------------------+----------+--------+
        |          ID          |     NAME      |   DOMAINS   |      NOT AFTER      |   TYPE   | STATUS |
        +----------------------+---------------+-------------+---------------------+----------+--------+
        | fpqmg47avvimp7rvmp30 | myupdatedcert | example.com | 2021-09-15 08:12:57 | IMPORTED | ISSUED |
        +----------------------+---------------+-------------+---------------------+----------+--------+
        ```

    1. Выполните команду:

        ```bash
        yc certificate-manager certificates delete \
          --id fpqmg47avvimp7rvmp30
        ```

        Где `--id` — идентификатор сертификата.

        Результат:

        ```bash
        id: fpqmg47avvimp7rvmp30
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T06:54:44.916Z"
        name: myupdatedcert
        description: description of myupdatedcert
        type: IMPORTED
        domains:
        - example.com
        status: ISSUED
        issuer: CN=example.com
        subject: CN=example.com
        serial: 3df79e43df7c3868397b78bfc15a431fa942a135
        updated_at: "2020-09-15T08:37:20.746Z"
        issued_at: "2020-09-15T08:23:50.147Z"
        not_after: "2021-09-15T08:12:57Z"
        not_before: "2020-09-15T08:12:57Z"
        ```

- API
  
    Чтобы удалить сертификат, воспользуйтесь методом [delete](../../api-ref/Certificate/delete.md) для ресурса [Certificate](../../api-ref/Certificate/).

{% endlist %}
