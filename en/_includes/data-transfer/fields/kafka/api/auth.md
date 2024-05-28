`auth`: Authentication method used to connect to broker hosts:

* `sasl`: SASL authentication. The following parameters are required:

   * `user`: Name of the account {{ data-transfer-name }} will use to connect to the topic.
   * `password.raw`: Password for the account in text form.
   * `mechanism`: Hashing mechanism.

* `noAuth`: Without authentication.
