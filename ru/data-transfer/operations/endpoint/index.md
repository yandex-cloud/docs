# Управление эндпоинтами

[Эндпоинт](../../concepts/index.md#endpoint)-источник описывает настройки базы данных, из которой будет передаваться информация с помощью {{ data-transfer-name }}, а эндпоинт-приемник — базы, в которую будет производиться перенос. Вы можете [создать](#create), [изменить](#update), [клонировать](#clone) или [удалить](#delete) такие эндпоинты.

## Получить список эндпоинтов {#list}

{% list tabs %}

- Консоль управления
    
    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы получить список трансферов в каталоге, выполните команду:

    ```bash
    {{ yc-dt }} endpoint list
    ```

- API

    Воспользуйтесь методом API [list](../../api-ref/Endpoint/list.md).

{% endlist %}

## Создать эндпоинт {#create}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
    1. В поле **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** выберите **{{ ui-key.yacloud.data-transfer.forms.label_source-type }}** или **{{ ui-key.yacloud.data-transfer.forms.label_target-type }}**.
    1. Укажите имя эндпоинта. Используйте строчные латинские буквы и цифры.
    1. (опционально) Укажите описание эндпоинта.
    1. Выберите нужное значение в поле **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**. Будет создан эндпоинт соответствующего типа.
    1. Задайте параметры эндпоинта:

        {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.

- CLI

    {% note info %}

    Создание эндпоинта с помощью команд CLI поддерживается только для источников и приемников типа {{ CH }}, {{ MG }}, {{ MY }} и {{ PG }}.

    {% endnote %}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать эндпоинт:

    1. Посмотрите описание команды CLI для создания эндпоинта:

        ```bash
        {{ yc-dt }} endpoint create --help
        ```

    1. Укажите параметры эндпоинта в команде создания (в примере приведены не все параметры):

        ```bash
        {{ yc-dt }} endpoint create <тип эндпоинта> \
          --name <имя эндпоинта> \
          --description <описание эндпоинта> \
          <параметры эндпоинта>
        ```

        Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных.

- {{ TF }}

    
    {% note info %}

    Создание эндпоинта с помощью {{ TF }} поддерживается только для источников и приемников типа {{ CH }}, {{ MG }}, {{ MY }} и {{ PG }}.

    {% endnote %}


    
    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    Если у вас еще нет {{ TF }}, [установите его и настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


    Чтобы создать эндпоинт:

    1. Создайте конфигурационный файл с описанием эндпоинта.

       Пример структуры конфигурационного файла:

       ```hcl
       resource "ycp_datatransfer_endpoint" "<имя эндпоинта в {{ TF }}>" {
         name = "<имя эндпоинта>"
         settings {
           <тип эндпоинта> {
             <параметры эндпоинта>
           }
         }
       }
       ```

    Полную схему ресурсов можно получить, запустив `terraform providers schema`.

    1. Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}
     
        
    1. Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).
    

- API

    {% note info %}

    Создание эндпоинта с помощью [API](../../../glossary/rest-api.md) поддерживается только для источников и приемников типа {{ CH }}, {{ KF }}, {{ MG }}, {{ MY }} и {{ PG }}.

    {% endnote %}

    Воспользуйтесь методом API [create](../../api-ref/Endpoint/create) и передайте в запросе:

    * Идентификатор каталога, в котором должен быть размещен эндпоинт, в параметре `folderId`.
    * Имя эндпоинта в параметре `name`.
    * Описание эндпоинта в параметре `description`.
    * Параметры эндпоинта в параметре `settings`.

    Параметры эндпоинта см. в разделе настроек для нужного источника или приемника данных.

{% endlist %}

## Изменить эндпоинт {#update}

{% note info %}

Тип эндпоинта и тип базы данных нельзя изменить. Для ряда эндпоинтов невозможно также изменить тип подключения.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
    1. Выберите эндпоинт и нажмите кнопку ![pencil](../../../_assets/pencil.svg) **{{ ui-key.yacloud.common.edit }}** на панели сверху.
    1. Отредактируйте параметры эндпоинта:

        {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.apply }}**.

- CLI

    {% note info %}

    Изменение эндпоинта с помощью команд CLI поддерживается только для источников и приемников типа {{ CH }}, {{ MG }}, {{ MY }} и {{ PG }}.

    {% endnote %}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки эндпоинта:

    1. Посмотрите описание команды CLI для изменения трансфера:

        ```bash
        {{ yc-dt }} endpoint update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить (в примере приведены не все параметры):

        ```bash
        {{ yc-dt }} transfer update <тип эндпоинта> <идентификатор эндпоинта> \
           --name <имя эндпоинта> \
           --description <описание эндпоинта> \
           <параметры эндпоинта>
        ```

        Тип эндпоинта и его параметры см. в разделе настроек для нужного источника или приемника данных. Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с описанием эндпоинта.

        О том, как создать такой файл, см. в подразделе [Создать эндпоинт](#create).

    1. Измените значение поля `name` (имя эндпоинта) и параметры эндпоинта в блоке `settings`.
    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-dt-endpoint }}).

- API

    {% note info %}

    Изменение эндпоинта с помощью API поддерживается только для источников и приемников типа {{ CH }}, {{ KF }}, {{ MG }}, {{ MY }} и {{ PG }}.

    {% endnote %}

    Воспользуйтесь методом API [update](../../api-ref/Endpoint/update) и передайте в запросе:

    * Идентификатор эндпоинта в параметре `endpointId`
    * Имя эндпоинта в параметре `name`.
    * Описание эндпоинта в параметре `description`.
    * Параметры эндпоинта в параметре `settings`.

    Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

{% endlist %}

Изменение настроек эндпоинта для трансфера с типом {{ dt-type-repl }} в статусе {{ dt-status-repl }} приведет к перезапуску трансфера.

## Клонировать эндпоинт {#clone}

{% note info %}

При клонировании нельзя изменить тип эндпоинта и тип базы данных.

{% endnote %}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
    1. Выберите эндпоинт, который нужно клонировать.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.clone }}** на панели сверху.
    1. Задайте имя нового эндпоинта и при необходимости отредактируйте остальные параметры:

        {% include [Parameter list](../../../_includes/data-transfer/endpoint-param-list.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.

{% endlist %}

## Удалить эндпоинт {#delete}

{% note warning %}

Перед удалением эндпоинта [удалите](../transfer.md#delete) все трансферы, в которые он входит.

{% endnote %}

Чтобы удалить эндпоинт:

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ data-transfer-full-name }}**.
    1. На панели слева выберите ![image](../../../_assets/data-transfer/endpoint.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}**.
    1. Выберите эндпоинт, который нужно удалить.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}** на панели сверху.
    1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы удалить эндпоинт, выполните команду:

    ```bash
    {{ yc-dt }} endpoint delete <идентификатор эндпоинта>
    ```

    Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

- {{ TF }}

    {% include [terraform-delete](../../../_includes/data-transfer/terraform-delete-endpoint.md) %}

- API

    Воспользуйтесь методом API [delete](../../api-ref/Endpoint/delete) и передайте идентификатор нужного эндпоинта в параметре `endpointId` запроса.

    Идентификатор эндпоинта можно получить со [списком эндпоинтов в каталоге](#list).

{% endlist %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
