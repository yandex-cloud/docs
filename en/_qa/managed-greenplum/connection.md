#### Can I connect to the DB via SSH and get superuser permissions? {#super-user}

No, you cannot connect via SSH, nor can you get superuser permissions. This is done for the sake of security and user cluster fault tolerance because direct changes inside hosts can render them completely inoperable. However, you can connect to the DB as an admin user with the `mdb_admin` role. The privileges it has matches those of the superuser. For more information, see [{#T}](../../managed-greenplum/concepts/cluster-users.md#mdb_admin).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mgp-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-greenplum/operations/connect.md).

#### What do I do if I get the revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means, when connecting to the website, the service failed to check whether or not the website’s certificate is on the list of revoked certificates.

To fix this error:

* Make sure the corporate network settings do not block the check.
* Run the command with the `--ssl-no-revoke` parameter.

   ```powershell
   mkdir $HOME\.postgresql; curl.exe --ssl-no-revoke -o $HOME\.postgresql\root.crt {{ crt-web-path }}
   ```

#### How do I set up user authentication? {#auth-user}

You can set up user authentication in {{ mgp-name }} using [rules](../../managed-greenplum/operations/user-auth-rules.md).

For more information, see [{#T}](../../managed-greenplum/concepts/user-authentication.md).
