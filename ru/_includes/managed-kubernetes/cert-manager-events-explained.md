В выводе команды будут содержаться подобные события (events):

```text
Events:
  Type    Reason     Age   From                                       Message
  ----    ------     ----  ----                                       -------
  Normal  Issuing    ...   cert-manager-certificates-trigger          Issuing certificate as Secret does not exist
  Normal  Generated  ...   cert-manager-certificates-key-manager      Stored new private key in temporary Secret resource...
```

Сертификаты [используются в связке с соответствующими им секретами Kubernetes](https://cert-manager.io/docs/), которые хранят пары ключей и служебную информацию. В случае отсутствия секрета сертификат перевыпускается автоматически с созданием нового секрета, о чем и сообщается в событиях. Подробнее о причинах, которые могут привести к перевыпуску сертификата, см. в [документации cert-manager](https://cert-manager.io/docs/faq/#when-do-certs-get-re-issued).

Поскольку сертификат выпускается впервые, то соответствующий ему секрет отсутствует. Наличие событий, сообщающих об этом, не является ошибкой.
