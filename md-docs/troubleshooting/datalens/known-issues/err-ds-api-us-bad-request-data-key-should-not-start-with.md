[Документация Yandex Cloud](../../../index.md) > [Все решения](../../index.md) > [DataLens](../index.md) > Устранение ошибки `ERR.DS_API.US.BAD_REQUEST data.key should not start with /`

# Устранение ошибки `ERR.DS_API.US.BAD_REQUEST data.key should not start with /`


## Описание проблемы {#issue-description}

При создании подключения возникает ошибка `ERR.DS_API.US.BAD_REQUEST`.

## Решение {#issue-resolution}

Такая ошибка может возникнуть при попытке создания подключения в корне иерархии DataLens внутри каталога **«Все объекты»**.

Укажите каталог с другим названием во всплывающем окне после нажатия на кнопку **Создать подключение**.