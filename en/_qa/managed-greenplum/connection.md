#### Can I connect to a DB over SSH and get superuser permissions? {#super-user}

No, you cannot connect over SSH, nor can you get superuser permissions. This is for the sake of security and user cluster fault tolerance, since direct changes inside hosts can render them completely inoperable. However, you can connect to a DB as an admin user with the `mdb_admin` role. The privileges such a user has match those of the superuser. For more information, see [{#T}](../../managed-greenplum/concepts/cluster-users.md#mdb_admin).

#### How can I access a running database host? {#db-access}

You can connect to {{ GP }} databases using native DBMS connection methods.

To learn more about connecting to clusters see [this guide](../../managed-greenplum/operations/connect/index.md).

#### What should I do if I get a revocation check error when obtaining an SSL certificate via PowerShell? {#get-ssl-error}

Complete error message:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This indicates that the verification of the website’s certificate against the revocation list failed during the connection attempt.

To fix this error:

* Make sure your corporate network policies are not blocking the verification.
* Run the command with the `--ssl-no-revoke` parameter.

   ```powershell
   mkdir $HOME\.postgresql; curl.exe --ssl-no-revoke -o $HOME\.postgresql\root.crt {{ crt-web-path }}
   ```

#### How do I set up user authentication? {#auth-user}

You can set up user authentication in {{ mgp-name }} using [rules](../../managed-greenplum/operations/user-auth-rules.md).

For more information, see [{#T}](../../managed-greenplum/concepts/user-authentication.md).
