---
title: Миграция приложений с Ingress NGINX на Gwin в {{ managed-k8s-full-name }}
description: В статье приведено соответствие пользовательских аннотаций Ingress NGINX и Gwin, необходимое для миграции приложений на Gwin в {{ managed-k8s-name }}.
---

# Миграция приложений с Ingress NGINX на Gwin

{{ alb-full-name }} позволяет создавать балансировщики нагрузки и управлять ими в [кластерах {{ managed-k8s-full-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) с помощью контроллера [Gwin](gwin-index.md). Контроллер Gwin, установленный в кластере, автоматически разворачивает [L7-балансировщики](../../application-load-balancer/concepts/application-load-balancer.md) на основе конфигурации ваших ресурсов {{ k8s }}.

Чтобы перенести приложения с контроллера Ingress NGINX на Gwin, выполните следующие шаги:

1. [Установите контроллер Gwin](../../application-load-balancer/tools/gwin/quickstart.md) в вашем кластере.
1. Перенесите пользовательские аннотации с контроллера Ingress NGINX в контроллер Gwin, используя [таблицу соответствий](#table-nginx-gwin).
1. [Переключите нагрузку на контроллер Gwin](#switch-controller).

## Таблица соответствий аннотаций Ingress NGINX и Gwin {#table-nginx-gwin}

Для NGINX и Gwin в таблице указаны сокращенные имена аннотаций. Полные имена аннотаций для NGINX начинаются с `nginx.ingress.kubernetes.io/`, для Gwin — с `gwin.yandex.cloud/`.

#|
|| **NGINX** | **Gwin** | **Описание** ||
|| **Перенаправление** |  |  ||
|| `force-ssl-redirect`
`ssl-redirect`|  [redirect.{name}.replaceScheme](../gwin-ref/ingress.md#redirect-actions) | Перенаправляет на другой протокол (HTTP/HTTPS) ||
|| `permanent-redirect`
`temporal-redirect`
`app-root`
| [redirect.{name}.replaceScheme](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.replaceHost](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.replacePort](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.path.replacePath](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.path.replacePrefix](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.removeQuery](../gwin-ref/ingress.md#redirect-actions)
[redirect.{name}.responseCode](../gwin-ref/ingress.md#redirect-actions)
| Перенаправляют на другой адрес.

В Gwin для постоянного перенаправления указывается `redirect.{name}.responseCode = "301"`, для временного — `redirect.{name}.responseCode = "302"` ||
|| `rewrite-target`
| [rules.prefixRewrite](../gwin-ref/ingress.md#route-configuration)
[rules.hostRewrite.auto](../gwin-ref/ingress.md#host-rewriting)
[rules.hostRewrite.replace](../gwin-ref/ingress.md#host-rewriting)
[rules.http.regexRewrite.regex](../gwin-ref/ingress.md#path-rewriting)
[rules.http.regexRewrite.substitute](../gwin-ref/ingress.md#path-rewriting)
| Перезаписывает URL на уровне прокси без изменения адреса в браузере ||
|| **Конфигурация бэкенда** |  |  ||
|| `backend-protocol`
| [rules.backends.http.useHTTP2](../gwin-ref/ingress.md#backend-group-configuration)

[rules.backends.tls.sni](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.id](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.bytes](../gwin-ref/ingress.md#backend-tls-configuration)
| Определяет протокол соединения между балансировщиком нагрузки и бэкендами ||
|| **Аутентификация клиента** | |  ||
|| `auth-type`
`auth-secret`
`auth-secret-type`
`auth-realm`

`auth-tls-secret`
`auth-tls-verify-depth`
`auth-tls-verify-client`
`auth-tls-error-page`
`auth-tls-pass-certificate-to-upstream`
`auth-tls-match-cn`
| [{resource}.rbac.principals.{principal-group}.{principal}.{rule-type}](../gwin-ref/ingress.md#rbac-configuration)
| В NGINX аутентификация выполняется через HTTP (Basic/Digest) или TLS-сертификаты, в Gwin — с помощью системы управления доступом на основе ролей (RBAC). RBAC управляет доступом к маршрутам и хостам на основе атрибутов запроса ||
|| **Привязка сессии к бэкенду** |  |  ||
|| `affinity`
`affinity-mode`
`affinity-canary-behavior`

`session-cookie-name`
`session-cookie-path`
`session-cookie-domain`
`session-cookie-change-on-failure`
`session-cookie-samesite`
`session-cookie-conditional-samesite-none`
| [rules.sessionAffinity.header.name](../gwin-ref/ingress.md#session-affinity)
[rules.sessionAffinity.cookie.name](../gwin-ref/ingress.md#session-affinity)
[rules.sessionAffinity.cookie.ttl](../gwin-ref/ingress.md#session-affinity)
[rules.sessionAffinity.sourceIP](../gwin-ref/ingress.md#session-affinity)
| NGINX позволяет привязывать сессии через cookie, Gwin — через cookie, заголовки или IP ||
|| **Проверка сертификата бэкенда** |  |  ||
|| `proxy-ssl-secret`
`proxy-ssl-verify`
`proxy-ssl-verify-depth`
`proxy-ssl-ciphers`
`proxy-ssl-name`
`proxy-ssl-protocols`
| [rules.backends.tls.sni](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.id](../gwin-ref/ingress.md#backend-tls-configuration)
[rules.backends.tls.trustedCA.bytes](../gwin-ref/ingress.md#backend-tls-configuration)
| В NGINX проверка сертификата настраивается через SSL, в Gwin — через TLS ||
|| **Таймауты соединений** |  |  ||
|| `proxy-connect-timeout`
`proxy-send-timeout`
`proxy-read-timeout`
`proxy-next-upstream`
`proxy-next-upstream-timeout`
`proxy-next-upstream-tries`
`proxy-request-buffering`
| [rules.timeout](../gwin-ref/ingress.md#route-configuration)
[rules.idleTimeout](../gwin-ref/ingress.md#route-configuration)
| В Gwin задается общее время ожидания ответа от бэкенда и таймаут бездействия ||
|| **Ограничение скорости** |  |  ||
|| `global-rate-limit`
`global-rate-limit-window`
`global-rate-limit-key`
`global-rate-limit-ignored-cidrs`
| [hosts.rateLimit.allRequests.perSecond](../gwin-ref/ingress.md#rate-limiting)
[hosts.rateLimit.allRequests.perMinute](../gwin-ref/ingress.md#rate-limiting)
[hosts.rateLimit.requestsPerIP.perSecond](../gwin-ref/ingress.md#rate-limiting)
[hosts.rateLimit.requestsPerIP.perMinute](../gwin-ref/ingress.md#rate-limiting)
| Задают максимальное количество запросов, которое можно отправить за промежуток времени ||
|| **Логирование** |  |  ||
|| `enable-access-log` 
| [logs.logGroupID](../gwin-ref/ingress.md#cloud-logging)
[logs.logs.disable](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.httpCodes](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.httpCodeIntervals](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.grpcCodes](../gwin-ref/ingress.md#cloud-logging)
[logs.discardRule.{name}.discardPercent](../gwin-ref/ingress.md#cloud-logging)
| Включает логирование.

В Gwin также можно настроить параметры логирования ||
|| **Прочее** |  |  ||
|| `custom-http-errors`
| [directResponse.{name}.responseCode](../gwin-ref/ingress.md#direct-response-actions)
[directResponse.{name}.responseBody.text](../gwin-ref/ingress.md#direct-response-actions)
| Задает код ошибки и текст ответа ||
|| `proxy-http-version`
| [rules.backends.http.useHTTP2](../gwin-ref/ingress.md#backend-group-configuration)
| Определяет версию HTTP для взаимодействия с бэкендом ||
|| `limit-rps`
| [hosts.rateLimit.requestsPerIP.perSecond](../gwin-ref/ingress.md#rate-limiting)
| Задает количество запросов с одного IP в секунду ||
|| `proxy-cookie-domain`
`proxy-cookie-path`
| [rules.modifyResponseHeaders.append.{header-name}](../gwin-ref/ingress.md#response-header-modifications)
[rules.modifyResponseHeaders.rename.{old-header-name}](../gwin-ref/ingress.md#response-header-modifications)
[rules.modifyResponseHeaders.replace.{header-name}](../gwin-ref/ingress.md#response-header-modifications)
[rules.modifyResponseHeaders.remove](../gwin-ref/ingress.md#response-header-modifications)
| Задают заголовки ответа ||
|| `load-balance`
| [rules.backends.balancing.mode](../gwin-ref/ingress.md#backend-group-configuration)
| Задает алгоритм балансировки нагрузки ||
|#

## Переключите нагрузку на контроллер Gwin {#switch-controller}

{% include [switch-controller](../../_includes/managed-kubernetes/alb-ref/switch-controller.md) %}