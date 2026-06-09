# Yandex Cloud Desktop

<em>Сервис Yandex Cloud Desktop находится на <a href="../overview/concepts/launch-stages.md">стадии Preview</a></em>.

Yandex Cloud Desktop — сервис для управления виртуальной инфраструктурой <a href="concepts/desktops-and-groups.md">рабочих столов</a> на базе Linux.

С помощью сервиса вы можете: <ul><li>быстро создавать виртуальные рабочие места для новых сотрудников;</li> <li>безопасно подключать удаленных сотрудников к корпоративной сети;</li>  <li>предоставлять сотрудникам возможность работать с любого современного устройства с доступом в интернет, в том числе собственного (<a href="https://ru.wikipedia.org/wiki/Bring_your_own_device">BYOD</a>);</li> <li>управлять вычислительными ресурсами рабочих столов;</li> <li>удаленно администрировать рабочие столы;</li> <li>создавать группы рабочих столов с одинаковыми вычислительными ресурсами и облачной <a href="../vpc/concepts/network.md">сетью</a>.</li></ul>

Для подключения к рабочим столам используется <a href="https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol">Remote Desktop Protocol</a> (RDP).

# Yandex Cloud Desktop

## Начало работы

 - [Для администраторов](quickstart.md)

 - [Для пользователей](quickstart-users.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Группы рабочих столов

 - [Создать группу рабочих столов](operations/desktop-groups/create.md)

 - [Изменить группу рабочих столов](operations/desktop-groups/update.md)

 - [Изменить права доступа к группе рабочих столов](operations/desktop-groups/update-acl.md)

 - [Удалить группу рабочих столов](operations/desktop-groups/delete.md)

### Рабочие столы

 - [Создать рабочий стол](operations/desktops/create.md)

 - [Подключиться к рабочему столу](operations/desktops/connect.md)

 - [Сбросить пароль пользователя для рабочего стола](operations/desktops/password-reset.md)

 - [Запустить, перезапустить и остановить рабочий стол](operations/desktops/start-stop.md)

 - [Обновить рабочий стол](operations/desktops/update.md)

 - [Изменить рабочий стол](operations/desktops/update-properties.md)

 - [Удалить рабочий стол](operations/desktops/delete.md)

### Образы

 - [Создать образ на основе рабочего стола](operations/images/create-from-desktop.md)

 - [Создать образ Linux на основе ВМ Compute Cloud](operations/images/create-from-compute-linux.md)

 - [Создать образ Windows](operations/images/create-from-windows.md)

 - [Изменить образ](operations/images/update.md)

 - [Удалить пользовательский образ](operations/images/delete.md)

 - [Посмотреть логи](operations/logging.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

## Практические руководства

 - [Настройка печати с Cloud Desktop на локальный принтер в Linux](tutorials/desktop-linux-printer.md)

## Концепции

 - [Рабочие столы и их группы](concepts/desktops-and-groups.md)

 - [Список управления доступом (ACL)](concepts/acl.md)

 - [Диски](concepts/disks.md)

 - [Образы](concepts/images.md)

 - [Витрина пользовательских рабочих столов](concepts/showcase.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### desktop

 - [Overview](cli-ref/desktop/index.md)

 - [create](cli-ref/desktop/create.md)

 - [delete](cli-ref/desktop/delete.md)

 - [get](cli-ref/desktop/get.md)

 - [get-rdp-file](cli-ref/desktop/get-rdp-file.md)

 - [list](cli-ref/desktop/list.md)

 - [list-operations](cli-ref/desktop/list-operations.md)

 - [reset-password](cli-ref/desktop/reset-password.md)

 - [restart](cli-ref/desktop/restart.md)

 - [start](cli-ref/desktop/start.md)

 - [stop](cli-ref/desktop/stop.md)

 - [update](cli-ref/desktop/update.md)

 - [update-properties](cli-ref/desktop/update-properties.md)

### group

 - [Overview](cli-ref/group/index.md)

 - [add-access-bindings](cli-ref/group/add-access-bindings.md)

 - [create](cli-ref/group/create.md)

 - [delete](cli-ref/group/delete.md)

 - [get](cli-ref/group/get.md)

 - [list](cli-ref/group/list.md)

 - [list-access-bindings](cli-ref/group/list-access-bindings.md)

 - [list-desktops](cli-ref/group/list-desktops.md)

 - [list-operations](cli-ref/group/list-operations.md)

 - [remove-access-bindings](cli-ref/group/remove-access-bindings.md)

 - [set-access-bindings](cli-ref/group/set-access-bindings.md)

 - [update](cli-ref/group/update.md)

### image

 - [Overview](cli-ref/image/index.md)

 - [copy](cli-ref/image/copy.md)

 - [delete](cli-ref/image/delete.md)

 - [get](cli-ref/image/get.md)

 - [list](cli-ref/image/list.md)

 - [update](cli-ref/image/update.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### desktop

 - [Overview](cli-ref/v0/desktop/index.md)

 - [create](cli-ref/v0/desktop/create.md)

 - [delete](cli-ref/v0/desktop/delete.md)

 - [get](cli-ref/v0/desktop/get.md)

 - [get-rdp-file](cli-ref/v0/desktop/get-rdp-file.md)

 - [list](cli-ref/v0/desktop/list.md)

 - [list-operations](cli-ref/v0/desktop/list-operations.md)

 - [reset-password](cli-ref/v0/desktop/reset-password.md)

 - [restart](cli-ref/v0/desktop/restart.md)

 - [start](cli-ref/v0/desktop/start.md)

 - [stop](cli-ref/v0/desktop/stop.md)

 - [update](cli-ref/v0/desktop/update.md)

 - [update-properties](cli-ref/v0/desktop/update-properties.md)

#### group

 - [Overview](cli-ref/v0/group/index.md)

 - [add-access-bindings](cli-ref/v0/group/add-access-bindings.md)

 - [create](cli-ref/v0/group/create.md)

 - [delete](cli-ref/v0/group/delete.md)

 - [get](cli-ref/v0/group/get.md)

 - [list](cli-ref/v0/group/list.md)

 - [list-access-bindings](cli-ref/v0/group/list-access-bindings.md)

 - [list-desktops](cli-ref/v0/group/list-desktops.md)

 - [list-operations](cli-ref/v0/group/list-operations.md)

 - [remove-access-bindings](cli-ref/v0/group/remove-access-bindings.md)

 - [set-access-bindings](cli-ref/v0/group/set-access-bindings.md)

 - [update](cli-ref/v0/group/update.md)

#### image

 - [Overview](cli-ref/v0/image/index.md)

 - [copy](cli-ref/v0/image/copy.md)

 - [delete](cli-ref/v0/image/delete.md)

 - [get](cli-ref/v0/image/get.md)

 - [list](cli-ref/v0/image/list.md)

 - [update](cli-ref/v0/image/update.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

#### DesktopGroup

 - [Overview](api-ref/grpc/DesktopGroup/index.md)

 - [Get](api-ref/grpc/DesktopGroup/get.md)

 - [List](api-ref/grpc/DesktopGroup/list.md)

 - [ListDesktops](api-ref/grpc/DesktopGroup/listDesktops.md)

 - [ListOperations](api-ref/grpc/DesktopGroup/listOperations.md)

 - [Create](api-ref/grpc/DesktopGroup/create.md)

 - [Delete](api-ref/grpc/DesktopGroup/delete.md)

 - [Update](api-ref/grpc/DesktopGroup/update.md)

 - [ListAccessBindings](api-ref/grpc/DesktopGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/DesktopGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/DesktopGroup/updateAccessBindings.md)

#### DesktopImage

 - [Overview](api-ref/grpc/DesktopImage/index.md)

 - [List](api-ref/grpc/DesktopImage/list.md)

 - [Get](api-ref/grpc/DesktopImage/get.md)

 - [Copy](api-ref/grpc/DesktopImage/copy.md)

 - [CopyFromDesktop](api-ref/grpc/DesktopImage/copyFromDesktop.md)

 - [Update](api-ref/grpc/DesktopImage/update.md)

 - [Delete](api-ref/grpc/DesktopImage/delete.md)

#### Desktop

 - [Overview](api-ref/grpc/Desktop/index.md)

 - [Get](api-ref/grpc/Desktop/get.md)

 - [GetRdpFile](api-ref/grpc/Desktop/getRdpFile.md)

 - [List](api-ref/grpc/Desktop/list.md)

 - [ListOperations](api-ref/grpc/Desktop/listOperations.md)

 - [Create](api-ref/grpc/Desktop/create.md)

 - [ResetPassword](api-ref/grpc/Desktop/resetPassword.md)

 - [Restart](api-ref/grpc/Desktop/restart.md)

 - [Start](api-ref/grpc/Desktop/start.md)

 - [Stop](api-ref/grpc/Desktop/stop.md)

 - [Update](api-ref/grpc/Desktop/update.md)

 - [UpdateProperties](api-ref/grpc/Desktop/updateProperties.md)

 - [Delete](api-ref/grpc/Desktop/delete.md)

#### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

### REST (англ.)

 - [Overview](api-ref/index.md)

#### DesktopGroup

 - [Overview](api-ref/DesktopGroup/index.md)

 - [Get](api-ref/DesktopGroup/get.md)

 - [List](api-ref/DesktopGroup/list.md)

 - [ListDesktops](api-ref/DesktopGroup/listDesktops.md)

 - [ListOperations](api-ref/DesktopGroup/listOperations.md)

 - [Create](api-ref/DesktopGroup/create.md)

 - [Delete](api-ref/DesktopGroup/delete.md)

 - [Update](api-ref/DesktopGroup/update.md)

 - [ListAccessBindings](api-ref/DesktopGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/DesktopGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/DesktopGroup/updateAccessBindings.md)

#### DesktopImage

 - [Overview](api-ref/DesktopImage/index.md)

 - [List](api-ref/DesktopImage/list.md)

 - [Get](api-ref/DesktopImage/get.md)

 - [Copy](api-ref/DesktopImage/copy.md)

 - [CopyFromDesktop](api-ref/DesktopImage/copyFromDesktop.md)

 - [Update](api-ref/DesktopImage/update.md)

 - [Delete](api-ref/DesktopImage/delete.md)

#### Desktop

 - [Overview](api-ref/Desktop/index.md)

 - [Get](api-ref/Desktop/get.md)

 - [GetRdpFile](api-ref/Desktop/getRdpFile.md)

 - [List](api-ref/Desktop/list.md)

 - [ListOperations](api-ref/Desktop/listOperations.md)

 - [Create](api-ref/Desktop/create.md)

 - [ResetPassword](api-ref/Desktop/resetPassword.md)

 - [Restart](api-ref/Desktop/restart.md)

 - [Start](api-ref/Desktop/start.md)

 - [Stop](api-ref/Desktop/stop.md)

 - [Update](api-ref/Desktop/update.md)

 - [UpdateProperties](api-ref/Desktop/updateProperties.md)

 - [Delete](api-ref/Desktop/delete.md)

#### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

 - [Аудитные логи Cloud Desktop](at-ref.md)

 - [История изменений](release-notes.md)