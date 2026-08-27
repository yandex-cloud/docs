[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Postbox](../index.md) > [Пошаговые инструкции](index.md) > Управление пользовательским стоп-листом

# Управление пользовательским стоп-листом

В [пользовательском стоп-листе](../concepts/suppression-list.md#user) находятся адреса получателей, которым Yandex Cloud Postbox не отправляет письма, если причина, по которой адрес добавлен в список, [блокирует отправку](../concepts/suppression-list.md#reasons). Список создается для облака и является общим для всех каталогов, адресов и конфигураций внутри него.

Чтобы просматривать стоп-лист, необходима [роль](../security/index.md#postbox-viewer) `postbox.viewer`. Чтобы добавлять и удалять адреса — [роль](../security/index.md#postbox-editor) `postbox.editor`.

Чтобы Yandex Cloud Postbox проверял пользовательский стоп-лист при отправке писем, [задайте](create-configuration.md) настройки стоп-листа в конфигурации.

## Добавить адрес получателя в стоп-лист {#add}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите](https://console.yandex.cloud/link/postbox) в сервис **Cloud Postbox**.
    1. На панели слева выберите **Стоп-лист**.
    1. Нажмите **Добавить**.
    1. В поле **Адрес электронной почты** укажите адрес получателя, который необходимо добавить в пользовательский стоп-лист.
    1. В поле **Причина** выберите [причину](../concepts/suppression-list.md#reasons), по которой адрес получателя необходимо добавить в пользовательский стоп-лист.
    1. Нажмите **Сохранить**.

- AWS CLI {#aws-cli}

    Если у вас еще нет интерфейса командной строки AWS CLI, [установите и сконфигурируйте его](../tools/aws-cli.md).

    Добавьте адрес получателя в стоп-лист:

    ```bash
    aws sesv2 put-suppressed-destination \
       --endpoint-url=https://postbox.cloud.yandex.net \
       --profile <имя_профиля> \
       --email-address <адрес_получателя> \
       --reason <причина добавления>
    ```

    Где:

    * `--email-address` — адрес получателя, который необходимо добавить в пользовательский стоп-лист;
    * `--reason` — [причина](../concepts/suppression-list.md#reasons), по которой адрес получателя необходимо добавить в пользовательский стоп-лист.

- API {#api}

    Чтобы добавить адрес получателя в пользовательский стоп-лист, воспользуйтесь методом [PutSuppressedDestination](../aws-compatible-api/api-ref/put-suppressed-destination.md).

{% endlist %}

Если адрес уже есть в стоп-листе, новая запись не создается: у текущей записи обновляются причина и время изменения.

## Посмотреть стоп-лист {#list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите](https://console.yandex.cloud/link/postbox) в сервис **Cloud Postbox**.
    1. На панели слева выберите **Стоп-лист**.

    Для каждого адреса в пользовательском стоп-листе отображаются причина, дата добавления и, если адрес добавлен в стоп-лист автоматически, Message-ID письма, из-за которого это произошло.

- AWS CLI {#aws-cli}

    Получите список адресов в стоп-листе:

    ```bash
    aws sesv2 list-suppressed-destinations \
       --endpoint-url=https://postbox.cloud.yandex.net \
       --profile <имя_профиля> \
       --reasons COMPLAINT \
       --page-size 50
    ```

    Параметры `--reasons`, `--start-date` и `--end-date` необязательные. Без них возвращаются адреса со всеми причинами за все время.

- API {#api}

    Чтобы посмотреть пользовательский стоп-лист, воспользуйтесь методом [ListSuppressedDestinations](../aws-compatible-api/api-ref/list-suppressed-destinations.md).

{% endlist %}

Адреса возвращаются отсортированными от недавно измененных к более старым. Найти в списке конкретный адрес с помощью фильтра нельзя: чтобы проверить, есть ли адрес в стоп-листе, [посмотрите информацию об адресе](#get).

## Посмотреть информацию об адресе получателя в стоп-листе {#get}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

    Получите информацию об адресе:

    ```bash
    aws sesv2 get-suppressed-destination \
       --endpoint-url=https://postbox.cloud.yandex.net \
       --profile <имя_профиля> \
       --email-address <адрес_получателя>
    ```

- API {#api}

    Чтобы посмотреть информацию об адресе получателя в пользовательском стоп-листе, воспользуйтесь методом [GetSuppressedDestination](../aws-compatible-api/api-ref/get-suppressed-destination.md).

{% endlist %}

Если адрес получателя попал в стоп-лист автоматически, в ответе будет Message-ID письма, из-за которого это произошло.

## Удалить адрес получателя из стоп-листа {#delete}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. [Перейдите](https://console.yandex.cloud/link/postbox) в сервис **Cloud Postbox**.
    1. На панели слева выберите **Стоп-лист**.
    1. В строке с нужным адресом нажмите ![image](../../_assets/console-icons/trash-bin.svg).
    1. Подтвердите удаление.

- AWS CLI {#aws-cli}

    Удалите адрес из стоп-листа:

    ```bash
    aws sesv2 delete-suppressed-destination \
       --endpoint-url=https://postbox.cloud.yandex.net \
       --profile <имя_профиля> \
       --email-address <адрес_получателя>
    ```

- API {#api}

    Чтобы удалить адрес получателя из пользовательского стоп-листа, воспользуйтесь методом [DeleteSuppressedDestination](../aws-compatible-api/api-ref/delete-suppressed-destination.md).

{% endlist %}

{% note warning %}

Если адрес находится в [глобальном стоп-листе](../concepts/suppression-list.md#global), он не разблокируется после удаления из пользовательского стоп-листа.

{% endnote %}

#### Полезные ссылки {#see-also}

* [Стоп-листы](../concepts/suppression-list.md)
* [Создание конфигурации](create-configuration.md)