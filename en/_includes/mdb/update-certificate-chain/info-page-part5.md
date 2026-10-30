Within three days from the update, you can run change rollback in the [management console]({{ link-console-main }}). This will _temporarily_ allow you to use the previous TLS certificate chain for the connection.

After the connection is restored, update your secure certificate store or client configuration to match the main connection instruction. A change rollback is a temporary measure: the client must be prepared for working with the new certificate chain before the next switching.
