# История изменений в {{ backup-full-name }}

## II квартал 2024 {#q2-2024}

* Обновлен агент резервного копирования {{ backup-name }}.
* Добавлена поддержка новых операционных систем:
  * [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts)
  * [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin)
  * [CentOS Stream](/marketplace/products/yc/centos-stream-8)
  * [Astra Linux SE 1.7 «Воронеж»](/marketplace/products/astralinux/alse)
  * [Astra Linux SE 1.7 «Орел»](/marketplace/products/astralinux/alse-orel)
* Добавлена поддержка образов с OS Login:
  * [Ubuntu 20.04 LTS OS Login](/marketplace/products/yc/ubuntu-2004-lts-oslogin)
  * [Ubuntu 18.04 LTS OS Login](/marketplace/products/yc/ubuntu-1804-lts-oslogin)
  * [CentOS 7 OS Login](/marketplace/products/yc/centos-7-oslogin)
* Добавлены метод REST API [listTasks](./backup/api-ref/Resource/listTasks.md) для ресурса [Resource](./backup/api-ref/Resource/index.md) и вызов gRPC API [ResourceService/ListTasks](./backup/api-ref/grpc/resource_service.md#ListTasks). С их помощью вы можете просматривать действия по резервному копированию подключенных ВМ.
* В методах REST API для ресурса [Resource](./backup/api-ref/Resource/index.md) и в вызовах gRPC API [ResourceService](./backup/api-ref/grpc/resource_service.md) добавлены параметры:
  * `initStatus` — статус инициализации ВМ в {{ backup-name }};
  * `metadata` — метаданные для получения подробной информации о процессе регистрации ВМ в {{ backup-name }}.
* [Аудитные логи](at-ref.md) сервиса дополнены событиями:
  * `InitResource` — инициализация подключения ВМ к {{ backup-name }};
  * `UpdateResource` — обновление статуса подключения ВМ к {{ backup-name }}.

## I квартал 2024 {#q1-2024}

* В консоли управления на вкладке ![list-check](../_assets/console-icons/list-check.svg) **Операции** часть заведомо долгих действий переведена в асинхронные операции, для некоторых действий добавлено отображение процента выполнения.
* Обновлена механика применения изменений для правил [хранения резервных копий](./concepts/policy.md#retention). Теперь по умолчанию новые правила вступают в силу после создания очередной резервной копии.
* Добавлена поддержка создания политики с пользовательской схемой расписания резервного копирования `scheduling.scheme=CUSTOM`. Подробнее см. [Спецификация политики резервного копирования](./concepts/policy.md#specification).