# Релизы Yandex Identity Hub Sync Agent

## Текущая версия {#latest-release}

### Версия 0.46.0 (18.05.26) {#version0.46.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.46.0}

* Добавлена возможность отправки логов в Yandex Cloud Logging: секция `logger.cloud_logger` с указанием `log_group_id`. В каждое сообщение добавляется `agent_id` для фильтрации.
* Добавлена поддержка записи логов в Windows Event Log в секции `logger.event_log`. Функция работает только в Windows. На других платформах эта конфигурация игнорируется с предупреждением.
* Добавлены параметры `--install-eventlog` и `--uninstall-eventlog` для регистрации источника Windows Event Log из конфигурации `logger.event_log.source`. Для запуска требуются права администратора.
* Добавлена аутентификация Kerberos по `keytab` для подключений к LDAP и DRSR.

{% cut "Контрольные суммы" %}

#|
|| **Платформа** | **Контрольная сумма (SHA-256)** ||
|| `linux/amd64` | `ab1edf86501289a2e6662b378a52b9d6f90257bbe3789d6e6728b2e1c5c62726` ||
|| `linux/arm64` | `e839705daf85ac599bd735d6dfe5746ba37f375d9b3cc21ce2a6e858e211abea` ||
|| `darwin/amd64` | `2834bb73fae3e2ae01099a711a4e0255b67c8aaab7e0e5a62b230cc64fe0cb23` ||
|| `darwin/arm64` | `d27360a21277bb2562a12fe9666dee5d37d7de31a4462f3bd6999545f099441c` ||
|| `windows/amd64` | `975781d116b2b68624b4b2d3f91cdcace9acd0a25ed549dd47f646a3a592b1c8` ||
|| `windows/arm64` | `d89a1744a4b18066dd86b9f5018d068ba532f19d9de63ccde65e26e33758cf39` ||
|#

{% endcut %}

### Версия 0.45.0 (27.04.26) {#version0.45.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.45.0}

* Исправлены проблемы с преждевременным завершением `dry-run` при использовании `use_session_api: true`.
* Исправлено зависание агента при остановке процесса `password writeback`.
* Добавлена поддержка атрибута `name`.

{% cut "Контрольные суммы" %}

#|
|| **Платформа** | **Контрольная сумма (SHA-256)** ||
|| `linux/amd64` | `87406dd51e1bf278ce14cf4cc0ae36bb0dfafe520d360986fe3f099a57ec2d3d` ||
|| `linux/arm64` | `509c5c9c54b68b878577add6eeb07d4700c1ffdbb368c8f553f3a1181657b8f4` ||
|| `darwin/amd64` | `2c34aa6d2b8b6ab5b04c448422566ef2e1d669b20c3cf186216770bf490d6a7a` ||
|| `darwin/arm64` | `9332e029c27cdfdfffa412bc4583b2201761b8d75750735f288a51617f1e4e1f` ||
|| `windows/amd64` | `4d326909988e6067a030f64c0903d49945a59483a97484dfcc1a8725b3adf4e1` ||
|| `windows/arm64` | `ba241239f511f800a44080927dd4b33fa390706f552b7d551ede519aa58be23c` ||
|#

{% endcut %}

### Версия 0.44.0 (20.04.26) {#version0.44.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.44.0}

* Исправлена ошибка, вызывавшая зависание при завершении процесса синхронизации.

{% cut "Контрольные суммы" %}

#|
|| **Платформа** | **Контрольная сумма (SHA-256)** ||
|| `linux/amd64` | `6748905e77906357a4163d61dcb4e089e2965dcac79def759fd44372b19f3286` ||
|| `linux/arm64` | `35d2fbc56f8c823332c0837d45e6700822732ed569f4f1ede1355143c0bc266c` ||
|| `darwin/amd64` | `d3a9277277662c13b9f9415637638140d08912e31c66ac4e26567524cd2fa2be` ||
|| `darwin/arm64` | `d3723b0ef1292f1d7abd119f2f9cd1bf32c2daaec0fced512fc62196a940a356` ||
|| `windows/amd64` | `d2b8245f86bc32a3696c6bce30496e80370f21267471be8f7258e90d66a209ce` ||
|| `windows/arm64` | `be2da0582f2600c2607536b8f9af6e8f8931041201ebc2c83c5e8afa77e35ad0` ||
|#

{% endcut %}

### Версия 0.43.0 (16.04.26) {#version0.43.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.43.0}

* Добавлен режим `dry-run` для просмотра изменений без их применения.
* Пользователи без пароля теперь создаются со сгенерированным паролем.

{% cut "Контрольные суммы" %}

#|
|| **Платформа** | **Контрольная сумма (SHA-256)** ||
|| `linux/amd64` | `d346d19a99660320cdb01ab4d42028de0f979e940b511a439d95b4774e5e07a8` ||
|| `linux/arm64` | `c170be5d07d3b4cfc49b3132a6bf78cf41acb8f998e238ab3de488e613fe3f05` ||
|| `darwin/amd64` | `4f7387234fc60145e65ff72c4486261360600e800f6000cff9c0813b020e7e0f` ||
|| `darwin/arm64` | `f9579051f9d84afd4088bd13b111e6a2cb1c4bd468be27a478b73e142d19f2cb` ||
|| `windows/amd64` | `49a0f39603c4f72d00b20efdbf2ca182394e528066a5f105170e53af4256c788` ||
|| `windows/arm64` | `436ca30f586afeafef2856097e462b62ae6736947be89978d84f580d8b8de6ca` ||
|#

{% endcut %}

### Версия 0.42.0 (09.04.26) {#version0.42.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.42.0}

* Добавлено свойство `objectSid` для сопоставления в поле `EmployeeId`.

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `6225fc50b5bbca21a6fdd76cd0f77cd781d8076ede647dc4ba98cca7e1e155bf` |
| `linux/arm64` | `f4daf49e3d550d1b0440a1b5520e6421c6a0a54f13401d7782165d9fb348ec38` |
| `darwin/amd64` | `222eabfa71abcd22799014985fb549597e78a026741e6ddc0a325b50ef3c3bb3` |
| `darwin/arm64` | `e342b4f27f8a7e500aaa50e0c9b49969a59e3481ce459d76ce6bbff2bedeebe7` |
| `windows/amd64` | `f0500c2d927a8f2effdb1d5368e87fee42f5d185d58251637050b60de9d5535c` |
| `windows/arm64` | `48a1e396058ff6ce757fda9e0d1c65e34d64232c317067a0c9b161f6e90c55a9` |

{% endcut %}

### Версия 0.41.0 (13.03.26) {#version0.41.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.41.0}

* При полной синхронизации список членов групп, попадающих под фильтр, получается через LDAP.

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `689ec3f3efb85b4447e008f29e70655e59dabbfbd0e616c22a21880cac3667dc` |
| `linux/arm64` | `24dc53ada7a1bf2a15d18c54106d7f47b543d3d3e175fddaea56c6e0fb7287c1` |
| `darwin/amd64` | `3909ce93f7d0d54915686cccc136b3498b556f8f51a562db309a2f45b1ca03ec` |
| `darwin/arm64` | `1a53e843e201dc18ef6cb112cae12e79659546f5aac2bb245496174a6ca642e0` |
| `windows/amd64` | `9749ca27d41f0b5cc1cfd0699805ecdee4797fc7f13f0a4c3f84a200dcee4079` |
| `windows/arm64` | `0e4de91cdaa696d42db63d10decedb0fbfc8096e42b8497ffb787c33930e1f7b` |

{% endcut %}

### Версия 0.40.0 (10.03.26) {#version0.40.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.40.0}

* Добавлена возможность получения IAM-токена из сервиса метаданных для обращения к API Yandex Identity Hub.

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `c999643fd28d08076ff1d25ddf11e56a4a854fa4f2189109994b68d33974f698` |
| `linux/arm64` | `74462de7defbd5beacab48d181697eb8d5efafbd198ff9ee55a38f9e34f38df5` |
| `darwin/amd64` | `42a80a36d1d91bb095df3db1a57bc9f4002bcea30ecb87edf922d82c4aa16b96` |
| `darwin/arm64` | `5b5f5a8ac35b3eef908ee4bf67414cbf58cd4be5b7d55cf3f67f10604ca17f78` |
| `windows/amd64` | `d1e8c771afff4a08eb4fcc23dcba0352796a3f67ede7a9329650a3c4b5a8c12c` |
| `windows/arm64` | `bd490392a86f809b66f70416f779058147d19f1f8700f4a30e62b2f17a202000` |

{% endcut %}

### Версия 0.39.0 (27.02.26) {#version0.39.0}

#### Изменения в Yandex Identity Hub Sync Agent {#changes-version0.39.0}

* Добавлена настройка `use_session_api` для запуска нескольких агентов одновременно.  

* Изменена валидация групп и organization units в фильтре.  

* Исправлена ошибка с отсутствием хеша пароля при переносе одного organization unit целиком в другой.  

* Добавлены новые атрибуты `employee_id`, `department`, `company_name`, `job_title`.  

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `03d148741cc24631d6d7a5385f4571ec91291de0e517387d38011183eda793e4` |
| `linux/arm64` | `2300e3f421094db85d7c339a35af33973da8afb21e51d4bda6c81cf1c1e18e8c` |
| `darwin/amd64` | `0e7e693ecefe8aa4c7c49569cbc6fee674c0d6a8172ef349916578c04c0fe9b4` |
| `darwin/arm64` | `ed1c8ab0117531b6732bb522ee9343af525511fbabe09d8e0c6eb55830582a5a` |
| `windows/amd64` | `0d86277fdb4ebd5483c2cdcebb2eb3cf6e39e5cdf8c7a82193ccf1011c49c31a` |
| `windows/arm64` | `4c2219e7abd00747c3422425456300d98775c426ba46e7fe73f4bc7d6fe30510` |

{% endcut %}

### Версия 0.38.0 (08.12.25) {#version0.38.0}

#### Изменения в Yandex Identity Hub sync agent {#changes-version0.38.0}

* Исправлен некорректный парсинг объектов AD при наличии неизвестных атрибутов.

* Исправлено экранирование CN в LDAP-фильтрах.

{% cut "Контрольные суммы" %}

| Платформа   | Контрольная сумма (sha-256) |
|-------------|-----------------------------|
| `linux/amd64` | `87ccbc96e8d99baa6353d97688643f3b9284cfa01b4cde8982884c4620e73ae7` |
| `linux/arm64` | `083d112c4bdf7d9ffbe89e6744120f657dd8da2ec8186156009a4e2d199c99ad` |
| `darwin/amd64` | `077fde2da16904c288638f284626db34ff4758aa64d7d1483f54cd713c451bc2` |
| `darwin/arm64` | `a79770081bf4943380613e73d45a43036922dd43b2f0e65e39e41c2fe520a05f` |
| `windows/amd64` | `d9a9b6b4475c02d26a2f489ba0c62c37b468f763366cc265e9ea4859badc2fd2` |
| `windows/arm64` | `89cf257f59abd98c191fa2329899c473b24a586fc54a1a3bf9eebfd976265067` |

{% endcut %}

### Версия 0.37.0 (28.11.25) {#version0.37.0}

#### Изменения в Yandex Identity Hub sync agent {#changes-version0.37.0}

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