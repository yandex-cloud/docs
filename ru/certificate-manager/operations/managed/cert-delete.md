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
        +----------------------+----------------------+-------------+-----------+---------+------------+
        |          ID          |         NAME         |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
        +----------------------+----------------------+-------------+-----------+---------+------------+
        | fpq6gvvm6piuegbb2nol | myupdatedmanagedcert | example.com |           | MANAGED | VALIDATING |
        +----------------------+----------------------+-------------+-----------+---------+------------+
        ```

    1. Выполните команду:

        ```bash
        yc certificate-manager certificates delete \
          --id fpq6gvvm6piuegbb2nol
        ```

        Где `--id` — идентификатор сертификата.

        Результат:

        ```bash
        id: fpq6gvvm6piuegbb2nol
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T08:49:11.533Z"
        name: myupdatedmanagedcert
        description: description of myupdatedmanagedcert
        type: MANAGED
        domains:
        - example.com
        status: VALIDATING
        updated_at: "2020-09-15T09:10:06.981Z"
        ```
       
- API
  
    Чтобы удалить сертификат, воспользуйтесь методом [delete](../../api-ref/Certificate/delete.md) для ресурса [Certificate](../../api-ref/Certificate/).

{% endlist %}
