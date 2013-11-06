# Local User Account Service

We like using third party authentication services (Github, Google, Twitter, Facebook) as much as possible. In some cases a website demands that users login with a specific username and password. Most often this is required because users are being imported from an old system.

Submit a login or registration over https.

This is service is limited to providing a login token (think session id or oauth2) that can be used by other API's to validate that the user is authenticated and provide access to the user information.

Essentially, this should be come an oauth2 server.

## Ways of submitting

* Form post. application/x-www-form-urlencoded
* Post a json string with the fields. application/json
* Url arguments.

## Submitted Fields

* **source** Optional. If not provided the source defaults to 'cape'. Usernames specific to a site? Include the site ID as the source.
* **username** a string representing the user. This will be associated with a CAPE user id. ([a-z][A-Z][0-9]_\-\.)
* **password** Clear text password. Encryption before database storage happens on the server. If custom hash happened in an old system before being imported (md5) the password needs to come md5 encoded.
* **email** Optional. Used for recovery of the password. Also can be used to validate an account.
* **other**. Other fields...

## Endpoints

### User Login [/user/login]  
Send data here to log the user in. Returns 404 type response if the username is not found. Returns 403 if the password doesn't match. After first two failed password checks on a uid a 1 second delay is added to every subsequent check over the next 24 hours.

### User Registration [/user/create]
Password matching must take place on the client side. The password provided is the password that will be used. Create a user based on the fields provided. Returns 409 (?) if the user is found already but password doesn't match? Will log the user in if the passwords match.

### User information [/user/info/{uid}]
Request must be authenticated with token provided in [/user/login]. Returns information about the user. `email` and other.

### User update [/user/update/{uid}]
Must be authenticated with the token provided in [/user/login].
Post a new json object of fields to update the user with.

## App Flow

1. Load the `password_salt` and `uid` for a given `source:username`.
1. Sha256 password with password hash field.
1. Sha256 result with the global salt.
1. Load used object based on the `uid`.
1. Compare calculated `password_hash` with `password_hash` value in database.
1. Provide success or failure to client.

## Data Storage
* `source/username` : `uid`, `password_salt`
* `uid` : `email`, `password_hash`, `[other]`
* `token` : `uid` - optionally expire token.


