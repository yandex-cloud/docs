[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Desktop](../index.md) > Концепции > Образы

# Образы

_Образ_ — это полная копия структуры файловой системы и данных, находящихся на диске. Образы Cloud Desktop обязательно содержат операционную систему.

Образ используется для создания [загрузочного диска](disks.md#boot-disk) рабочего стола. 

Подробнее про образы в [документации Compute Cloud](../../compute/concepts/image.md).

## Системные образы {#system-images}

Системные образы Cloud Desktop содержат базовую версию операционной системы, например Ubuntu 20.04 LTS.

Такие образы нельзя удалить.

## Пользовательские образы {#custom-images}

Вы можете добавлять в Cloud Desktop собственные образы, созданные на основе:

* [Рабочего стола](../operations/images/create-from-desktop.md) Cloud Desktop.
* [Виртуальной машины Linux](../operations/images/create-from-compute-linux.md) в Compute Cloud.
* [Собственного образа Windows](../operations/images/create-from-windows.md).

Разверните и настройте нужное программное окружение на рабочем столе, виртуальной машине или в образе и тиражируйте его среди пользователей с помощью образов Cloud Desktop.

Пользовательские образы можно [удалять](../operations/images/delete.md).