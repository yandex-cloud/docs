Under **{{ ui-key.yacloud.smart-web-security.waf.label_request-condition_33CzA }}**, select the traffic to exclude from the check:
  * **Entire request**: The exclusion will apply to the entire HTTP request.
  * **Request part**: The exclusion will apply only to selected parts of the request, thus allowing you to exclude only the particular questionable parameter. The rest of the request will be checked according to the WAF profile settings.

    In the **Request parts** field, select one or more of the following: 
       
    * `HTTP body`: HTTP request body. Use if you get a false positive when parsing the request body, e.g., JSON, XML, forms.
    * `Cookie`: `Cookie` value. 
    * `HTTP header`: HTTP header. Use if you get a false positive in a specific header's value, e.g., `User-Agent`, `Referer`, `Authorization`, or a custom header.
    * `Query params`: Query string parameters.
  
    Set one or more values for each parameter other than `HTTP body`. To add one more value for a parameter, click ![plus-sign](../../_assets/console-icons/plus.svg) **or**. Enable **Case sensitive** as needed.