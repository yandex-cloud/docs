{% note warning %}
              
 The user must have the [readonly]({{ ch.docs }}{{ lang }}/operations/settings/permissions-for-queries#settings_readonly) parameter set to one of the following values:
         
  * `0`: Allows all queries.
  * `1`: Allows only data read queries. In this case, specify the following in the {{ CH }} [settings]({{ ch.docs }}{{ lang }}/operations/settings/settings):

    * `join_use_nulls = 1`
    * `send_progress_in_http_headers = 0`
    * `output_format_json_quote_denormals = 1`

    For {{ datalens-short-name }}, set the `Readonly` parameter to `1` in the connection's advanced settings.

  * `2`: Allows queries to read data and edit settings.
          
{% endnote %}