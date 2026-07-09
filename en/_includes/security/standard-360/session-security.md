# Session and cookie security recommendations

## Session and cookie security

### Cookie lifetime is limited according to the information security policy of your organization {#Y360-2}

**Y360-2**

You can select the time interval before employees need to log in again. By default, session cookie lifetime is unlimited. Set this value to comply with your organization's information security policy. You can do this with an API request. For more information, see [this API guide](https://yandex.ru/dev/api360/doc/ref/DomainSessionsService/DomainSessionsService_Update.html).

{% include [cookie-lifetime](cookie-lifetime.md) %}