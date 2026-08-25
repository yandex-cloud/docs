* [Почему ВМ или сервер {{ baremetal-name }} не добавляются в {{ backup-name }}?](#cannot-add-vm)

* [Как заново подключить к сервису ВМ или сервер {{ baremetal-name }}, удаленные из {{ backup-name }}?](#reconnect-deleted-vm)

* [Как заново подключить ВМ или сервер {{ baremetal-name }} к {{ backup-name }} после восстановления резервной копии в другую ВМ или другой сервер?](#how-to-renew-connection)

* [Почему не удаляются старые резервные копии после переподключения ВМ к {{ backup-name }}?](#old-backups-not-deleted)

* [Ошибка при попытке восстановить ВМ или сервер {{ baremetal-name }} из резервной копии](#recovery-error)

* [Ошибка при подключении ВМ на Windows](#windows-connection-issue)

* [Ошибка авторизации при установке агента {{ backup-name }} на ВМ Linux](#install-auth-error)

* [Как обновить агент {{ backup-name }} на ВМ?](#update-backup-agent)

* [Почему после обновления ОС перестало работать резервное копирование?](#kernel-update-consequences)

* [Почему создание резервной копии занимает так много времени?](#long-creation)

* [Создание инкрементальных резервных копий ВМ или сервера {{ baremetal-name }} занимает больше времени, чем обычно](#av-interaction)

* [Out-Of-Memory Killer (OOM Killer) в Linux завершает процесс агента {{ backup-name }}](#oom-solution)

* [Как восстановить ВМ или сервер {{ baremetal-name }} с LVM из резервной копии?](#restore-lvm)

* [Проблемы с установкой агента {{ backup-name }} на ВМ с низкими вычислительными ресурсами](#low-resources-installation)

* [Почему размер бэкапов {{ backup-name }} в консоли не совпадает с фактическим размером самих резервных копий?](#backup-size)

* [Если удалить ВМ, ее резервные копии останутся?](#backup-after-delete-vm)

* [Возникает ошибка с кодом 400 при установке агента](#agent-installation-error)

* [Как посмотреть журналы использования сервиса {{ backup-name }}?](#get-logs)

* [Возникает ошибка Unable to install agent при установке](#unable-to-install-agent)

* [ВМ {{ backup-name }} долго находится в статусе `Регистрируется`](#vm-long-register)