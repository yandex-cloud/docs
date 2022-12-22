# Графики из {{ datalens-full-name }}

[{{ datalens-full-name }}](https://datalens.yandex-team.ru/) — сервис визуализации и {% if lang == "ru" and audience != "internal" %}[аналитики](../../glossary/data-analytics){% else %}аналитики{% endif %}, который позволяет создавать сложные чарты и дашборды, используя данные из множества источников.

Подробнее о возможностях сервиса читайте в [документации {{ datalens-full-name }}](../../datalens/overview.md).

Чтобы добавить график на вики-страницу, скопируйте на дашборде код для вставки:
1. Нажмите кнопку ![image](../../_assets/options.svg) в правом верхнем углу графика.
1. Выберите пункт **Получить ссылку и код** в выпадающем списке.
1. Перейдите на вкладку **Вики**.
1. Настройте параметры графика.
1. Скопируйте код.

Используйте полученный блок `iframe` для вставки на страницу:

```
{{iframe frameborder="0" width="350px" height="420px" src="https://charts.yandex-team.ru/preview/editor/fwnyltulelsq9?_embedded=1"}}
```
Подробнее о параметрах блока `iframe` читайте в разделе [{#T}](iframe.md).