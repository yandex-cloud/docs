---
title: Образы в {{ baremetal-full-name }}
description: Узнайте, чем отличаются образы {{ marketplace-short-name }} для автоматической установки ПО на серверы {{ baremetal-name }} от загрузочных ISO-образов.
---

# Образы в {{ baremetal-full-name }}

_Образы_ в {{ baremetal-full-name }} позволяют устанавливать или запускать на [серверах](./servers.md) операционные системы и другие программные продукты. В сервисе используются два типа образов:

* [Образы {{ marketplace-short-name }}](#marketplace-images) — для автоматической установки операционной системы или приложения при аренде сервера или переустановке ОС.
* [Загрузочные образы](#user-images) — для запуска сервера с ISO-образа и самостоятельной установки ПО, диагностики или устранения неполадок.

## Образы {{ marketplace-short-name }} {#marketplace-images}

_Образ {{ marketplace-short-name }}_ для {{ baremetal-name }} содержит программный продукт, подготовленный для использования на серверах {{ baremetal-name }}. Это может быть операционная система, например Ubuntu или AlmaLinux, либо готовое приложение на базе ОС, например сервер OpenVPN.

Образы содержат необходимые драйверы оборудования и настройки и протестированы для работы на серверах {{ baremetal-name }}. Они устанавливаются автоматически при [аренде сервера](../operations/servers/server-lease.md) или [переустановке ОС](../operations/servers/reinstall-os-from-marketplace.md).

Актуальный список доступных образов приведен в [консоли управления]({{ link-console-main }}/link/marketplace/products?productTypes=BAREMETAL) и на [сайте {{ marketplace-short-name }}](https://yandex.cloud/ru/marketplace?type=BAREMETAL&pageSize=30).

{% note info %}

Образы {{ baremetal-name }} — отдельный тип продуктов {{ marketplace-short-name }}, который отличается от образов виртуальных машин. Для автоматической установки на серверы {{ baremetal-name }} можно использовать только продукты этого типа.

{% endnote %}

{% note warning %}

Использование некоторых образов может тарифицироваться дополнительно. Стоимость продукта отображается в консоли управления при аренде сервера.

{% endnote %}

Образы в {{ marketplace-short-name }} добавляют партнеры {{ yandex-cloud }}. Пользователи не могут самостоятельно добавлять образы для автоматической установки на серверы {{ baremetal-name }}.

## Загрузочные образы {#user-images}

_Загрузочный образ_, или _пользовательский ISO-образ_, — образ в формате [ISO](https://ru.wikipedia.org/wiki/ISO-образ), с которого можно запустить сервер. Такой образ монтируется через [KVM-консоль](../operations/servers/server-kvm.md) в виде виртуального CD-дисковода или флеш-накопителя и используется для самостоятельной установки операционной системы, диагностики или устранения неполадок.

Вы можете самостоятельно [создать загрузочный образ](../operations/image-upload.md) в {{ baremetal-name }} из собственного ISO-файла. Загрузочный образ не используется для автоматической установки ОС при аренде сервера.

Подробнее о монтировании ISO-образа — в инструкции [{#T}](../operations/servers/reinstall-os-from-own-image.md#boot-from-image).

## Примеры использования {#examples}

* [Переустановка ОС из образа {{ marketplace-short-name }}](../operations/servers/reinstall-os-from-marketplace.md).
* [Установка ОС из собственного загрузочного ISO-образа](../operations/servers/reinstall-os-from-own-image.md).
* [Диагностика и восстановление сервера с помощью Rescue-CD](../operations/servers/rescue-boot.md).

#### Полезные ссылки {#see-also}

* [{#T}](./server-advanced-settings.md)
