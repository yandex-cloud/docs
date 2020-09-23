# Изменение сертификата

После создания сертификата вы можете изменить его название или описание. Чтобы изменить сертификат:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сертификат.
    1. В списке сервисов выберите **{{ certificate-manager-name }}**.
    1. Выберите в списке сертификат, который необходимо изменить.
    1. В открывшемся окне нажмите кнопку **Изменить**.
    1. Измените название или описание сертификата.
    1. Нажмите кнопку **Сохранить**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды:

        ```bash
        yc certificate-manager certificate update --help
        ```

    1. Посмотрите список сертификатов:

        ```bash
        yc certificate-manager certificate list
        +----------------------+---------------+-------------+-----------+---------+------------+
        |          ID          |     NAME      |   DOMAINS   | NOT AFTER |  TYPE   |   STATUS   |
        +----------------------+---------------+-------------+-----------+---------+------------+
        | fpq6gvvm6piuegbb2nol | mymanagedcert | example.com |           | MANAGED | VALIDATING |
        +----------------------+---------------+-------------+-----------+---------+------------+
        ```

    1. Выполните команду:

        ```bash
        yc certificate-manager certificates update \
          --id fpq6gvvm6piuegbb2nol \
          --new-name myupdatedmanagedcert \
          --description "description of myupdatedmanagedcert"
        ```

        Параметры команды:

          - `--id` — идентификатор сертификата.
          - `--new-name` — новое имя сертификата.
          - `--description` — описание сертификата.

        Результат команды:

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
        updated_at: "2020-09-15T09:10:06.981875Z"
        ```
       
- API
  
    Чтобы обновить сертификат, воспользуйтесь методом [update](../../api-ref/Certificate/update.md) для ресурса [Certificate](../../api-ref/Certificate/).
    
{% endlist %}
