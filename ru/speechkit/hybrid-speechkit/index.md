# О технологии {{ sk-hybrid-name }}

{{ sk-hybrid-name }} — это технологии {{ speechkit-full-name }}, работающие внутри вашей инфраструктуры. В основе {{ sk-hybrid-name }} лежат {% if lang == "ru" %}[контейнеры Docker](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}контейнеры Docker{% endif %}, которые отлично подходят для обеспечения требований к безопасности и управлению данными. 
 
{{ sk-hybrid-name }} основан на тех же моделях синтеза и распознавания речи, что и {{ speechkit-name }}. Вы можете бесплатно обновить {{ sk-hybrid-name }} до актуальной версии в любой момент, но это необязательно.

{% if product == "yandex-cloud" %}

Рекомендуемые конфигурации оборудования и список необходимого ПО см. в разделе [{#T}](system-requirements.md).

{% endif %}

Для получения доступа к {{ sk-hybrid-name }} [оставьте заявку]{% if product == "yandex-cloud" %}{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit#contact-form){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit#contact-form){% endif %}{% endif %}{% if product == "cloud-il" %}(https://cloudil.co.il/services/speechkit#contact-form){% endif %}.