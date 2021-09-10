{% if audience != "internal" %}

To use graphical IDEs, [download the certificate](https://{{ s3-storage-host }}{{ pem-path }}) and specify the path to it in the connection settings.

{% else %}

To use graphical IDEs, [download the certificate]({{ pem-path }}) and specify the path to it in the connection settings.

{% endif %}
