### Yandex SmartCaptcha is used {#use-smartcaptcha}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | appsec.use-smartcaptcha ||
|#

#### Description

Public web forms — sign-in, registration, password recovery, comment forms, search — are a typical target for automated attacks: bots register fake accounts, brute-force passwords, scrape content, and submit spam.

[Yandex SmartCaptcha](https://yandex.cloud/en/docs/smartcaptcha/) protects forms from such requests. The service evaluates each request with ML models and shows a challenge only to suspicious clients, so most real users are not interrupted by a "I'm not a robot" check.

**Risks if the rule is not followed:** Without CAPTCHA protection, public web forms are vulnerable to automated bot attacks — credential stuffing, account enumeration, spam submissions, and content scraping — which can lead to account takeovers, service abuse, and data theft.

#### Instructions and solutions

Add SmartCaptcha to public forms that bots could abuse:

1. [Create a SmartCaptcha](https://yandex.cloud/en/docs/smartcaptcha/quickstart) and add the client-side widget to the form.
2. On the server, validate the SmartCaptcha token before processing the form.
3. Monitor the [SmartCaptcha statistics](https://yandex.cloud/en/docs/smartcaptcha/operations/look-statistics) to tune the captcha mode based on the share of traffic that is being challenged.
