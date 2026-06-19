# Справочник аудитных логов Yandex Audit Trails

В Audit Trails поддерживается отслеживание событий уровня конфигурации (Control Plane) для Yandex Resource Manager. Подробнее в [Аудитный лог событий уровня конфигурации](../audit-trails/concepts/format.md).

Общий вид значения поля `event_type` (_тип события_):

```text
yandex.cloud.audit.resourcemanager.<имя_события>
```

Имя события | Описание
--- | ---
`AddCloudToOrganization` | Добавление облака в организацию
`BindCloudAccessPolicy` | Привязка политики авторизации в облаке
`BindFolderAccessPolicy` | Привязка политики авторизации в каталоге
`CreateCloud` | Создание облака
`CreateFolder` | Создание каталога
`DeleteCloud` | Удаление облака
`DeleteFolder` | Удаление каталога
`UnbindCloudAccessPolicy` | Отмена привязки политики авторизации в облаке
`UnbindFolderAccessPolicy` | Отмена привязки политики авторизации в каталоге
`UpdateCloud` | Изменение облака
`UpdateCloudAccessBindings` | Изменение прав доступа на облако
`UpdateCloudAccessPolicyBindingParameters` | Изменение параметров политики авторизации в облаке
`UpdateFolder` | Обновление каталога
`UpdateFolderAccessBindings` | Изменение прав доступа на каталог
`UpdateFolderAccessPolicyBindingParameters` | Изменение параметров политики авторизации в каталоге
`SetCloudAccessBindings` | Назначение прав доступа на облако
`SetFolderAccessBindings` | Назначение прав доступа на каталог