# Рабочие столы и их группы

Основной ресурс сервиса {{ cloud-desktop-name }} — _рабочий стол_. Это виртуальное рабочее пространство под управлением ОС Windows, развернутое в инфраструктуре {{ yandex-cloud }}.

Один рабочий стол закрепляется за одним пользователем организации, созданной в {{ org-name }}. Для подключения к рабочему столу используется [Remote Desktop Protocol]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Remote_Desktop_Protocol){% endif %} (RDP).

Каждый рабочий стол относится к _группе рабочих столов_. Для всех рабочих столов в группе используются одинаковые вычислительные ресурсы и одна и та же [сеть](../../vpc/concepts/network.md).