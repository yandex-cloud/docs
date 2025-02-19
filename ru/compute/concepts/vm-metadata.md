---
title: Метаданные виртуальной машины {{ compute-name }}
description: Из этой статьи вы узнаете о метаинформации, доступной в сервисе метаданных виртуальных машин {{ compute-full-name }}.
---

# Метаданные виртуальной машины

{% note info %}

[Получить](./metadata/accessing-metadata.md) прямой доступ (без аутентификации) к метаданным можно через специальный [сервис метаданных](#metadata-formats), доступный внутри ВМ по URL `http://169.254.169.254`. Сервис метаданных внутри ВМ доступен для всех виртуальных машин, независимо от их сетевых настроек и наличия доступа в интернет.

{% endnote %}

_Метаданные виртуальной машины_ — это метаинформация (дополнительная информация) о [виртуальной машине](./vm.md).

Сервис метаданных виртуальной машины хранит метаданные в [каталогах](./metadata/directories.md) в виде пар ключ-значение. 

Метаданные могут использоваться:
* Для работы процесса [cloud-init](https://cloudinit.readthedocs.io/en/latest/index.html) при создании ВМ.
* Для передачи в ключе `user-data` необходимой информации сервисам или приложениям, которые запускаются на ВМ уже после ее создания.
* Для получения изнутри ВМ данных, необходимых для аутентификации в {{ yandex-cloud }}.

Идентификатор виртуальной машины, идентификатор [образа](./image.md) {{ marketplace-name }}, а также ряд других значений из состава метаданных формируют уникальный [идентификационный документ](./metadata/identity-document.md) этой виртуальной машины.

## Параметры сервиса метаданных ВМ {#metadata-formats}

В {{ yandex-cloud }} доступ к метаданным ВМ можно получить в формате [Google Compute Engine](https://en.wikipedia.org/wiki/Google_Compute_Engine) (поддерживаются не все поля). Этот формат является наиболее безопасным и рекомендуемым форматом работы с метаданными ВМ. При [обращении](./metadata/accessing-metadata.md) к сервису метаданных необходимо использовать HTTP-заголовок `Metadata-Flavor:Google`.

В виртуальных машинах {{ compute-name }} доступны следующие настройки сервиса метаданных ВМ:

{% include [metadata-service-settings](../../_includes/compute/metadata-service-settings.md) %}

Получить текущие значения параметров сервиса метаданных ВМ вы можете вместе с [информацией о ВМ](./metadata/accessing-metadata.md#external-access) с помощью [CLI](../../cli/cli-ref/compute/cli-ref/instance/get.md) и [API](../api-ref/Instance/get.md).

Настроить параметры сервиса метаданных вы можете при [создании](../operations/index.md#vm-create) или [изменении](../operations/vm-control/vm-update.md) ВМ. Подробнее о том, как настроить параметры сервиса метаданных, см. в [инструкции](../operations/vm-metadata/setup-metadata-service.md).

#### См. также {#see-also}

* [{#T}](./metadata/directories.md)
* [{#T}](./metadata/public-image-keys.md)
* [{#T}](./metadata/sending-metadata.md)
* [{#T}](./metadata/accessing-metadata.md)
* [{#T}](./metadata/identity-document.md)
* [{#T}](instance-groups/instance-template.md)