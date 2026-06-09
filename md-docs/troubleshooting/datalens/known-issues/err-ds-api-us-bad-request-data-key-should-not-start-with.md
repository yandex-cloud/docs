# Устранение ошибки `ERR.DS_API.US.BAD_REQUEST data.key should not start with /`


## Описание проблемы {#issue-description}

При создании подключения возникает ошибка `ERR.DS_API.US.BAD_REQUEST`.

## Решение {#issue-resolution}

Такая ошибка может возникнуть при попытке создания подключения в корне иерархии {{ datalens-name }} внутри каталога **«{{ ui-key.datalens.component.aside-header.view.switch_root }}»**.

Укажите каталог с другим названием во всплывающем окне после нажатия на кнопку **{{ ui-key.datalens.connection.connections-list.modify.button_create-connection }}**.