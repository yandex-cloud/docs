# Incorrect Yandex Documents link format

`ERR.FILE.INVALID_LINK.YADOCS_INVALID_PUBLIC_LINK_PREFIX`

The error occurs when creating a connection to Yandex Documents if the link to the file you are adding contains `/d` instead of `/i`. For example:

* `https://disk.yandex.ru/i/id` is the correct URL format.
* `https://disk.yandex.ru/d/id` is the incorrect URL format.

To fix the problem, delete the URL to your Yandex Documents file and after a while generate a new one.