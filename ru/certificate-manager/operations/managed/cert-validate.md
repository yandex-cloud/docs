# Проверить права на домены

Чтобы пройти процедуру проверки прав на домены:

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сертификат.
    1. В списке сервисов выберите **{{ certificate-manager-name }}**.
    1. Выберите в списке сертификат, для которого необходимо пройти процедуру проверки и нажмите на него.
    1. В открывшемся окне в блоке **Проверка прав на домены** будет указана информация для прохождения процедуры проверки прав. Подробнее читайте в разделе [{#T}](../../concepts/challenges.md).
    1. После успешного прохождения проверки прав на домен, статус проверки домена в блоке **Проверка прав на домены** изменится на `Valid`.
    1. После того, как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды:

        ```bash
        yc certificate-manager certificate get --help
        ```

    1. Выполните команду:

        ```bash
        yc certificate-manager certificate get \
          --id fpq6gvvm6piuegbb2nol \
          --full
        ```

        Где:

          - `--id` — идентификатор сертификата.
          - `--full` — показать список активных процедур проверки прав на домены.

        Результат:

        ```bash
        id: fpq6gvvm6piuegbb2nol
        folder_id: b1g7gvsi89m34qmcm3ke
        created_at: "2020-09-15T08:49:11.533771Z"
        name: mymanagedcert
        type: MANAGED
        domains:
        - example.com
        status: VALIDATING
        updated_at: "2020-09-15T08:49:11.533771Z"
        challenges:
        - domain: example.com
          type: HTTP
          created_at: "2020-09-15T08:49:11.533771Z"
          updated_at: "2020-09-15T08:51:44.991065Z"
          status: PENDING
          message: Create a file in your web server's base directory.
          http_challenge:
            url: http://example.com/.well-known/acme-challenge/3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8
            content: 3LiH-nrTC7GdMbRgVqttEvdTODeNeaD0TtXteWgtAH8.ZHCju15sJiKBwT8G5FTl7UtfmJWp1gKNYYPLcVtVL44
        ```

    1. В блоке `http_challenge` указана информация для прохождения процедуры проверки прав. Подробнее читайте в разделе [{#T}](../../concepts/challenges.md).

    1. После успешного прохождения проверки прав на домен, статус проверки изменится на `Valid`:

        ```bash
        yc certificate-manager certificate get --id fpq6gvvm6piuegbb2nol --full
        ...
        domains:
        - example.com
        status: VALID
        ...
        ```

    1. После того, как статус проверки прав всех доменов изменится на `Valid`, сертификат будет выпущен и перейдет в статус `Issued`:

        ```bash
        yc certificate-manager certificate get --id fpq6gvvm6piuegbb2nol --full
        ...
        domains:
        - example.com
        status: ISSUED
        ...
        ```
       
- API
  
    Для получения информации, необходимой для прохождения процедуры проверки прав на домены, воспользуйтесь методом [get](../../api-ref/Certificate/get.md) для ресурса [Certificate](../../api-ref/Certificate/) c флагом `view=FULL`.
    
{% endlist %}
