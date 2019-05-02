# Green Mamba Feature Specification

## F-01: User Registration
**Description:** A person can register as a user on the system by providing:
- An email
- A phone number
- A password
- Their full name

*Details:*
- The email should be a valid email address
- The email should be unique - should not have been used previously on the system
- The phone number should be unique
- The phone number should be a registered Mpesa number, the user wishes to use for deposits
- The full name should not be empty
- The password should be at least 8 characters
- An account will be created for the user during registration

## F-02: Authentication
**Description:** A registered user can obtain an authentication token from the system by providing:
- Phone number or email
- Password

*Details:*
- The phone number or email should be provided with the corresponding key :phone or :email 
- A token with a set expiry will be returned to the user if the password provided is valid

## F-03: Send Money
**Description:** An authenticated user can send money to another user on the system by providing:
- A user phone or email to send funds to, and
- The amount to send

*Details:*
- The phone number or email must belong to a user registered on the system
- The phone number or email cannot be the same as those of the user making the transfer
- The user account balance must be equal to or higher than the amount to send
- The amount must be >=1 and <1000000
- The recipient will receive a confirmation message when they log onto the system as well as an email at the registered email

## F-04: Withdrawals
**Description:** An authenticated user can withdraw cash from a registered agent, by providing the 'agent number' and a valid amount.

*Details:*
- The agent number must identify a valid agent on the system
- An amount is valid if the user's account balance is >= sum(withdrawal amount, withdrawal charges)
- The user's account balance will be reduced by the withdrawn amount
- The agent's 'float balance' will be incremented by the withdrawn amount

## F-05: Reports
**Description:** An authenticated user can request an email showing their transactions on the system, by providing:
- A start date
- An end date

*Details:*
- If a start and end date are not provided, the system will send all transactions
- The end date will default to the day the request is made
- Both dates should be valid ISO dates
- The email report will be sent to the user's registered email address

## F-06: User Profile
**Description:** An authenticated user can retrieve information tied to their account.

*Details:*
The user will get back their registered phone number, email and phone, together with their account balance at the time the request is made.

# Agents

## F-07 Agent Registration
A person can register as an agent by providing the basic details as in [user registration](#F-01-User-Registration).
In addition they should provide:
- their registered business name
- location

*Details:*
- Both the business name and location should not be empty
- A user account and an agent account will be created by default

## F-08: Deposits
**Description:** An authenticated 'agent' user can top-up a 'normal' user account by providing:
- the phone number to top up
- the amount to top up

*Details:*
- The phone number must belong to an existing user
- The amount should be <= float balance
- The user's account balance will be incremented by the amount of the deposit
- The agent's 'float balance' will be reduced by the amount of the deposit