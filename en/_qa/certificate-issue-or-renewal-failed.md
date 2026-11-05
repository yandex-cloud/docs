#### Issuing or renewing my Let's Encrypt certificate fails. Why? {#certificate-issue-or-renewal-failed}

To get and renew a Let's Encrypt certificate, you need to successfully [verify ownership for each domain](../certificate-manager/concepts/challenges.md) specified in the certificate. If a certificate has the `Validating` status for a while, or automatic renewal cannot complete, check the verification conditions:

* `DNS`: `CNAME` or `TXT` record is available via public DNS servers, and its name and value match the verification data in the management console.
* `HTTP`: [File with the required name and contents](../certificate-manager/concepts/challenges.md#http) is available on the web server.

When renewing a certificate for verification via `TXT` or `HTTP`, you need current values from the management console. Verification via `CNAME` is automatic if the record is configured correctly. For more information, see [Renewing a certificate](../certificate-manager/concepts/managed-certificate.md#renew).

If a verification at the initial issue does not complete successfully in a week, the certificate's status will switch to `Invalid`. After fixing the issues, you need to [create a new certificate issue request](../certificate-manager/operations/managed/cert-create.md) and [verify domain ownership](../certificate-manager/operations/managed/cert-validate.md).

The `Renewal_failed` status means that verification at renewal completed with an error. The certificate remains valid until expired; the service will retry renewal later on. To avoid resource downtime, issue a new certificate before the previous one expires, verify your domain ownership, and configure resources to use the new certificate.

##### How do I check DNS records? {#dns-check}

You can check a DNS record via a public DNS server using the `dig` utility. In our examples, replace `example.com` with your domain.

To check using `CNAME`:

```bash
dig @1.1.1.1 CNAME _acme-challenge.example.com
```

A CNAME record with a value from the management console must be under `ANSWER SECTION`.

To check using `TXT`:

```bash
dig @8.8.8.8 TXT _acme-challenge.example.com
```

A TXT record with a current check value from the management console must be under `ANSWER SECTION`.

If using `CNAME`, check for the [absence of conflicting records for the same name](#checking-cname).
