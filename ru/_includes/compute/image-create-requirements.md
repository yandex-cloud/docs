Для образов загрузочного диска должны выполняться следующие требования:

* Установлены драйверы `virtio-net` и `virtio-blk`. Если вы собираетесь подключать к ВМ [файловые хранилища](../../compute/concepts/filesystem.md), также должен быть установлен драйвер `virtiofs`. См. [инструкцию](../../compute/operations/image-create/custom-image.md#virtio).
* Терминал `ttyS0` (порт COM1) настроен в качестве [серийной консоли](../../compute/operations/serial-console/index.md). См. [инструкцию](../../compute/operations/image-create/custom-image.md#serial-console).
* Сетевой интерфейс корректно запускается при старте ВМ и получает IP-адрес по DHCP.
* Пакет `cloud-init` установлен и настроен для работы с нашим [сервисом метаданных](../../compute/operations/vm-info/get-info.md#inside-instance). Установить пакет для CentOS можно с помощью команды `sudo yum install cloud-init`, для Debian или Ubuntu — `sudo apt update && sudo apt install -y cloud-init`.
* В настройках системного файрвола открыт необходимый минимум портов для работы ваших приложений, а также порт для доступа по SSH (по умолчанию это порт 22 TCP).
* SSH-сервер запускается автоматически при старте ВМ.
* Сервисы с вашим приложением устойчивы к перезагрузке ВМ.
* Используется разбивка диска GPT.
* Диск смонтирован по UUID, а не по имени.