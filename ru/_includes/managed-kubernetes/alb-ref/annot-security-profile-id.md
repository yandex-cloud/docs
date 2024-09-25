Сервис проверяет HTTP-запросы, которые поступают к защищаемому ресурсу через [виртуальный хост](../../../application-load-balancer/concepts/http-router.md#virtual-host) L7-балансировщика. В зависимости от результатов проверки сервис направляет запросы к виртуальному хосту, блокирует их или отправляет в [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) для дополнительной верификации.

Чтобы включить поддержку сервиса, в аннотации Ingress укажите идентификатор [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-name }}:

```yaml
ingress.alb.yc.io/security-profile-id: <идентификатор_профиля_безопасности>
```

Профиль содержит список условий проверки и действий, которые применяются к приходящим HTTP-запросам по результатам проверки.

Если у вас нет профиля безопасности, [создайте его](../../../smartwebsecurity/operations/profile-create.md).

Для корректной работы аннотации [сервисному аккаунту Ingress-контроллера {{ alb-name }}](../../../application-load-balancer/tools/k8s-ingress-controller/service-account.md) необходимо дополнительно назначить роль `smart-web-security.editor`.
