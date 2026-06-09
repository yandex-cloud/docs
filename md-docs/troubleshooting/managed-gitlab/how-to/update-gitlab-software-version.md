# Как обновить ПО на инстансе Managed Service for GitLab


## Описание проблемы {#case-description}

Необходимо обновить версию установленного пакета GitLab Community Edition или GitLab Enterprise Edition на инстансе Yandex Managed Service for GitLab.

## Решение {#case-resolution}

Самостоятельно обновить версию ПО не получится. Обновление ПО GitLab на инстансах Yandex Managed Service for GitLab производится автоматически по мере адаптации выходящих версий ПО GitLab к среде Yandex Cloud.

Если обновление ПО GitLab критически необходимо, [создайте запрос в техническую поддержку](https://center.yandex.cloud/support). При создании запроса укажите следующую информацию:

1. Идентификатор GitLab-инстанса, для которого нужно обновить версию установленного ПО.
1. Целевую версию GitLab, которую вы хотите установить.
1. Дату и время обновления.
1. Причину обновления.

{% note alert %}

Во время операции обновления ПО инстанс Managed Service for GitLab и данные на нем будут недоступны.

{% endnote %}