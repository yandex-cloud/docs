This service checks HTTP requests to a protected resource through an L7 load balancer [virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host). Depending on check results, it forwards the requests to the protected resource, blocks them, or sends them to [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) for additional verification.

To enable this service, specify the {{ sws-name }} [security profile](../../../smartwebsecurity/concepts/profiles.md) ID in the Ingress annotation:

```yaml
ingress.alb.yc.io/security-profile-id: <security_profile_ID>
```

This profile contains verification conditions and actions applied to incoming HTTP requests following the check results.

If you do not have a security profile, [create one](../../../smartwebsecurity/operations/profile-create.md).
