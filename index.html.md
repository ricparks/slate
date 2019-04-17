---
title: Wisetack API
language_tabs:
  - curl: Curl
toc_footers: []
includes: []
search: false
highlight_theme: darkula
headingLevel: 2

---

<h1 id="wisetack-api">Wisetack API v1.1.0</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

## Introduction
Welcome to the Wisetack API. The APIs documented on this page will enable you to seamlessly integrate point-of-sale financing
with your existing system.  Here's a brief overview of the APIs:

* **CreateLinks** allow you to create an HTML link that can be embedded in an invoice. This link will initiate a transaction session
specific for that invoice.

* **Transactions** allow you to initiate a transaction for a specific merchant for a customer based only on amount and phone number.
Furthermore, transactions allow you to track and update the flow of the transaction through authorization and settlement.

* **Merchants** allow you to onboard merchants into the system as well as list your existing merchants based on
date and status filters, get information on a merchant, and remove merchants from your system.

* **Users** Allow you to add users for merchants. Each merchant can have multiple users for the Wisetack system. The Users resource allows you
to add and manage users and their roles and priveleges in the system.

## Authentication
Wisetack uses HTTP Basic Authentication with both an application token and a secret key. When you initially create
a Wisetack account, you'll be given an application token and a secret key for both the production system
and a test system.  You'll be able to distinguish between the two keys easily by their prefix. Production keys
start with ws_prod_ and the test system keys are prefixed by ws_test_.
If you use one of our language SDK's you don't need to worry about the specifics of authentication but if you
want to build authentication in to your own RESTful calls, you simply add the keys to the header like this:

1. Concatenate the application token and secret key separated by a colon.

2. Base64 encode the resulting string.

3. Pass the result in the authorization header, prefixed with the word Basic.

This process will result in a header that looks something like this: \
**Authorization: Basic ZHBERDZ6NG9sT1NJN040Zk1Dc0FsS2pGYTdyZUJZaHU6b0ptM25pUVgxUGR5NRNDU=**

# Authentication

- HTTP Authentication, scheme: basic 

<h1 id="wisetack-api-transactions">Transactions</h1>

The Transaction resource initiates transactions and manages the flow of authorization, settlement, and refunds.

## POST initiates a transaction process.

> Code samples

`POST /merchant/{merchantId}/transactions`

The Wisetack system starts by sending a text message link from a merchant to a customer. The
merchant must enter the mobile number of the customer, a transaction amount, and the purpose of the transaction and the
text message is sent. Once the customer clicks the link on their mobile phone, they will proceed to the
Wisetack transction process.

Note that the POST can also include an array of line items to describe the services or products provided as
well as other optional items described in the TransactionObject. These line items
are optional.
The following values are required for the POST:

* status must be set to 'initiated'.

* a United States domestic mobile phone number is required.

* a transaction amount is required.

* a transaction purpose is required.

> Body parameter

```json
{
  "status": "initiated",
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="post-initiates-a-transaction-process.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|Id for the merchant originating the transaction.|
|body|body|[TransactionObject](#schematransactionobject)|false|none|

> Example responses

> 200 Response

```json
{
  "status": "initiated",
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="post-initiates-a-transaction-process.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[TransactionObject](#schematransactionobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## GET returns a list of transactions for this merchant.

> Code samples

`GET /merchant/{merchantId}/transactions`

Returns a list of all the transactions for this merchant.
A filter can be supplied using a query string to limit the list to a date range, status, or number of items.

<h3 id="get-returns-a-list-of-transactions-for-this-merchant.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|Id for the merchant originating the transaction.|
|startingAfter|query|string|false|List only transactions that were initiated after this date.|
|endingBefore|query|string|false|List only transactions that were initiated before this date.|
|limit|query|string|false|Limit the number of transactions returned to this number.|
|status|query|string|false|List only transactions with this status code.|

> Example responses

> 200 Response

```json
[
  {
    "transactionResourceURL": null
  }
]
```

<h3 id="get-returns-a-list-of-transactions-for-this-merchant.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|Inline|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<h3 id="get-returns-a-list-of-transactions-for-this-merchant.-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|» transactionResourceURL|any|false|none|URL pointing to each applicable resource.|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## GET retrieves information, including the status, on a specific transaction.

> Code samples

`GET /transactions/{transactionId}`

<h3 id="get-retrieves-information,-including-the-status,-on-a-specific-transaction.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|transactionId|path|string|true|UUID Id for the transaction. Acquired during the POST to create the transaction.|

> Example responses

> 200 Response

```json
{
  "status": "initiated",
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="get-retrieves-information,-including-the-status,-on-a-specific-transaction.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[TransactionObject](#schematransactionobject)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## PATCH allows status update for transaction initiation and provides for full or partial refunds.

> Code samples

`PATCH /transactions/{transactionId}`

Supported statuses for transactions:
* Initiated: The transaction process has been started for a customer but has not yet proceeded through authorization.
* Authorized: Wisetack has authorized the transactionn for this customer. The transaction will not proceed until the transaction status has been set to 'settled.' An authorized transaction can either be 'settled' or 'canceled'. An authorized transaction will expire after 30 days if it has not been settled.
* Settled: Once the transaction is settled, Wisetack will begin the transaction and pay the merchant via ACH. Once a transaction is settled, it can be either partially or completely refunded.
* Refunded:  The full amount of the transaction has been refunded.
* Expired: The transaction was not authorized or settled under the specified time limit. A transaction can never be removed from an expired state.
* Declined: The transaction was declined.

> Body parameter

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}
```

<h3 id="patch-allows-status-update-for-transaction-initiation-and-provides-for-full-or-partial-refunds.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantObject](#schemamerchantobject)|false|none|
|transactionId|path|string|true|UUID Id for the transaction. Acquired during the POST to create the transaction.|

> Example responses

> 200 Response

```json
{
  "status": "initiated",
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="patch-allows-status-update-for-transaction-initiation-and-provides-for-full-or-partial-refunds.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[TransactionObject](#schematransactionobject)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

<h1 id="wisetack-api-merchants">Merchants</h1>

The Merchant resource allows you to onboard merchants over time, to delete merchants from your system,
to list all merchants, and to get information on individual merchants.

There are two very different types of data in the MerchantObject.

* **Flag Fields** are essentially flags
indicating to the client which fields need to be collected from the merchant. These flag fields are in
MerchantOptionalInformation and MerchantDataRequired schemas. Their presence indicates that they
must be collected.

* **Data Fields** are string fields where the data collected in response to the Flag Fields above
can be sent back to the server. These fields are in the MerchantUpdateObject.

Additionally, there are four different flag field sections. Where a flag field is found (if at all)
indicates how the client should behave regarding that field.

* **optionalInformation** indicates that this information has not been collected. It is not required
but could be helpful in future dealings with this merchant.

* **currentlyDue** are the fields the merchant must supply to start or continue to tranact
services.

* **eventuallyDue** are the fields the merchant must supply to have the full range of
capabilities they are eligible for.

* **pastDue** are the fields the merchant must supply to continue or restore their transaction
capabilities.

## POST creates a merchant and returns a newly created merchant id.

> Code samples

`POST /merchants`

POST creates a new merchant entry. To onboard a merchant, please see the Merchant PATCH operation.

If there is already a unique merchant entry for this merchant, a 201 error is returned with a link to the resource.
Using just a cell  phone number, an account is created or retrieved. The state of the application verification process
is indicated in three main sections: information currently due, due soon, and overdue.

> Body parameter

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}
```

<h3 id="post-creates-a-merchant-and-returns-a-newly-created-merchant-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantObject](#schemamerchantobject)|false|none|

> Example responses

> 200 Response

```json
[
  {
    "merchantResourceURL": "string"
  }
]
```

<h3 id="post-creates-a-merchant-and-returns-a-newly-created-merchant-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|Inline|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<h3 id="post-creates-a-merchant-and-returns-a-newly-created-merchant-id.-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|» merchantResourceURL|string|false|none|URL pointing to each applicable merchant resource.|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## GET retrieves a list of merchants.

> Code samples

`GET /merchants`

Lists all merchants on your Wisetack account. You can filter this list based on date and if their transaction initiation has or has not been enabled.

<h3 id="get-retrieves-a-list-of-merchants.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|startingAfter|query|string|false|List only merchants who initiated their onboard after this date.|
|endingBefore|query|string|false|List only merchants who initiated their onboarding before this date.|
|transactionsEnabled|query|string|false|Set to true or false.|

> Example responses

> 200 Response

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}
```

<h3 id="get-retrieves-a-list-of-merchants.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantObject](#schemamerchantobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## GET retrieves merchant information based on merchant id.

> Code samples

`GET /merchants/{merchantId}`

Get a merchant's information.

<h3 id="get-retrieves-merchant-information-based-on-merchant-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|The merchant id as stored during merchant onboarding.|

> Example responses

> 200 Response

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}
```

<h3 id="get-retrieves-merchant-information-based-on-merchant-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantObject](#schemamerchantobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## PATCH onboards a merchant and updates merchant information.

> Code samples

`PATCH /merchants/{merchantId}`

The PATCH (update) is the merchant identification process. The application can request required information from the
merchant and submit additional information using a PATCH request to the merchantId. Any additional required information
is returned as a response to the PATCH. This process can continue until all required information is gathered.

Please see the overview for Merchants for a more detailed explanation for this process.

> Body parameter

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}
```

<h3 id="patch-onboards-a-merchant-and-updates-merchant-information.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantObject](#schemamerchantobject)|false|none|
|merchantId|path|string|true|The merchant id as stored during merchant onboarding.|

> Example responses

> 200 Response

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}
```

<h3 id="patch-onboards-a-merchant-and-updates-merchant-information.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantObject](#schemamerchantobject)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## DELETE removes a merchant from the system.

> Code samples

`DELETE /merchants/{merchantId}`

Remove this merchant from your system.

<h3 id="delete-removes-a-merchant-from-the-system.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|The merchant id as stored during merchant onboarding.|

> Example responses

> 200 Response

```json
{
  "merchantId": "string",
  "deleted": true
}
```

<h3 id="delete-removes-a-merchant-from-the-system.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|Inline|

<h3 id="delete-removes-a-merchant-from-the-system.-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|» merchantId|string|false|none|The id of the merchant deleted.|
|» deleted|boolean|false|none|True if successful.|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

<h1 id="wisetack-api-users">Users</h1>

The Users resource allows you to support multiple users, each with their own roles and privileges in the
Wisetack system. This feature allows merchants to add and manage employees and other types
of subusers.

## POST creates a new user.

> Code samples

`POST /merchant/{merchantId}/users`

POST creates a new user based on the user's phone number. If the mobile phone number is already associated
with the merchant then the user's already existing id is returned in the response.

> Body parameter

```json
{
  "userId": "6f6c4bf4-ab58-4a1b-833e-0e665dc65400",
  "firstName": "Hugh",
  "lastName": "Cave",
  "email": "hugh@akhouse.com",
  "mobilePhone": 5556669999,
  "userName": "hughb",
  "password": "sample",
  "role": "admin",
  "group": "na"
}
```

<h3 id="post-creates-a-new-user.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[UserObject](#schemauserobject)|false|none|
|merchantId|path|string|true|The merchant id as stored during merchant onboarding.|

> Example responses

> 200 Response

```json
{
  "userId": "6f6c4bf4-ab58-4a1b-833e-0e665dc65400",
  "firstName": "Hugh",
  "lastName": "Cave",
  "email": "hugh@akhouse.com",
  "mobilePhone": 5556669999,
  "userName": "hughb",
  "password": "sample",
  "role": "admin",
  "group": "na"
}
```

<h3 id="post-creates-a-new-user.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[UserObject](#schemauserobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## GET retrieves a list of users.

> Code samples

`GET /merchant/{merchantId}/users`

List all users for the merchant with {merchantId}.

<h3 id="get-retrieves-a-list-of-users.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|The merchant id as stored during merchant onboarding.|

> Example responses

> 200 Response

```json
[
  {
    "userResourceURL": null
  }
]
```

<h3 id="get-retrieves-a-list-of-users.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|Inline|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<h3 id="get-retrieves-a-list-of-users.-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|» userResourceURL|any|false|none|URL pointing to each applicable user resource.|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## GET retrieves any available information for the user.

> Code samples

`GET /users/{userId}`

Get any available information for the user.

<h3 id="get-retrieves-any-available-information-for-the-user.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|userId|path|string|true|The unique UUID representing this user.|

> Example responses

> 200 Response

```json
{
  "userId": "6f6c4bf4-ab58-4a1b-833e-0e665dc65400",
  "firstName": "Hugh",
  "lastName": "Cave",
  "email": "hugh@akhouse.com",
  "mobilePhone": 5556669999,
  "userName": "hughb",
  "password": "sample",
  "role": "admin",
  "group": "na"
}
```

<h3 id="get-retrieves-any-available-information-for-the-user.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[UserObject](#schemauserobject)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## PUT updates the information for an existing user.

> Code samples

`PUT /users/{userId}`

Update the information for an existing user.

> Body parameter

```json
{
  "userId": "6f6c4bf4-ab58-4a1b-833e-0e665dc65400",
  "firstName": "Hugh",
  "lastName": "Cave",
  "email": "hugh@akhouse.com",
  "mobilePhone": 5556669999,
  "userName": "hughb",
  "password": "sample",
  "role": "admin",
  "group": "na"
}
```

<h3 id="put-updates-the-information-for-an-existing-user.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[UserObject](#schemauserobject)|false|none|
|userId|path|string|true|The unique UUID representing this user.|

> Example responses

> 200 Response

```json
{
  "userId": "6f6c4bf4-ab58-4a1b-833e-0e665dc65400",
  "firstName": "Hugh",
  "lastName": "Cave",
  "email": "hugh@akhouse.com",
  "mobilePhone": 5556669999,
  "userName": "hughb",
  "password": "sample",
  "role": "admin",
  "group": "na"
}
```

<h3 id="put-updates-the-information-for-an-existing-user.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[UserObject](#schemauserobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

## DELETE removes a user.

> Code samples

`DELETE /users/{userId}`

Permanently deletes a user from the system.

<h3 id="delete-removes-a-user.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|userId|path|string|true|The unique UUID representing this user.|

> Example responses

> 200 Response

```json
{
  "userId": "string",
  "deleted": true
}
```

<h3 id="delete-removes-a-user.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|Inline|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<h3 id="delete-removes-a-user.-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|» userId|string|false|none|The id of the user deleted.|
|» deleted|boolean|false|none|True if successful.|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

<h1 id="wisetack-api-createlink">CreateLink</h1>

## POST creates a link to be embedded in an invoice.

> Code samples

`POST /merchant/{merchantId}/createLink`

You can use the createLink resource to create links that can be embedded in invoices or other materials where
you might want to offer a transaction to a specific customer. The createLink allows you to register information that will
expedite the transaction for your merchant's existing customers. By sending information when creating this link,
Wisetack can more easily pre-fill information and make the customer's experience as smooth as possible.

Creation of a link requires a transaction amount and purpose.  Optional fields such as customer address, dob,
and ssn as well as optional line item information is also supported.. The POST returns a link that is specific for
that customer, merchant, and line items. When the customer clicks the link, they will proceed to a transaction flow specifically for
them. A unique link will be created on each create. The link expires after 90 days.

> Body parameter

```json
{
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="post-creates-a-link-to-be-embedded-in-an-invoice.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|Id for the merchant originating the transaction|
|body|body|[CreateLinkObject](#schemacreatelinkobject)|false|none|

> Example responses

> 200 Response

```json
{
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="post-creates-a-link-to-be-embedded-in-an-invoice.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[CreateLinkObject](#schemacreatelinkobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Resource not found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal server error.|[Error](#schemaerror)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

<h1 id="wisetack-api-webhooks">Webhooks</h1>

## POST subscribes to all Wisetack callbacks.

> Code samples

`POST /subscribe`

Wisetack provides callbacks to let you know when the status of a transaction has changed.

> Body parameter

```json
{
  "callbackURL": "https://wisetack.yourcompany.com/callback"
}
```

<h3 id="post-subscribes-to-all-wisetack-callbacks.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|object|true|none|
|» callbackURL|body|string(uri)|true|none|

<h3 id="post-subscribes-to-all-wisetack-callbacks.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Webhook created.|None|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
BasicAuth
</aside>

# Schemas

<h2 id="tocSmerchantobject">MerchantObject</h2>

<a id="schemamerchantobject"></a>

```json
{
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "merchantSecretToken": null,
  "optionalInformation": {
    "companyDescription": null,
    "companyURL": null,
    "dba": null,
    "companyEmail": null,
    "annualRevenue": null,
    "averageOrderValue": null,
    "industry": null,
    "dateEstablished": null,
    "supportPhone": null,
    "annualChargeBackAmount": null,
    "annualRefundsAmount": null,
    "otherServiceLinks": [
      {
        "serviceName": "string"
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": null,
        "driversLicenseState": null,
        "ownerDocuments": [
          {
            "documentType": null
          }
        ]
      }
    ]
  },
  "currentlyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "eventuallyDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "pastDue": {
    "deadline": "string",
    "companyEIN": null,
    "companyLegalOperatingName": null,
    "companyPhoneNumber": null,
    "companyStreetAddress1": null,
    "companyStreetAddress2": null,
    "companyCity": null,
    "companyStateCode": null,
    "companyZip": null,
    "companyType": "partnership",
    "tosAcceptanceDate": null,
    "tosAcceptanceIPAddress": null,
    "ownerInformation": [
      {
        "isOwnerPrimary": null,
        "ownerDOB": null,
        "ownerFirstName": null,
        "ownerLastName": null,
        "ownerLast4ssn": null
      }
    ]
  },
  "disabledReason": "string",
  "merchantInformation": {
    "companyEIN": "string",
    "companyLegalOperatingName": "string",
    "companyPhoneNumber": "string",
    "companyStreetAddress1": "string",
    "companyStreetAddress2": "string",
    "companyCity": "string",
    "companyStateCode": "string",
    "companyZip": "string",
    "companyType": "partnership",
    "tosAcceptanceDate": "string",
    "tosAcceptanceIPAddress": "string",
    "commpanyDescription": "string",
    "companyURL": "string",
    "dba": "string",
    "companyEmail": "string",
    "annualRevenue": "string",
    "averageOrderValue": "string",
    "industry": "string",
    "dateEstablished": "string",
    "supportPhone": "string",
    "annualChargeBackAmount": "string",
    "annualRefundsAmount": "string",
    "otherServiceLinks": [
      {
        "serviceName": null,
        "serviceURL": null,
        "serviceToken": null
      }
    ],
    "ownerInformation": [
      {
        "driversLicenseNumber": "string",
        "driversLicenseState": "string",
        "ownerDocuments": [
          {
            "documentType": "string"
          }
        ]
      }
    ]
  }
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|merchantId|string|false|none|A UUID unique to the newly created merchant.|
|onboardingDate|string|false|none|Date this merchant was initially onboarded in YYYY-MM-DD format.|
|transactionsEnabled|boolean|false|none|Has this merchant been fully onboarded and are now able to initiate transactions.|
|merchantSecretToken|any|false|none|An token used for authenticiation from the partner's backend to the Wisetack backend.|
|optionalInformation|[MerchantOptionalInformation](#schemamerchantoptionalinformation)|false|none|none|
|currentlyDue|[MerchantDataRequired](#schemamerchantdatarequired)|false|none|none|
|eventuallyDue|[MerchantDataRequired](#schemamerchantdatarequired)|false|none|none|
|pastDue|[MerchantDataRequired](#schemamerchantdatarequired)|false|none|none|
|disabledReason|string|false|none|If the merchant has been disabled and cannot initiate further transactions, that information is listed here.|
|merchantInformation|[MerchantUpdateObject](#schemamerchantupdateobject)|false|none|none|

<h2 id="tocSmerchantoptionalinformation">MerchantOptionalInformation</h2>

<a id="schemamerchantoptionalinformation"></a>

```json
{
  "companyDescription": null,
  "companyURL": null,
  "dba": null,
  "companyEmail": null,
  "annualRevenue": null,
  "averageOrderValue": null,
  "industry": null,
  "dateEstablished": null,
  "supportPhone": null,
  "annualChargeBackAmount": null,
  "annualRefundsAmount": null,
  "otherServiceLinks": [
    {
      "serviceName": "string"
    }
  ],
  "ownerInformation": [
    {
      "driversLicenseNumber": null,
      "driversLicenseState": null,
      "ownerDocuments": [
        {
          "documentType": null
        }
      ]
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|companyDescription|any|false|none|Freeform description of the business.|
|companyURL|any|false|none|The main url for the business.|
|dba|any|false|none|Any doing-business-as names that would apply.|
|companyEmail|any|false|none|Email address for main contact at the company.|
|annualRevenue|any|false|none|Total annual revenue for the business. Includes two decimal points but no dollar symbol.|
|averageOrderValue|any|false|none|The typical order value for this business. Includes two decimal points but no dollar symbol.|
|industry|any|false|none|A list of industries will be provided and this field will be validated.|
|dateEstablished|any|false|none|The date the company was started in YYYY-MM-DD format.|
|supportPhone|any|false|none|Business phone number for customer support.|
|annualChargeBackAmount|any|false|none|Total amount of chargebacks for the prior year.|
|annualRefundsAmount|any|false|none|Total amount of refunds for the prior year.|
|otherServiceLinks|[object]|false|none|Future feature. This section will request access to external services, such as Quicken, to facilitate onboarding.|
|» serviceName|string|false|none|The name of the company providing the service. Quicken, for example.|
|ownerInformation|[object]|false|none|Optional information for each owner.|
|» driversLicenseNumber|any|false|none|Driver's license number.|
|» driversLicenseState|any|false|none|State where driver's license was issued.|
|» ownerDocuments|[object]|false|none|Scanned in documents to supplement and verify information.|
|»» documentType|any|false|none|Enum describing type of document requested or required.|

<h2 id="tocSmerchantdatarequired">MerchantDataRequired</h2>

<a id="schemamerchantdatarequired"></a>

```json
{
  "deadline": "string",
  "companyEIN": null,
  "companyLegalOperatingName": null,
  "companyPhoneNumber": null,
  "companyStreetAddress1": null,
  "companyStreetAddress2": null,
  "companyCity": null,
  "companyStateCode": null,
  "companyZip": null,
  "companyType": "partnership",
  "tosAcceptanceDate": null,
  "tosAcceptanceIPAddress": null,
  "ownerInformation": [
    {
      "isOwnerPrimary": null,
      "ownerDOB": null,
      "ownerFirstName": null,
      "ownerLastName": null,
      "ownerLast4ssn": null
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|deadline|string|false|none|The date information is the section is due in YYYY-MM-DD format.|
|companyEIN|any|false|none|The company's Employer Identification Number.|
|companyLegalOperatingName|any|false|none|The official name of the company as listed with the tax authority.|
|companyPhoneNumber|any|false|none|Main contact number for the company.|
|companyStreetAddress1|any|false|none|Address of the business.|
|companyStreetAddress2|any|false|none|Address of the business.|
|companyCity|any|false|none|City of the business.|
|companyStateCode|any|false|none|Two-character code for the state in which the business is based.|
|companyZip|any|false|none|Zip code for business location. Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.|
|companyType|any|false|none|A list of business types will be provided and this field will be validated.|
|tosAcceptanceDate|any|false|none|Date terms of service were accepted. Format is YYYY-MM-DD.|
|tosAcceptanceIPAddress|any|false|none|IP address used when terms of service were accepted.|
|ownerInformation|[object]|false|none|Required information for each owner.|
|» isOwnerPrimary|any|false|none|Indicates whether this owner is the primary business owner.|
|» ownerDOB|any|false|none|Date-of-birth of the company owner. Format is YYYY-MM-DD.|
|» ownerFirstName|any|false|none|First name of the owner.|
|» ownerLastName|any|false|none|Last name of the owner.|
|» ownerLast4ssn|any|false|none|Social security number of the owner.|

#### Enumerated Values

|Property|Value|
|---|---|
|companyType|partnership|
|companyType|LLC|
|companyType|corporation|

<h2 id="tocSmerchantupdateobject">MerchantUpdateObject</h2>

<a id="schemamerchantupdateobject"></a>

```json
{
  "companyEIN": "string",
  "companyLegalOperatingName": "string",
  "companyPhoneNumber": "string",
  "companyStreetAddress1": "string",
  "companyStreetAddress2": "string",
  "companyCity": "string",
  "companyStateCode": "string",
  "companyZip": "string",
  "companyType": "partnership",
  "tosAcceptanceDate": "string",
  "tosAcceptanceIPAddress": "string",
  "commpanyDescription": "string",
  "companyURL": "string",
  "dba": "string",
  "companyEmail": "string",
  "annualRevenue": "string",
  "averageOrderValue": "string",
  "industry": "string",
  "dateEstablished": "string",
  "supportPhone": "string",
  "annualChargeBackAmount": "string",
  "annualRefundsAmount": "string",
  "otherServiceLinks": [
    {
      "serviceName": null,
      "serviceURL": null,
      "serviceToken": null
    }
  ],
  "ownerInformation": [
    {
      "driversLicenseNumber": "string",
      "driversLicenseState": "string",
      "ownerDocuments": [
        {
          "documentType": "string"
        }
      ]
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|companyEIN|string|false|none|The company's Employer Identification Number.|
|companyLegalOperatingName|string|false|none|The official name of the company as listed with the tax authority.|
|companyPhoneNumber|string|false|none|Main contact number for the company.|
|companyStreetAddress1|string|false|none|Address of the business.|
|companyStreetAddress2|string|false|none|Address of the business.|
|companyCity|string|false|none|City of the business.|
|companyStateCode|string|false|none|Two-character code for the state in which the business is based.|
|companyZip|string|false|none|Zip code for business location. Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.|
|companyType|any|false|none|A list of business types will be provided and this field will be validated.|
|tosAcceptanceDate|string|false|none|Date terms of service were accepted. Format is YYYY-MM-DD.|
|tosAcceptanceIPAddress|string|false|none|IP address used when terms of service were accepted.|
|commpanyDescription|string|false|none|Freeform description of the business.|
|companyURL|string|false|none|The main url for the business.|
|dba|string|false|none|Any doing-business-as names that would apply.|
|companyEmail|string|false|none|Email address for main contact at the company.|
|annualRevenue|string|false|none|Total annual revenue for the business. Includes two decimal points but no dollar symbol.|
|averageOrderValue|string|false|none|The typical order value for this business. Includes two decimal points but no dollar symbol.|
|industry|string|false|none|A list of industries will be provided and this field will be validated.|
|dateEstablished|string|false|none|The date the company was started in YYYY-MM-DD format.|
|supportPhone|string|false|none|Business phone number for customer support.|
|annualChargeBackAmount|string|false|none|Total amount of chargebacks for the prior year.|
|annualRefundsAmount|string|false|none|Total amount of refunds for the prior year.|
|otherServiceLinks|[object]|false|none|Future feature. This section will allow other services, such as Quicken, to facilitate onboarding.|
|» serviceName|any|false|none|The name of the company providing the service. Quicken, for example.|
|» serviceURL|any|false|none|The url for the support page for the service.|
|» serviceToken|any|false|none|Customer token needed to access the service.|
|ownerInformation|[object]|false|none|Optional information for each owner.|
|» driversLicenseNumber|string|false|none|Driver's license number.|
|» driversLicenseState|string|false|none|State where driver's license was issued.|
|» ownerDocuments|[object]|false|none|Scanned in documents to supplement and verify information.|
|»» documentType|string|false|none|Enum describing type of document requested or required.|

#### Enumerated Values

|Property|Value|
|---|---|
|companyType|partnership|
|companyType|LLC|
|companyType|corporation|

<h2 id="tocScreatelinkobject">CreateLinkObject</h2>

<a id="schemacreatelinkobject"></a>

```json
{
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionAmount|string|false|none|Required for POST. Includes two decimal points but no dollar symbol.|
|mobileNumber|string|false|none|Optional. International phone numbers are supported. No formatted should be included. Just the digits.|
|transactionPurpose|string|false|none|Required for POST. Currently this is freeform but will be enumerated in database in the future.|
|firstName|string|false|none|Optional|
|lastName|string|false|none|Optional|
|email|string|false|none|Optional|
|dob|string|false|none|Optional. Format is YYYY-MM-DD. Please use the whole format as shown below in the example.|
|ssn4|string|false|none|Optional.|
|ssn|string|false|none|optional|
|streetAddress1|string|false|none|optional|
|streetAddress2|string|false|none|optional|
|city|string|false|none|optional|
|stateCode|string|false|none|optional|
|zip|string|false|none|Optional. Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.|
|employer|string|false|none|optional|
|annualIncomeBeforeTaxes|string|false|none|Optional. Includes the decimal point but no dollar sign.|
|coborrowerMobileNumber|string|false|none|Optional. Coborrower mobile number. International phone numbers are supported. No formatted should be included. Just the digits.|
|transactionLineItems|[[CreateLinkLineItems](#schemacreatelinklineitems)]|false|none|none|

<h2 id="tocScreatelinklineitems">CreateLinkLineItems</h2>

<a id="schemacreatelinklineitems"></a>

```json
{
  "productDescription": "labor",
  "SKU": "none",
  "pricePerUnit": "50000.00",
  "tax": "na",
  "discount": "5000.00",
  "totalAmount": "55000.00"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|productDescription|string|false|none|none|
|SKU|string|false|none|none|
|pricePerUnit|string|false|none|Includes the decimal point but no dollar sign.|
|tax|string|false|none|Includes the decimal point but no dollar sign.|
|discount|string|false|none|Includes the decimal point but no dollar sign.|
|totalAmount|string|false|none|Includes the decimal point but no dollar sign.|
|photo|string|false|none|To be fixed to use media attachment later.|

<h2 id="tocStransactionobject">TransactionObject</h2>

<a id="schematransactionobject"></a>

```json
{
  "status": "initiated",
  "transactionAmount": "1000.00",
  "mobileNumber": 1235554567,
  "transactionPurpose": "landscape",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "streetAddress": "123 Ashton Street",
  "streetAddress2": "Suite 13",
  "city": "Auburn",
  "state": "CA",
  "zip": 95602,
  "annualIncomeBeforeTaxes": "950000.00",
  "coborrowerMobileNumber": 5555556767
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|false|none|Indicates the current state of the transaction: initiated, authorized, settled, refunded, expired, or decined.|
|transactionAmount|string|false|none|Required for POST. Includes two decimal points but no dollar symbol.|
|mobileNumber|string|false|none|Required for POST. International phone numbers are supported. No formatted should be included. Just the digits.|
|transactionPurpose|string|false|none|Required for POST. Currently this is freeform but will be enumerated in database in the future.|
|firstName|string|false|none|optional|
|lastName|string|false|none|optional|
|email|string|false|none|optional|
|dob|string|false|none|Optional. Format is YYYY-MM-DD. Please use the whole format as shown below in the example.|
|ssn4|string|false|none|Optional.|
|ssn|string|false|none|optional|
|streetAddress1|string|false|none|optional|
|streetAddress2|string|false|none|optional|
|city|string|false|none|optional|
|stateCode|string|false|none|optional|
|zip|string|false|none|Optional. Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.|
|employer|string|false|none|optional|
|annualIncomeBeforeTaxes|string|false|none|Optional. Includes the decimal point but no dollar sign.|
|coborrowerMobileNumber|string|false|none|Optional. Coborrower mobile number. International phone numbers are supported. No formatted should be included. Just the digits.|
|transactionLineItems|[[TransactionLineItems](#schematransactionlineitems)]|false|none|none|

#### Enumerated Values

|Property|Value|
|---|---|
|status|initiated|
|status|authorized|
|status|settled|
|status|refunded|
|status|expired|
|status|declined|

<h2 id="tocStransactionlineitems">TransactionLineItems</h2>

<a id="schematransactionlineitems"></a>

```json
{
  "productDescription": "labor",
  "SKU": "none",
  "pricePerUnit": "50000.00",
  "tax": "na",
  "discount": "5000.00",
  "totalAmount": "55000.00"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|productDescription|string|false|none|none|
|SKU|string|false|none|none|
|pricePerUnit|string|false|none|Includes the decimal point but no dollar sign.|
|tax|string|false|none|Includes the decimal point but no dollar sign.|
|discount|string|false|none|Includes the decimal point but no dollar sign.|
|totalAmount|string|false|none|Includes the decimal point but no dollar sign.|
|photo|string|false|none|To be fixed to use media attachment later.|

<h2 id="tocSuserobject">UserObject</h2>

<a id="schemauserobject"></a>

```json
{
  "userId": "6f6c4bf4-ab58-4a1b-833e-0e665dc65400",
  "firstName": "Hugh",
  "lastName": "Cave",
  "email": "hugh@akhouse.com",
  "mobilePhone": 5556669999,
  "userName": "hughb",
  "password": "sample",
  "role": "admin",
  "group": "na"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|userId|string|false|none|UUID uniquely identifying the user.|
|firstName|string|false|none|The first name of the user.|
|lastName|string|false|none|The last name of the user.|
|email|string|false|none|Email address of the user.|
|mobilePhone|string|false|none|The user's cell phone number.|
|userName|string|false|none|A log in name for the user.|
|password|string|false|none|SHA-256 encrypted string representing the password.|
|role|string|false|none|Role for user.|
|group|string|false|none|Users can be assigned to a group and will inherit the rights and priveleges assigned to that group.|

#### Enumerated Values

|Property|Value|
|---|---|
|role|admin|
|role|employee|
|role|reviewer|

<h2 id="tocSerror">Error</h2>

<a id="schemaerror"></a>

```json
{
  "message": "string",
  "type": "string",
  "request-id": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|message|string|false|none|none|
|type|string|false|none|none|
|request-id|string|false|none|none|

