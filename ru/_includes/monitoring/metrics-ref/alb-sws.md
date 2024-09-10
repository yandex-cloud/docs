Общие метки для всех метрик {{ sws-name }}:

| Метка | Значение |
| --- | --- |
| **Общие метки** |
| load_balancer | Имя [L7-балансировщика](../../../application-load-balancer/concepts/application-load-balancer.md) |
| http_router | Имя [HTTP-роутера](../../../application-load-balancer/concepts/http-router.md) |
| virtual_host | Имя [виртуального хоста](../../../application-load-balancer/concepts/http-router.md#virtual-host) |
| **Специальные метки** |
| security_profile | Идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) |
| rule_name | Имя [правила безопасности](../../../smartwebsecurity/concepts/rules.md) |

| Имя<br>Тип, единицы измерения | Описание |
| --- | --- |
| `load_balancer.smart_web_security.`<br/>`requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду.<br/>Общие метки:<ul><li>`route` — имя [маршрута](../../../application-load-balancer/concepts/http-router.md#routes).</li><li>`zone` — [зона доступности](../../../overview/concepts/geo-scope.md).</li><li>`backend` — имя бэкенда.</li><li>`backend_group` — имя [группы бэкендов](../../../application-load-balancer/concepts/backend-group.md).</li></ul><br/>Специальная метка `antirobot_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`captcha` — запрос направлен в сервис [{{ captcha-full-name }}](../../../smartcaptcha/) для дополнительной верификации.</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |
| `load_balancer.smart_web_security.`<br/>`arl_requests_per_second`<br/>`DGAUGE`, запросы/с | Количество запросов к защищаемому ресурсу в секунду, прошедшему через модуль [Advanced Rate Limiter](../../../smartwebsecurity/concepts/arl.md).<br/>Общая метка `folderId` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder).<br/><br/>Специальные метки:<ul><li>`arl_profile` — идентификатор профиля Advanced Rate Limiter.</li><li>`arl_verdict` — действие с запросом по результатам проверок. Возможные значения:<ul><li>`allow` — запрос направлен к виртуальному хосту.</li><li>`deny` — запрос заблокирован.</li></ul></li></ul> |
