# Текст из Дельты

[Дельта](https://delta.yandex-team.ru/) — сервис для совместного редактирования текстов онлайн. Его удобно использовать для логирования встреч или, например, совместного ведения заметок на докладе. 
Текст из Дельты можно [выгрузить в {{ wiki-name }}](#delta-save).

## Как создать новую запись {#delta-create}

1. Перейдите на страницу [https://delta.yandex-team.ru/](https://delta.yandex-team.ru/).

1. Нажмите кнопку **Создать**.

1. В левом верхнем углу выберите язык программирования из списка. 
    Для записей в текстовом формате с возможностями вики-разметки выберите `plain_text`. Включите функцию **Режим Вики**, чтобы увидеть отформатированный текст в области справа.

1. Чтобы редактировать текст вместе с коллегами, отправьте им ссылку на вики-страницу из адресной строки браузера.

{% note alert %}

* Страницы в Дельте хранятся в открытом доступе для всех сотрудников Яндекса. Существует возможность, что кто-то случайно увидит ваш текст.

* Поиска по Дельте не существует. Чтобы не потерять свой блокнот, запомните его имя или сохраните ссылку на него.

{% endnote %}

## Как сохранить текст из Дельты на {{ wiki-name }} {#delta-save}

Заметки из Дельты можно сохранять на любой доступной для редактирования вики-странице в {{ wiki-name }}. Например, каждый из участников совместного редактирования может сохранить текст в свой личный раздел.

Чтобы сохранить текст на {{wiki-name}}:

1. Нажмите кнопку **Выгрузить в Вики** и укажите относительную ссылку на вики-страницу в формате:
    ```{{ wiki-pagename }}```

1. Нажмите **Продолжить**. Если вы выгружаете разные версии заметки на один адрес в {{ wiki-name }}, страница будет перезаписана. Все версии можно посмотреть в [истории изменений](history.md).