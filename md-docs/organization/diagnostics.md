[Документация Yandex Cloud](../index.md) > [Yandex Identity Hub](index.md) > Диагностика ошибок > Общие ошибки

# Общие ошибки

## Федерация не найдена {#federation-not-found}

Федерация с запрашиваемым идентификатором не найдена. Проверьте указанный идентификатор или обратитесь к администратору вашей федерации.

Чтобы получить идентификатор федерации:

1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization).
1. На панели слева выберите ![VectorSquare](../_assets/console-icons/vector-square.svg) **Федерации**.
1. Выберите нужную федерацию и на странице с информацией о ней скопируйте значение поля **Идентификатор**.

При возникновении проблем обратитесь в [службу поддержки](https://center.yandex.cloud/support).

## Внутренняя ошибка приложения {#internal-server-error}

Произошла непредвиденная ошибка в работе приложения, обратитесь в [службу поддержки](https://center.yandex.cloud/support).

## Организация содержит облака {#organization-contains-clouds}

Полное сообщение об ошибке:

`Organization '**********' contains clouds, please delete them all. Example **********`

Ошибка возникает при попытке удаления организации, в которой есть облака.

Сперва удалите [облака](../resource-manager/operations/cloud/delete.md), а после — [удалите организацию](operations/delete-org.md).

## У пользователя нет разрешений на использование приложения {#no-assignments}

Полное сообщение об ошибке:

`User has no assignments to use the application. Please contact your administrator to assign access to this application.`

Ошибка возникает, если пользователь пытается воспользоваться приложением, к которому у него нет доступа. Обратитесь к администратору организации, чтобы он назначил вам доступ к приложению.

## Смотрите также {#see-also}

* [Диагностика ошибок в федерациях, работающих по протоколу SAML 2.0](saml-diagnostics.md)