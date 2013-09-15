* User
  * Session
  * Apps
    * App Providers
      * Provider Info

# Session (Hash)
# User (Hash)

* Name (string)
* Email (string)


## User App IDs (Set)

### User App Info (Dict)

### User App Providers (Set)

#### User App Provider Info (Dict)

#### User App Provider Oauth (Sorted Set)

### App Provider Oauth ID (Hash)

SuperSimple SS uid's need to be polled for updates every minute. Convert uid to dropbox oauth simply.

UID-APP-PROVIDER example: {1}-{ss}-{dropbox}

a_{app_id}.{provider}_h.{id} = Oauth hash of info.
Can't do this because a user can have more than one oauth per provider.

I don't think it can be looked up in one call. Needs to be two calls.
One call to get the app provider oauth_id. The next call to load the oauth information.