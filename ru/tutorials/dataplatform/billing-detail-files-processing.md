# Обработка файлов детализации в сервисе {{ billing-name }}

[{{ billing-name }}](../../billing/index.yaml) позволяет получать информацию об объеме использованных ресурсов, проверять расходы денежных средств и оплачивать потребление ресурсов. Детализацию расходов можно отправлять в [{{ objstorage-full-name }}](../../storage/index.yaml) и далее обрабатывать с помощью [{{ yq-full-name }}](../../query/index.yaml).

{% include [billing-detail-files-processing](../../_tutorials/dataplatform/billing-detail-files-processing.md) %}
