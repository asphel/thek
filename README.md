# The K
Client application to handle guest lists for event based on QRCode

# How it works 
Users sign in thanks to Facebook connect, and then are able to receive "keys" for a specific Facebook event. A key is actually and Id converted into a QRCode thank to CIFilter. The key can be transfered to a Facebook Friend or can be used to access to an event. The Admin app is used to scan the key.

# SDK
* Firebase (Auth, Storage, Database)
* Facebook (Core, Login, Share)
* SwiftyJSON

# TODO 

## Global 
* UX/UI : define and implement a real UX/UI (Tindr like navigation with 3 tabs : user informations, key list, user history)
* Log all user event in history (under users/_userId_/history node) : new key added, key transfered, key used, expired key
* Handle error messages displayed to user ( use UIAlertController)
* Handle image import into Firebase Storage (profile picture, cover event, etc.)


## User 
* Implement different level of rights for user (Admin, eventOwner, simpleUser)
* Methode to update the user information in Firebase based on lastUpdateTime property
* Refactor the Facebook init : we do not need to insitantiate the user with Graph API information when the user is already registered into Firebase
* Update description
* Handle images

## Key 
* Change the key logic : Keys must be referenced under events/_eventId_/keyTypes/_keyTypeId_/keys/ and under users/_userId_/keys/. Key information need to be stored under events/_eventId_/keyTypes/_keyTypeId_/
* Change init mehtod : since Key informations are under events/_eventId_/keyTypes/_keyTypeId_, init need to be refactored
* Change moveKeyToAnotherUser method : same as above
* Handle images


## Event 
* TBD


