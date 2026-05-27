# Yandex Cloud Backup

Сервис Yandex Cloud Backup позволяет настроить автоматическое резервное копирование виртуальных машин сервиса <a href="../compute/index.md">Yandex Compute Cloud</a>, а также серверов <a href="../baremetal/index.md">Yandex BareMetal</a>.

# Yandex Cloud Backup

## Начало работы

 - [Обзор](quickstart/index.md)

 - [Начать работать с Cloud Backup на новой ВМ](quickstart/new-vm.md)

 - [Начать работать с Cloud Backup на существующей ВМ](quickstart/existing-vm.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

 - [Активировать сервис](operations/activate-service.md)

### ВМ в Cloud Backup

 - [Создать и подключить ВМ на Linux](operations/create-vm.md)

 - [Создать и подключить ВМ на Windows](operations/create-vm-windows.md)

#### Подключить существующую ВМ к Cloud Backup

 - [Подключить существующую ВМ на Linux](operations/connect-vm-linux.md)

 - [Подключить существующую ВМ на Linux с OS Login](operations/connect-vm-oslogin-linux.md)

 - [Подключить существующую ВМ на Windows](operations/connect-vm-windows.md)

 - [Переподключить ВМ к Cloud Backup](operations/refresh-connection.md)

 - [Переподключить ВМ на Linux с OS Login к Cloud Backup](operations/refresh-connection-oslogin-linux.md)

 - [Обновить или восстановить агент Cloud Backup](operations/update-backup-agent.md)

 - [Посмотреть статус подключения ВМ](operations/get-connection-status.md)

 - [Посмотреть журнал резервного копирования](operations/get-journal.md)

 - [Удалить ВМ из Cloud Backup](operations/delete-vm.md)

### BareMetal в Cloud Backup

 - [Арендовать сервер BareMetal с подключением к Cloud Backup](operations/backup-baremetal/lease-server-with-backup.md)

 - [Подключить существующий сервер BareMetal к Cloud Backup](operations/backup-baremetal/backup-baremetal.md)

 - [Переподключить сервер BareMetal к Cloud Backup](operations/backup-baremetal/refresh-connection.md)

 - [Восстановить работу агента Cloud Backup](operations/backup-baremetal/restore-agent.md)

### Политики резервного копирования

 - [Создать политику](operations/policy-vm/create.md)

 - [Изменить политику](operations/policy-vm/update.md)

 - [Привязать ВМ или сервер BareMetal к политике](operations/policy-vm/attach-and-detach-vm.md)

 - [Получить информацию о политике](operations/policy-vm/get-info.md)

 - [Отвязать ВМ или сервер BareMetal от политики](operations/policy-vm/detach-vm.md)

 - [Удалить политику](operations/policy-vm/delete.md)

### Резервные копии

 - [Создать копию](operations/backup-vm/create.md)

 - [Восстановить ВМ или сервер BareMetal из копии](operations/backup-vm/recover.md)

 - [Восстановить ВМ или сервер BareMetal из копии другой ВМ или сервера BareMetal](operations/backup-vm/non-native-recovery.md)

 - [Восстановить отдельные директории и файлы из резервной копии](operations/backup-vm/recover-file-by-file.md)

 - [Посмотреть параметры дисков и разделов в резервной копии](operations/backup-vm/view-disk-layout.md)

 - [Удалить копию](operations/backup-vm/delete.md)

 - [Удалить все копии ВМ или сервера BareMetal](operations/backup-vm/batch-delete.md)

 - [Посмотреть операции с ресурсами сервиса](operations/operation-logs.md)

 - [Ограничить использование оперативной памяти агентом Cloud Backup](operations/limit-agent-memory-usage.md)

 - [Посмотреть статистику резервного копирования](operations/get-stats.md)

 - [Настроить алерты Monium](operations/configure-alerts.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Подключение сервера BareMetal к Cloud Backup](tutorials/backup-baremetal.md)

### Автоматическая привязка политики резервного копирования к ВМ

 - [Обзор](tutorials/vm-with-backup-policy/index.md)

 - [Консоль управления, CLI, API](tutorials/vm-with-backup-policy/console.md)

 - [Terraform](tutorials/vm-with-backup-policy/terraform.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

 - [Подключение ВМ и серверов BareMetal к сервису](concepts/vm-connection.md)

 - [Политики резервного копирования](concepts/policy.md)

 - [Резервные копии](concepts/backup.md)

 - [Взаимодействие с антивирусом](concepts/av-interaction.md)

 - [Агент Cloud Backup](concepts/agent.md)

 - [Квоты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

## Справочник CLI (англ.)

 - [Overview](cli-ref/index.md)

### agent

 - [Overview](cli-ref/agent/index.md)

 - [debug-info](cli-ref/agent/debug-info.md)

 - [install](cli-ref/agent/install.md)

 - [reinstall](cli-ref/agent/reinstall.md)

### backup

 - [Overview](cli-ref/backup/index.md)

 - [batch-delete](cli-ref/backup/batch-delete.md)

 - [delete](cli-ref/backup/delete.md)

 - [get](cli-ref/backup/get.md)

 - [list](cli-ref/backup/list.md)

 - [list-archives](cli-ref/backup/list-archives.md)

 - [recover](cli-ref/backup/recover.md)

### policy

 - [Overview](cli-ref/policy/index.md)

 - [apply](cli-ref/policy/apply.md)

 - [create](cli-ref/policy/create.md)

 - [delete](cli-ref/policy/delete.md)

 - [execute](cli-ref/policy/execute.md)

 - [get](cli-ref/policy/get.md)

 - [list](cli-ref/policy/list.md)

 - [list-applications](cli-ref/policy/list-applications.md)

 - [revoke](cli-ref/policy/revoke.md)

 - [update](cli-ref/policy/update.md)

### provider

 - [Overview](cli-ref/provider/index.md)

 - [activate](cli-ref/provider/activate.md)

### v0

 - [Overview](cli-ref/v0/index.md)

#### agent

 - [Overview](cli-ref/v0/agent/index.md)

 - [debug-info](cli-ref/v0/agent/debug-info.md)

 - [install](cli-ref/v0/agent/install.md)

 - [reinstall](cli-ref/v0/agent/reinstall.md)

#### backup

 - [Overview](cli-ref/v0/backup/index.md)

 - [batch-delete](cli-ref/v0/backup/batch-delete.md)

 - [delete](cli-ref/v0/backup/delete.md)

 - [get](cli-ref/v0/backup/get.md)

 - [list](cli-ref/v0/backup/list.md)

 - [list-archives](cli-ref/v0/backup/list-archives.md)

 - [recover](cli-ref/v0/backup/recover.md)

#### policy

 - [Overview](cli-ref/v0/policy/index.md)

 - [apply](cli-ref/v0/policy/apply.md)

 - [create](cli-ref/v0/policy/create.md)

 - [delete](cli-ref/v0/policy/delete.md)

 - [execute](cli-ref/v0/policy/execute.md)

 - [get](cli-ref/v0/policy/get.md)

 - [list](cli-ref/v0/policy/list.md)

 - [list-applications](cli-ref/v0/policy/list-applications.md)

 - [revoke](cli-ref/v0/policy/revoke.md)

 - [update](cli-ref/v0/policy/update.md)

#### provider

 - [Overview](cli-ref/v0/provider/index.md)

 - [activate](cli-ref/v0/provider/activate.md)

#### vm

 - [Overview](cli-ref/v0/vm/index.md)

 - [delete](cli-ref/v0/vm/delete.md)

 - [get](cli-ref/v0/vm/get.md)

 - [list](cli-ref/v0/vm/list.md)

 - [list-applicable-policies](cli-ref/v0/vm/list-applicable-policies.md)

 - [list-policies](cli-ref/v0/vm/list-policies.md)

 - [list-tasks](cli-ref/v0/vm/list-tasks.md)

### vm

 - [Overview](cli-ref/vm/index.md)

 - [delete](cli-ref/vm/delete.md)

 - [get](cli-ref/vm/get.md)

 - [list](cli-ref/vm/list.md)

 - [list-applicable-policies](cli-ref/vm/list-applicable-policies.md)

 - [list-policies](cli-ref/vm/list-policies.md)

 - [list-tasks](cli-ref/vm/list-tasks.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/backup/authentication.md)

### gRPC (англ.)

 - [Overview](backup/api-ref/grpc/index.md)

#### Backup

 - [Overview](backup/api-ref/grpc/Backup/index.md)

 - [ListArchives](backup/api-ref/grpc/Backup/listArchives.md)

 - [List](backup/api-ref/grpc/Backup/list.md)

 - [ListFiles](backup/api-ref/grpc/Backup/listFiles.md)

 - [Get](backup/api-ref/grpc/Backup/get.md)

 - [StartRecovery](backup/api-ref/grpc/Backup/startRecovery.md)

 - [StartFilesRecovery](backup/api-ref/grpc/Backup/startFilesRecovery.md)

 - [Delete](backup/api-ref/grpc/Backup/delete.md)

 - [DeleteArchive](backup/api-ref/grpc/Backup/deleteArchive.md)

#### Operation

 - [Overview](backup/api-ref/grpc/Operation/index.md)

 - [Get](backup/api-ref/grpc/Operation/get.md)

 - [Cancel](backup/api-ref/grpc/Operation/cancel.md)

#### Policy

 - [Overview](backup/api-ref/grpc/Policy/index.md)

 - [List](backup/api-ref/grpc/Policy/list.md)

 - [Create](backup/api-ref/grpc/Policy/create.md)

 - [Get](backup/api-ref/grpc/Policy/get.md)

 - [Update](backup/api-ref/grpc/Policy/update.md)

 - [Delete](backup/api-ref/grpc/Policy/delete.md)

 - [Apply](backup/api-ref/grpc/Policy/apply.md)

 - [ListApplications](backup/api-ref/grpc/Policy/listApplications.md)

 - [Execute](backup/api-ref/grpc/Policy/execute.md)

 - [Revoke](backup/api-ref/grpc/Policy/revoke.md)

#### Provider

 - [Overview](backup/api-ref/grpc/Provider/index.md)

 - [Activate](backup/api-ref/grpc/Provider/activate.md)

 - [ListActivated](backup/api-ref/grpc/Provider/listActivated.md)

#### Resource

 - [Overview](backup/api-ref/grpc/Resource/index.md)

 - [List](backup/api-ref/grpc/Resource/list.md)

 - [Get](backup/api-ref/grpc/Resource/get.md)

 - [Delete](backup/api-ref/grpc/Resource/delete.md)

 - [ListTasks](backup/api-ref/grpc/Resource/listTasks.md)

 - [ListDirectory](backup/api-ref/grpc/Resource/listDirectory.md)

 - [CreateDirectory](backup/api-ref/grpc/Resource/createDirectory.md)

 - [ListOperations](backup/api-ref/grpc/Resource/listOperations.md)

 - [GetInstanceRegistrationToken](backup/api-ref/grpc/Resource/getInstanceRegistrationToken.md)

#### Setup

 - [Overview](backup/api-ref/grpc/Setup/index.md)

 - [GetAgentInstallCommand](backup/api-ref/grpc/Setup/getAgentInstallCommand.md)

### REST (англ.)

 - [Overview](backup/api-ref/index.md)

#### Backup

 - [Overview](backup/api-ref/Backup/index.md)

 - [ListArchives](backup/api-ref/Backup/listArchives.md)

 - [List](backup/api-ref/Backup/list.md)

 - [ListFiles](backup/api-ref/Backup/listFiles.md)

 - [Get](backup/api-ref/Backup/get.md)

 - [StartRecovery](backup/api-ref/Backup/startRecovery.md)

 - [Delete](backup/api-ref/Backup/delete.md)

#### Operation

 - [Overview](backup/api-ref/Operation/index.md)

 - [Get](backup/api-ref/Operation/get.md)

 - [Cancel](backup/api-ref/Operation/cancel.md)

#### Policy

 - [Overview](backup/api-ref/Policy/index.md)

 - [List](backup/api-ref/Policy/list.md)

 - [Create](backup/api-ref/Policy/create.md)

 - [Get](backup/api-ref/Policy/get.md)

 - [Update](backup/api-ref/Policy/update.md)

 - [Delete](backup/api-ref/Policy/delete.md)

 - [Apply](backup/api-ref/Policy/apply.md)

 - [ListApplications](backup/api-ref/Policy/listApplications.md)

 - [Execute](backup/api-ref/Policy/execute.md)

 - [Revoke](backup/api-ref/Policy/revoke.md)

#### Provider

 - [Overview](backup/api-ref/Provider/index.md)

 - [Activate](backup/api-ref/Provider/activate.md)

 - [ListActivated](backup/api-ref/Provider/listActivated.md)

#### Resource

 - [Overview](backup/api-ref/Resource/index.md)

 - [List](backup/api-ref/Resource/list.md)

 - [Get](backup/api-ref/Resource/get.md)

 - [Delete](backup/api-ref/Resource/delete.md)

 - [ListTasks](backup/api-ref/Resource/listTasks.md)

#### Setup

 - [Overview](backup/api-ref/Setup/index.md)

 - [GetAgentInstallCommand](backup/api-ref/Setup/getAgentInstallCommand.md)

 - [Метрики Monitoring](metrics.md)

 - [Аудитные логи Audit Trails](at-ref.md)

 - [История изменений](release-notes.md)

 - [Решение проблем](qa/troubleshooting.md)