{% note info %}

If the `Deny` action is set for the default basic rule and the requests are sent to {{ captcha-name }} for verification, add a basic rule that allows requests to the CAPTCHA. The address of the allowed request matches the regular expression: `/(captcha_smart.*.(css|js)|showcaptcha|checkcaptcha)`. Set the rule to have a higher priority than rules sending CAPTCHA requests.

{% endnote %}