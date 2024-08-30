The service checks HTTP requests sent to the protected resource via the [virtual host](../../../application-load-balancer/concepts/http-router.md#virtual-host) of the L7 load balancer. Depending on the results of the check, the service sends requests to the virtual host, blocks them, or sends them to [{{ captcha-full-name }}](../../../smartcaptcha/index.yaml) for additional verification.

To enable support for the service, specify the {{ sws-name }} [security profile](../../../smartwebsecurity/concepts/profiles.md) ID in the Ingress annotation:

```yaml
ingress.alb.yc.io/security-profile-id: <security_profile_ID>
```

The profile contains a list of verification conditions and actions applied to incoming HTTP requests based on verification results.

If you do not have a security profile, [create one](../../../smartwebsecurity/operations/profile-create.md).
