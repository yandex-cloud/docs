# Устранение ошибки `FAILED_PRECONDITION: Relocation to zone "ru-central1-a/b/c" is disabled`


## Описание проблемы {#issue-description}

При попытке переместить виртуальную машину или диск в зону доступности, отличающуюся от `ru-central1-d`, возникает ошибка:

```
ERROR ClientError: /yandex.cloud.compute.v1.InstanceService/Relocate
FAILED_PRECONDITION: Relocation to zone "ru-central1-a" is disabled
ERROR ClientError: /yandex.cloud.compute.v1.InstanceService/Relocate
FAILED_PRECONDITION: Relocation to zone "ru-central1-a" is disabled
```

## Решение {#issue-resolution}

Сейчас релокация ресурсов разрешена только в зону `ru-central1-d`, ее основная задача - миграция ресурсов из зоны `ru-central1-c`. Подробнее об этом можно прочитать в [документации](../../../compute/operations/vm-control/vm-change-zone.md).