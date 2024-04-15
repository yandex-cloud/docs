The command output will contain similar events:

```text
Events:
  Type    Reason     Age   From                                       Message
  ----    ------     ----  ----                                       -------
  Normal  Issuing    ...   cert-manager-certificates-trigger          Issuing certificate as Secret does not exist
  Normal  Generated  ...   cert-manager-certificates-key-manager      Stored new private key in temporary Secret resource...
```

Certificates are [used bundled with related Kubernetes secrets](https://cert-manager.io/docs/), which store key pairs and service information. If there is no secret, the certificate is reissued automatically and a new secret is created – with a notification in the events. For more information on what can cause the reissue of a certificate, see the [cert-manager documentation](https://cert-manager.io/docs/faq/#when-do-certs-get-re-issued).

As the certificate is being issued for the first time, it has no such related secret so far. The presence of notification events about the fact should not be considered an error.
