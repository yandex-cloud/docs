# General questions about Billing

#### Can I use my OS license for VM instances in {{ yandex-cloud }}? {#os-license}

Yes. For more information, see the section [How to create a VM instance](../../compute/operations/vm-create/create-linux-vm.md) in the documentation for the service [Yandex Compute Cloud](../../compute/).

#### Where can I find SLAs? {#sla}

In {{ yandex-cloud }}, each service has its own SLA. You can learn more about SLAs in the section [Legal documents]{% if product == "yandex-cloud" %}{% if lang == "ru" %}(https://yandex.ru/legal/cloud_sla/?lang=ru){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_sla/?lang=en){% endif %}{% endif %}{% if product == "cloud-il" %}(https://nebius.com/il/docs/legal/sla){% endif %}.

#### Where can I find the bank details of {{ yandex-cloud }}? {#requisites}

{% if region == "ru" %}

You can find the bank details {% if lang == "ru" %}in the [Yandex.Cloud LLC registration card](https://{{ s3-storage-host }}/doc-files/Yandex.Cloud_requisites.pdf) and {% endif %}in the section [Legal documents]{% if lang == "ru" %}(https://yandex.ru/legal/cloud_oferta/){% endif %}{% if lang == "en" %}(https://yandex.ru/legal/cloud_oferta/?lang=en){% endif %} (paragraph **18. Yandex Details**).

{% endif %}

{% if region == "kz" %}

You can find the bank details in the section [Legal documents](https://yandex.com/legal/cloud_oferta_kz/) (paragraph **18. Yandex Details**).

{% endif %}

{% if region == "int" %}

You can find the bank details in the section [Legal documents](https://yandex.com/legal/cloud_customer_agreement/) (paragraph **19. Yandex Details**).

{% endif %}

#### How do I contact technical support? {#support}

Depending on your pricing plan, you can [contact technical support]({{ link-console-support }}) in one of the following ways:

{% include [support-channels](../../_includes/support/channels.md) %}