The command output will contain similar events:

```text
Events:
  Type    Reason     Age   From                                       Message
  ----    ------     ----  ----                                       -------
  Normal  Issuing    ...   cert-manager-certificates-trigger          Issuing certificate as Secret does not exist
  Normal  Generated  ...   cert-manager-certificates-key-manager      Stored new private key in temporary Secret resource...
```

Certificates are [used bundled with matching Kubernetes secrets](https://cert-manager.io/docs/), which store key pairs and service information. If there is no secret, the certificate is reissued automatically and a new secret is created, with a notification in the events. For more information about certificate reissue, see [this cert-manager guide](https://cert-manager.io/docs/faq/#when-do-certs-get-re-issued).

As the certificate is being issued for the first time, it has no matching secret. Any events notifying about it should not be considered an error.
