---
title: Ошибка ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX
description: На странице приведено описание ошибки ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX.
---

# Неверный формат ссылки на Яндекс Документы

`ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX`

Ошибка возникает при создании подключения к Яндекс Документам, если в ссылке на добавляемый файл присутствует `/d` вместо `/i`. Например:

* `https://disk.yandex.ru/i/id` — верный формат ссылки;
* `https://disk.yandex.ru/d/id` — неверный формат ссылки.

Чтобы исправить ошибку, удалите ссылку на файл в Яндекс Документах и через некоторое время сгенерируйте ее заново.