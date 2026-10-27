---
title: '{{ datalens-full-name }} error: ERR.DS_API.DB.CHYT.CLIQUE.ACCESS_DENIED'
description: This page describes the `Access to clique <clique_name> for user <user_login> was denied` {{ datalens-full-name }} error.
---

# [{{ datalens-full-name }}] Access to clique <clique_name> for user <user_login> was denied

`ERR.DS_API.DB.CHYT.CLIQUE.ACCESS_DENIED`

The user whose login is specified in the error message or the token used for the connection does not have access to the clique specified in that message.

To fix this error, try the following:

* Check the user's settings, token, cluster, and clique alias in the connection settings.
* Try accessing the clique using one of the following methods:

  * Request the required permissions from the clique owner. You can find the person responsible for the clique in its [access permission settings interface](https://ytsaurus.tech/docs/ru/user-guide/data-processing/chyt/cliques/access#ui).
  * If the clique owner is missing or difficult to locate, contact the administrator of the connection the clique is used in.

* Select a clique you have access to.
