# Authentication failed

`ERR.DS_API.DB.CHYT.AUTH_FAILED`

The error arises when CHYT authentication has failed because of issues with the token.

Possible cause:

* The connection uses the token of an employee who was dismissed.
* The connection uses the token of an inactive robot.
* A random sequence of characters is used instead of the token.

To fix the error, replace the token in the connection with an active token.
