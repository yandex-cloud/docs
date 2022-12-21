# Access to table was denied

`ERR.DS_API.DB.CHYT.TABLE_ACCESS_DENIED`

No access to the table in YT.

If, when connecting to CHYT, you select user authentication, then the {{ datalens-name }} user viewing the chart and getting such an error must get the view rights for the table in YT.

If, when connecting to CHYT, you select authentication with an OAuth token, use another token (for example, issued to your user) in the connection (if you have the rights), or you can grant access to the table to the user whose token is used to connect. If you don't know whose token is used in your connection, create a separate connection.
