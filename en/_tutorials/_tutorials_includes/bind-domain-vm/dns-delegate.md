To delegate a domain to {{ dns-name }}, in your account on your domain registrar's website, specify the DNS server addresses in the domain settings:

* `ns1.{{ dns-ns-host-sld }}`
* `ns2.{{ dns-ns-host-sld }}`

Delegation does not take effect immediately. It usually takes up to 24 hours (86,400 seconds) for internet service providers to update records. This depends on the TTL value which specifies how long domain records are cached.

You can check the domain delegation using [Whois](https://www.reg.com/whois/check_site) or the `dig` utility:

```bash
dig +short NS example.com
```

Result:

```
ns2.{{ dns-ns-host-sld }}.
ns1.{{ dns-ns-host-sld }}.
```
