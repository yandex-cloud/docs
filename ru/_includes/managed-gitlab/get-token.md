Чтобы создать и настроить {{ GLR }} для всего [инстанса {{ GL }}](../../managed-gitlab/concepts/index.md#instance) (требуются права администратора {{ GL }}):

1. Откройте {{ GL }}.
1. В левом нижнем углу нажмите кнопку **Admin**.
1. В меню слева выберите **CI/CD** → **Runners**.
1. Нажмите кнопку **New instance runner** и создайте новый {{ GLR }}.
1. Сохраните значение параметра `Runner authentication token`.

Чтобы создать и настроить {{ GLR }} для [проекта]({{ gl.docs }}/ee/user/project/):

1. Откройте {{ GL }}.
1. Выберите проект.
1. В меню слева выберите **Settings** → **CI/CD**.
1. В блоке **Runners** нажмите кнопку **Expand**.
1. Нажмите кнопку **New project runner** и создайте новый {{ GLR }}.
1. Сохраните значение параметра `Runner authentication token`.
