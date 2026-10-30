Check the settings of clients and applications that use TLS:

1. If `CA.pem` is used, switch to the [RootCA.pem]({{ crt-web-path-root }}) root certificate.
1. If a custom secure certificate store is used, ensure that the `YandexInternalRootCA` root certificate has been imported into it.
1. Ensure that intermediate or server certificates are not pinned.
1. Perform a test connection with the updated settings.