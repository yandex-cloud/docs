# JavaScript Interface object

JavaScript Interface is an object Android transfers to **WebView**. The front end will then access this object to send messages using a callback function on Android.

## JavaScript Interface structure {#structure}

### onGetToken(token: String): Unit method {#ongettoken-method}

This is a required method, through which a token for passing CAPTCHA verification is transferred. It is called on the front end once the service has handled a user's attempt to pass CAPTCHA verification.

### onChallengeVisible(): Unit method {#onchallengevisible-method}

This is an optional method which you may only need to embed an invisible CAPTCHA. It is called when the invisible CAPTCHA shows a challenge to the user. By default, **WebView** with invisible CAPTCHA is hidden, so you need to track the moment when the **WebView** needs to be displayed.

### onChallengeHidden(): Unit method {#onchallengehidden-method}

This is an optional method which you may only need to embed an invisible CAPTCHA. If the user swiped CAPTCHA off, they cannot restore it on their own; you will need to show the previous screen to the user.

{% note info "Note" %}

When creating a class, the above methods are marked with the `@JavascriptInterface` annotation.
If you develop your own website with CAPTCHA, you can change the names of these methods. In this case, you will need to change the method names on the front-end side, too.

{% endnote %}