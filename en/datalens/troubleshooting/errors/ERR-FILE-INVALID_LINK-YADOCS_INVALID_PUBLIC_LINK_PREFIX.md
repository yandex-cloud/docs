---
title: ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX error
description: This page describes the ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX error.
---

# Incorrect Yandex Documents link format

`ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX`

The error occurs when creating a connection to Yandex Documents if the link to the file you are adding contains `/d` instead of `/i`. Here is an example:

* `https://disk.yandex.ru/i/id` is the correct link format.
* `https://disk.yandex.ru/d/id` is the invalid link format.

To fix the problem, delete the URL to your Yandex Documents file and after a while generate a new one.