{% note info %}

When using the Kibana API:

* To send requests, use port `443` instead of standard port `5601`.
* Add the SSL certificate path to your application's configuration to use the API. For example, for Winlogbeat, specify the path in the `ssl.certificate_authorities` variable.

{% endnote %}
