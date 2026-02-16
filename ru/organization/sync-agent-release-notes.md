---
title: Список релизов {{ org-sync-agent-name }}
description: На странице представлены релизы агента синхронизации, а также изменения в каждом из них.
---

# Релизы {{ org-sync-agent-name }}

## Текущая версия {#latest-release}

### Версия 0.38.0 (08.12.2025) {#version0.38.0}

* Исправлен некорректный парсинг объектов Active Directory при наличии неизвестных атрибутов.

* Исправлено экранирование CN в фильтрах LDAP.

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| linux/amd64 | `87ccbc96e8d99baa6353d97688643f3b9284cfa01b4cde8982884c4620e73ae7` |
| linux/arm64 | `083d112c4bdf7d9ffbe89e6744120f657dd8da2ec8186156009a4e2d199c99ad` |
| darwin/amd64 | `077fde2da16904c288638f284626db34ff4758aa64d7d1483f54cd713c451bc2` |
| darwin/arm64 | `a79770081bf4943380613e73d45a43036922dd43b2f0e65e39e41c2fe520a05f` |
| windows/amd64 | `d9a9b6b4475c02d26a2f489ba0c62c37b468f763366cc265e9ea4859badc2fd2` |
| windows/arm64 | `89cf257f59abd98c191fa2329899c473b24a586fc54a1a3bf9eebfd976265067` |

{% endcut %}

## Предыдущие релизы {#previous-release}

### Версия 0.37.0 (28.11.2025) {#version0.37.0}

* Значение `replacement_domain` теперь подставляется независимо от того, соответствует ли домен в UPN домену в фильтре.

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| linux/amd64 | `1e5326bec14143fce1a1ba0ce4e7526dba386d8359228be1395cb4d52e8e118e` |
| linux/arm64 | `91f704dc50224cd9f4d4510025ad3dc96a88f72c46b0dece4fd7016bc6e88c05` |
| darwin/amd64 | `d5c4a2494f46900b8fa363cb438df9e6d36dbdaf8f5d2c8b5045e212c981f96e` |
| darwin/arm64 | `14921f083d91229ec5f86049993c3b7272dcb39722528c396405acd088b227b3` |
| windows/amd64 | `706dfb4814cd581473187245e8336267d5a720f7c512ad14db167f05ef15f43f` |
| windows/arm64 | `cf0bf71bd9dd17cc89dc514f90c7637d1df1929d1e35db29f86d9a2957535e29` |

{% endcut %}