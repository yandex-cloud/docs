#### Квоты {#vc-quotas}

Vibecraft основывается на компонентах {{ src-name }} и {{ yandex-cloud }}, в которых установлены определенные ограничения:
* [Квоты в {{ ca-full-name }}]({{ link-src-docs }}/code-assistant/concepts/limits)
* [Квоты и лимиты в {{ src-full-name }}]({{ link-src-docs }}/sourcecraft/concepts/limits)
* [Квоты и лимиты {{ container-registry-full-name }}](../../container-registry/concepts/limits)
* [Квоты и лимиты {{ serverless-containers-full-name }}](../../serverless-containers/concepts/limits)
* [Квоты и лимиты {{ lockbox-full-name }}](../../lockbox/concepts/limits)
* [Квоты и лимиты {{ ydb-full-name }}](../../ydb/concepts/limits)
* [Квоты и лимиты {{ api-gw-full-name }}](../../api-gateway/concepts/limits)
* [Квоты и лимиты {{ dns-full-name }}](../../dns/concepts/limits)

#### Лимиты {#vc-limits}

Вид ограничения | Значение
--- | ---
Количество одновременно редактируемых проектов | 3
Количество опубликованных проектов | 10

{% note tip %}

Помимо лимитов учитывайте квоты {{ src-name }} и {{ yandex-cloud }}.

Если вам необходимо больше ресурсов, увеличьте квоты одним из способов:
* [Сформируйте запрос на увеличение]({{ link-console-quotas }}).
* Обратитесь в [техническую поддержку]({{ link-console-support }}) и расскажите, какие потребляемые квоты нужно увеличить и на сколько.

Управлять квотами позволяет сервис [{{ quota-manager-full-name }}](../../quota-manager/quickstart).

{% endnote %}