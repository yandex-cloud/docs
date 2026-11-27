---
title: Ошибка {{ datalens-full-name }} ERR.DS_API.SOURCE.INCONSISTENT
description: На странице приведено описание ошибки {{ datalens-full-name }} Data sources are inconsistent.
alternate:
  - href: ru/datalens/troubleshooting/errors/ERR-DS_API-SOURCE-INCONSISTENT.md
    type: text/markdown
    title: Markdown version
---

# [{{ datalens-full-name }}] Data sources are inconsistent

`ERR.DS_API.SOURCE.INCONSISTENT`

Возникает при некорректном наборе источников файлового подключения: например, новый источник добавлен без файла или замена ссылается на источник, которого нет среди сохраненных.

Чтобы исправить ошибку:

* Проверьте список файлов и замен в подключении.
* Удалите несохраненные источники.
* Загрузите файлы заново.


Если ошибка сохраняется, обратитесь в [техническую поддержку]({{ link-console-support }}) {{ yandex-cloud }}. В сообщении опишите, когда возникает ошибка.

