---
canonical: '{{ link-docs }}/tutorials/dataplatform/billing-detail-files-processing'
alternate:
  - href: ru/query/tutorials/billing.md
    type: text/markdown
    title: Markdown version
---

# Обработка файлов детализации в сервисе {{ billing-name }}

{% include [sunset](../../_includes/query/sunset.md) %}

[{{ billing-name }}](../../billing/index.yaml) позволяет получать информацию об объеме использованных ресурсов, проверять расходы денежных средств и оплачивать потребление ресурсов. Детализацию расходов можно отправлять в [{{ objstorage-full-name }}](../../storage/index.yaml) и далее обрабатывать с помощью {{ yq-full-name }}.

{% include [billing-detail-files-processing](../../_tutorials/dataplatform/billing-detail-files-processing.md) %}
