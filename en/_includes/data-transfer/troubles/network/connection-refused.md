### Connection refused error {#connection-refused}

Error message:

```text
connect: connection refused
```

The service was unable to establish a TCP connection to specified host and port. The server on the source or target side is available over the network but has rejected the connection attempt.  

Possible causes:

* Incorrectly specified host and port. 

    **Solution**: Check host and port for correctness.

* Specified port is not listened to.

    **Solution**: Make sure your DBMS settings allow external connections to the specified port.
