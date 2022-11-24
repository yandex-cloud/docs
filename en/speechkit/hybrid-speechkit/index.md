# About {{ sk-hybrid-name }} technology

{{ sk-hybrid-name }} are the {{ speechkit-full-name }} technologies running in your infrastructure. {{ sk-hybrid-name }} is built around {% if lang == "ru" %}[Docker containers](https://cloud.yandex.ru/blog/posts/2022/03/docker-containers){% else %}Docker containers{% endif %} that are great for ensuring security and meeting data management requirements.

{{ sk-hybrid-name }} is based on the same speech synthesis and recognition models as {{ speechkit-name }}. You can upgrade {{ sk-hybrid-name }} to the current version anytime for free.

{% if product == "yandex-cloud" %}

For recommended hardware configurations and the required software list, see [{#T}](system-requirements.md).

{% endif %}

To access {{ sk-hybrid-name }}, [submit a request]{% if product == "yandex-cloud" %}{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit#contact-form){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit#contact-form){% endif %}{% endif %}{% if product == "cloud-il" %}(https://cloudil.co.il/services/speechkit#contact-form){% endif %}.