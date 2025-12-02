---
title: Список релизов {{ org-full-name }} sync agent
description: На странице представлены релизы агента синхронизации, а также изменения в каждом из них.
---

# Релизы {{ org-full-name }} sync agent

## Текущая версия {#latest-release}

### Версия 0.37.0 (28.11.25) {#version0.37.0}

#### Изменения в {{ org-full-name }} sync agent

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
