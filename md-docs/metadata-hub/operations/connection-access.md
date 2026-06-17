# Настроить права доступа к подключению


{% list tabs group=instructions %}

- Консоль управления {#console}
    
  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно настроить доступ к подключению.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Yandex MetaData Hub**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Нажмите на имя нужного подключения.
  1. На панели слева выберите ![image](../../_assets/console-icons/persons.svg) **Права доступа** и нажмите кнопку **Назначить роли**.
  1. В открывшемся окне нажмите ![image](../../_assets/console-icons/plus.svg) **Выбрать пользователя**.
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к подключению.
  1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите необходимые [роли](../security/index.md#roles-list).
  1. Нажмите **Сохранить**.   

{% endlist %}

## Полезные ссылки {#see-also}

* [Подключение](../concepts/connection-manager.md)
* [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md)
* [Управление доступом в Yandex MetaData Hub](../security/index.md)