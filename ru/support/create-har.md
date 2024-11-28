---
title: Сохранение взаимодействия браузера и сервера в HAR-файл
description: В этой статье вы узнаете о том, как сохранить историю взаимодействия браузера и сервера в HAR-файл.
---

# Сохранение взаимодействия браузера и сервера в HAR-файл

Если при работе в консоли {{ yandex-cloud }} возникла ошибка, разобраться с ней поможет HAR-файл. Это сетевой журнал взаимодействий браузера с веб-страницей. Чтобы специалисты {{ yandex-cloud }} обнаружили причину некорректной работы сервиса, включите запись журнала и воспроизведите ошибку. Сохраните HAR-файл и передайте его в [техническую поддержку]({{ link-console-support }}).

{% list tabs group=web_browsers %}

- Яндекс Браузер {#yandex}

  {% include [create-har-yandex](../_includes/support/create-har-yandex.md) %}

- Google Chrome {#chrome}

  {% include [create-har-chrome](../_includes/support/create-har-chrome.md) %}

- Opera {#opera}

  {% include [create-har-opera](../_includes/support/create-har-opera.md) %}

- Mozilla Firefox {#firefox}

  {% include [create-har-firefox](../_includes/support/create-har-firefox.md) %}

- Microsoft Edge {#edge}

  {% include [create-har-edge](../_includes/support/create-har-edge.md) %}

- Safari {#safari}

  {% include [create-har-safari](../_includes/support/create-har-safari.md) %}

{% endlist %}

{% note alert %}

В HAR-файле содержатся куки вашей активной сессии в {{ yandex-cloud }}. Для обеспечения безопасности рекомендуется [завершить сессию]({{ link-auth-logout }}) после передачи файла.

{% endnote %}
