# Data source refused connection

`ERR.DS_API.DB.SOURCE_CONNECT_ERROR`

Error loading data.

This error means that a connection to the database could not be established.

To fix the error, check the connection settings:

* Check that the information specified in the connection is correct: **Hostname**, **Port**, **Username**, and **Password**.
* If the specified port only works over HTTP, disable the **HTTPS** connection option.
* If the host list contains only one host, enter all the cluster hosts separated by commas in the **Hostname** field.
