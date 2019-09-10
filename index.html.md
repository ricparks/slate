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

<h1 id="wisetack-api">Wisetack API v1.1.1</h1>

> Scroll down for code samples, example requests and responses. Select a language for code samples from the tabs above or the mobile navigation menu.

## Introduction
With Wisetack customers can pay over time for a purchase, and a business gets paid upfront. The Wisetack APIs enable seamless integration of consumer financing options
within another system serving businesses and their customers. Here's a brief overview of the APIs:

* **Transactions** initiates a transaction between a specific business and a customer.
The Transaction resource also allows tracking and updating the flow of the transaction through authorization and settlement.

* **PaymentLink** allows a specific type of transaction that starts from an HTML link embedded in an invoice or payment flow. This
link will initiate a transaction that is session specific for that invoice.

* **Merchants** allows enabling merchants to offer financing as a payment option, listing existing merchants based on
date and status filters, getting information on a merchant, and removing merchants from the system.

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

<h1 id="wisetack-api-transactions">Transactions</h1>

The Transaction resource initiates transactions and manages the flow of authorization, settlement, and refunds.

## POST initiates a transaction process.

> Code samples

`POST /merchants/{merchantId}/transactions`

When a transaction is initiated, the customer receives a text message with a link to their application. They can follow the link to complete a short, mobile-optimized flow. To start a transaction, the
merchant must provide the mobile number of the customer, a transaction amount, and the purpose of the transaction.

The POST can also include an array of line items to describe the services or products provided as
well as other optional data described in the TransactionObject. These are optional. We recommend including as much information as possible as the data helps create a better user experience, allows better transaction reporting and reconciliation for the business and customer.
The following values are required for the POST:

* a United States domestic mobile phone number is required.

* a transaction amount is required.

* a transaction purpose is required.

* the date on which the service is to be completed is required.

> Body parameter

```json
{
  "transactionAmount": 1200,
  "mobileNumber": "string",
  "transactionPurpose": "string",
  "serviceCompletedOn": "string",
  "callbackURL": "string",
  "selectedFinancialProduct": "string",
  "firstName": "Esther",
  "lastName": "Savage",
  "email": "sample@example.com",
  "dob": 0,
  "ssn4": 1234,
  "ssn": 123456789,
  "streetAddress1": "123 Elm Street",
  "streetAddress2": "Suite 9",
  "city": "Austin",
  "stateCode": "TX",
  "zip": 80401,
  "employer": "Acme Delivery Service 1-800-333-4444",
  "annualIncomeBeforeTaxes": 200000,
  "coborrowerMobileNumber": 5552223333,
  "transactionLineItems": [
    {
      "productDescription": "labor",
      "SKU": "none",
      "pricePerUnit": "50000.00",
      "tax": "na",
      "discount": "5000.00",
      "totalAmount": "55000.00"
    }
  ]
}
```

<h3 id="post-initiates-a-transaction-process.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[TransactionRequest](#schematransactionrequest)|true|none|
|merchantId|path|string|true|none|

> Example responses

> 200 Response

```json
{
  "transactionId": "96fd73a4-36d2-45da-b7b2-19ec7b4b3dc5",
  "status": null
}
```

<h3 id="post-initiates-a-transaction-process.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[TransactionResponse](#schematransactionresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
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
|limit|query|integer|false|Maximum number of transactions to return.|
|startingAfter|query|string|false|List only transactions that were initiated after this date.|
|endingBefore|query|string|false|List only transactions that were initiated before this date.|
|status|query|string|false|List only transactions with this status code.|

> Example responses

> 200 Response

```json
[
  {
    "id": "8519e81f",
    "initiationDate": 1575158400000,
    "status": "Incomplete Information",
    "transactionPurpose": "miscellaneous",
    "serviceCompletedOn": "2019-08-30 07:00:00+0000",
    "requestedLoanAmount": null,
    "approvedLoanAmount": "string",
    "settledLoanAmount": "string",
    "refundAmount": "string",
    "maximumAmount": "string",
    "tilaAcceptedOn": "2019-08-30 15:26:37+0000",
    "createdAt": 1575158400000,
    "consumer": {
      "fullName": "string",
      "email": "string",
      "phone": 15555555552,
      "zip": 84101
    },
    "statusHistory": [
      {
        "date": "8/30",
        "amount": "$3,425.00",
        "status": "Incomplete Information"
      }
    ]
  }
]
```

<h3 id="get-returns-a-list-of-transactions-for-this-merchant.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|Inline|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

<h3 id="get-returns-a-list-of-transactions-for-this-merchant.-responseschema">Response Schema</h3>

Status Code **200**

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|*anonymous*|[[MerchantTransactionsResponse](#schemamerchanttransactionsresponse)]|false|none|[All known information about a transaction for a merchant.]|
|» id|string|false|none|transaction short id|
|» initiationDate|string|false|none|Date the loan initiated.|
|» status|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|
|» transactionPurpose|string|false|none|transaction purpose|
|» serviceCompletedOn|string(date-time)|false|none|none|
|» requestedLoanAmount|string|false|none|The original loan amount requested by the customer.|
|» approvedLoanAmount|string|false|none|The loan amount approved for this user by Wisetack. Might be lower than originalLoanAmount in the event of a counter offer.|
|» settledLoanAmount|string|false|none|Future. The loan amount that was paid to the merchant after the work was completed.|
|» refundAmount|string|false|none|The amount, if any, that was refunded to the customer.|
|» maximumAmount|string|false|none|Future. The largest transaction amount that can be offered to this consumer.|
|» tilaAcceptedOn|string(date-time)|false|none|none|
|» createdAt|integer|false|none|unix timestamp when transaction created|
|» consumer|object|false|none|none|
|»» fullName|string|false|none|consumer full name|
|»» email|string|false|none|consumer email|
|»» phone|string|false|none|consumer phone|
|»» zip|string|false|none|consumer zip|
|» statusHistory|[object]|false|none|none|
|»» date|string|false|none|status set date|
|»» amount|string|false|none|transaction amount|
|»» status|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|

#### Enumerated Values

|Property|Value|
|---|---|
|status|Incomplete Information|
|status|Initiated|
|status|Authorized|
|status|Loan confirmed|
|status|Settled|
|status|Refunded|
|status|Declined|
|status|Expired|
|status|Incomplete Information|
|status|Initiated|
|status|Authorized|
|status|Loan confirmed|
|status|Settled|
|status|Refunded|
|status|Declined|
|status|Expired|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
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
  "id": "8519e81f",
  "initiationDate": 1575158400000,
  "status": "Incomplete Information",
  "transactionPurpose": "miscellaneous",
  "serviceCompletedOn": "2019-08-30 07:00:00+0000",
  "requestedLoanAmount": null,
  "approvedLoanAmount": "string",
  "settledLoanAmount": "string",
  "refundAmount": "string",
  "maximumAmount": "string",
  "tilaAcceptedOn": "2019-08-30 15:26:37+0000",
  "createdAt": 1575158400000,
  "consumer": {
    "fullName": "string",
    "email": "string",
    "phone": 15555555552,
    "zip": 84101
  },
  "statusHistory": [
    {
      "date": "8/30",
      "amount": "$3,425.00",
      "status": "Incomplete Information"
    }
  ]
}
```

<h3 id="get-retrieves-information,-including-the-status,-on-a-specific-transaction.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantTransactionsResponse](#schemamerchanttransactionsresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

<h1 id="wisetack-api-paymentlink">PaymentLink</h1>

PaymentLink allows a specific type of transaction that starts from an HTML link embedded in an invoice
or payment flow. This link will initiate a transaction that is session specific for that invoice.

## POST creates a link to be embedded in an invoice.

> Code samples

`POST /merchant/{merchantId}/paymentLink`

You can use the paymentLink resource to create links that can be embedded in invoices or payment flows. PaymentLink allows sending data that will
make it easier for the customer to complete the transaction. When you send additional information when creating a payment link,
Wisetack uses it to pre-fill transaction information and make the customer's experience easier.

Creating a payment link requires a transaction amount and purpose.  Optional fields such as customer address, dob,
and ssn as well as optional line item information is also supported. The POST returns a link that is specific for
that customer, merchant, and line items. When the customer clicks the link, they will proceed to a transaction flow specific to that transaction. A unique link will be created on each create. The link expires after 90 days.

> Body parameter

```json
{
  "paymentLink": "http://business.wisetack.us/loanApplicationId=80349125-3b0c-4fd6-b2ef-568a4844321d",
  "transactionAmount": 1000,
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
  "annualIncomeBeforeTaxes": 950000,
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="post-creates-a-link-to-be-embedded-in-an-invoice.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|Id for the merchant originating the transaction|
|body|body|[PaymentLinkObject](#schemapaymentlinkobject)|false|none|

> Example responses

> 200 Response

```json
{
  "paymentLink": "http://business.wisetack.us/loanApplicationId=80349125-3b0c-4fd6-b2ef-568a4844321d",
  "transactionAmount": 1000,
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
  "annualIncomeBeforeTaxes": 950000,
  "coborrowerMobileNumber": 5555556767
}
```

<h3 id="post-creates-a-link-to-be-embedded-in-an-invoice.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[PaymentLinkObject](#schemapaymentlinkobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

<h1 id="wisetack-api-merchants">Merchants</h1>

The Merchant resource allows you to to list all merchants and to get information on individual merchants.

## GET retrieves merchant information based on merchant id.

> Code samples

`GET /merchants/{merchantId}`

<h3 id="get-retrieves-merchant-information-based-on-merchant-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|The unique identifier for the merchant.|

> Example responses

> 200 Response

```json
{
  "merchantId": "96fd73a4-36d2-45da-b7b2-19ec7b4b3dc5",
  "onboardingDate": 1575158400000,
  "transactionsEnabled": false,
  "companyLegalOperatingName": "Acme Delivery Services"
}
```

<h3 id="get-retrieves-merchant-information-based-on-merchant-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantGetResponse](#schemamerchantgetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## GET retrieves a list of merchants.

> Code samples

`GET /merchants`

Lists all merchants on your Wisetack account. You can filter this list based on date and if their transaction initiation has or has not been enabled.

<h3 id="get-retrieves-a-list-of-merchants.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|limit|query|integer|false|Maximum number of merchants to return.|
|startingAfter|query|string|false|List only merchants who initiated their onboard after this date.|
|endingBefore|query|string|false|List only merchants who initiated their onboarding before this date.|
|transactionsEnabled|query|string|false|Return for currently enabled merchants, true or false.|

> Example responses

> 200 Response

```json
{
  "merchantId": "96fd73a4-36d2-45da-b7b2-19ec7b4b3dc5",
  "onboardingDate": 1575158400000,
  "transactionsEnabled": false,
  "companyLegalOperatingName": "Acme Delivery Services"
}
```

<h3 id="get-retrieves-a-list-of-merchants.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantGetResponse](#schemamerchantgetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

<h1 id="wisetack-api-cors">CORS</h1>

## CORS support

> Code samples

`OPTIONS /test/{paramInPath}`

Enable CORS by returning correct headers

<h3 id="cors-support-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|paraminheader|header|string|false|Parameter passed through header.|
|paramInPath|path|string|true|Parameter passed through path.|
|paramInQuery|query|string|false|Parameter passed in query.|
|body|header|[testbody](#schematestbody)|true|Test Request.|

<h3 id="cors-support-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Default responnse for CORS method|None|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

<h1 id="wisetack-api-internaluse">InternalUse</h1>

## PATCH allows status update for transaction initiation and provides for full or partial refunds.

> Code samples

`PATCH /loanApplications/{loanApplicationId}`

Supported statuses for transactions:

* Initiated: The transaction process has been started for a customer but has not yet proceeded through authorization.

* Authorized: Wisetack has authorized the transactionn for this customer. The transaction is not complete until the status is set to 'settled.' An authorized transaction can either be 'settled' or 'canceled'. An authorized transaction will expire after 30 days if it has not been settled.

* Settled: Once the transaction is settled, funds are sent to the merchant. A settled transaction can be either partially or completely refunded.

* Refunded:  The full amount of the transaction has been refunded.

* Expired: The transaction was not authorized or settled within the specified time limit. A transaction can never be removed from an expired state.

* Declined: The transaction was declined.

> Body parameter

```json
{
  "transactionAmount": 1000,
  "mobileNumber": 1235554567,
  "loanPurpose": "landscape",
  "selectedFinancialProduct": "fully_amortizing_risk_based",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "zip": 95602,
  "annualIncomeBeforeTaxes": 120000,
  "status": "initiated"
}
```

<h3 id="patch-allows-status-update-for-transaction-initiation-and-provides-for-full-or-partial-refunds.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[LoanApplicationRequest](#schemaloanapplicationrequest)|true|none|
|loanApplicationId|path|string|true|UUID Id for the transaction. Acquired during the POST to create the transaction.|
|initToken|query|string|false|none|

> Example responses

> 200 Response

```json
{
  "loanApplicationId": "39f11e30-0b2c-499e-9180-0c2ed29ad11d",
  "initToken": "12AB7",
  "status": "OFFER_AVAILABLE"
}
```

<h3 id="patch-allows-status-update-for-transaction-initiation-and-provides-for-full-or-partial-refunds.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[LoanApplicationResponse](#schemaloanapplicationresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Creates a merchant and returns a newly created merchant id.

> Code samples

`POST /merchants`

If there is a unique merchant entry, a 201 error is returned with a link to the resource.

> Body parameter

```json
{
  "merchantId": "string",
  "businessName": "string",
  "displayName": "string",
  "email": "string",
  "statementDescriptor": "string",
  "businessTaxId": "string",
  "addressInformation": "string",
  "chargesEnabled": true,
  "payoutsEnabled": true,
  "payoutSchedule": "string",
  "tos_acceptance": true,
  "pricingTier": "string",
  "borrowerInformations": [
    {
      "borrowerInformation": "string"
    }
  ]
}
```

<h3 id="creates-a-merchant-and-returns-a-newly-created-merchant-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Merchant](#schemamerchant)|true|none|
|limit|query|integer|false|Maximum number of merchants to return.|
|startingAfter|query|string|false|List only merchants who initiated their onboard after this date.|
|endingBefore|query|string|false|List only merchants who initiated their onboarding before this date.|
|transactionsEnabled|query|string|false|Return for currently enabled merchants, true or false.|

> Example responses

> 200 Response

```json
{
  "merchantResourceURL": "string"
}
```

<h3 id="creates-a-merchant-and-returns-a-newly-created-merchant-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantPostResponse](#schemamerchantpostresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Updates merchant information.

> Code samples

`PATCH /merchants`

> Body parameter

```json
{
  "merchantId": "string",
  "businessName": "string",
  "displayName": "string",
  "email": "string",
  "statementDescriptor": "string",
  "businessTaxId": "string",
  "addressInformation": "string",
  "chargesEnabled": true,
  "payoutsEnabled": true,
  "payoutSchedule": "string",
  "tos_acceptance": true,
  "pricingTier": "string",
  "borrowerInformations": [
    {
      "borrowerInformation": "string"
    }
  ]
}
```

<h3 id="updates-merchant-information.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[Merchant](#schemamerchant)|true|none|
|limit|query|integer|false|Maximum number of merchants to return.|
|startingAfter|query|string|false|List only merchants who initiated their onboard after this date.|
|endingBefore|query|string|false|List only merchants who initiated their onboarding before this date.|
|transactionsEnabled|query|string|false|Return for currently enabled merchants, true or false.|

> Example responses

> 200 Response

```json
{
  "responseBody": {
    "merchantId": "string",
    "businessName": "string",
    "displayName": "string",
    "email": "string",
    "statementDescriptor": "string",
    "businessTaxId": "string",
    "addressInformation": "string",
    "chargesEnabled": true,
    "payoutsEnabled": true,
    "payoutSchedule": "string",
    "tos_acceptance": true,
    "pricingTier": "string",
    "borrowerInformations": [
      {
        "borrowerInformation": "string"
      }
    ]
  },
  "statusCode": "string"
}
```

<h3 id="updates-merchant-information.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantPatchResponse](#schemamerchantpatchresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Deletes merchant based on merchant id.

> Code samples

`DELETE /merchants`

<h3 id="deletes-merchant-based-on-merchant-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|limit|query|integer|false|Maximum number of merchants to return.|
|startingAfter|query|string|false|List only merchants who initiated their onboard after this date.|
|endingBefore|query|string|false|List only merchants who initiated their onboarding before this date.|
|transactionsEnabled|query|string|false|Return for currently enabled merchants, true or false.|

> Example responses

> 200 Response

```json
{
  "responseBody": {
    "merchantId": "string",
    "deleted": true
  },
  "statusCode": "string"
}
```

<h3 id="deletes-merchant-based-on-merchant-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantDeleteResponse](#schemamerchantdeleteresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## GET retrieves information, including the status, on a specific transaction.

> Code samples

`GET /loanApplications/{loanApplicationId}`

<h3 id="get-retrieves-information,-including-the-status,-on-a-specific-transaction.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|loanApplicationId|path|string|true|UUID Id for the transaction. Acquired during the POST to create the transaction.|
|initToken|query|string|false|none|

> Example responses

> 200 Response

```json
{
  "loanApplicationId": "39f11e30-0b2c-499e-9180-0c2ed29ad11d",
  "initToken": "12AB7",
  "status": "OFFER_AVAILABLE"
}
```

<h3 id="get-retrieves-information,-including-the-status,-on-a-specific-transaction.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[LoanApplicationResponse](#schemaloanapplicationresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Merchant log in with phone/email.

> Code samples

`POST /merchants/login`

> Body parameter

```json
{
  "username": "string"
}
```

<h3 id="merchant-log-in-with-phone/email.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantLoginRequest](#schemamerchantloginrequest)|true|none|

> Example responses

> 200 Response

```json
{
  "responseBody": {
    "success": true,
    "message": "string",
    "code": "string"
  },
  "statusCode": "string"
}
```

<h3 id="merchant-log-in-with-phone/email.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantLoginResponse](#schemamerchantloginresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Merchant auth with verification code.

> Code samples

`POST /merchants/auth`

> Body parameter

```json
{
  "code": "string",
  "username": "string",
  "token": "string"
}
```

<h3 id="merchant-auth-with-verification-code.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantAuthRequest](#schemamerchantauthrequest)|true|none|

> Example responses

> 200 Response

```json
{
  "responseBody": {
    "success": true,
    "token": "string",
    "merchant": {
      "id": "string",
      "name": "string"
    },
    "user": {
      "userId": "string",
      "merchantId": "string"
    }
  },
  "statusCode": "string"
}
```

<h3 id="merchant-auth-with-verification-code.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantAuthResponse](#schemamerchantauthresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## get__merchants_me

> Code samples

`GET /merchants/me`

> Example responses

> 200 Response

```json
{
  "responseBody": {
    "success": true,
    "token": "string",
    "merchant": {
      "id": "string",
      "name": "string"
    },
    "user": {
      "userId": "string",
      "merchantId": "string"
    }
  },
  "statusCode": "string"
}
```

<h3 id="get__merchants_me-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantAuthResponse](#schemamerchantauthresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## get__transactions

> Code samples

`GET /transactions`

<h3 id="get__transactions-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|limit|query|integer|false|none|
|startingAfter|query|string|false|none|
|endingBefore|query|string|false|none|
|status|query|string|false|none|

> Example responses

> 200 Response

```json
{
  "transactionId": "96fd73a4-36d2-45da-b7b2-19ec7b4b3dc5",
  "status": null
}
```

<h3 id="get__transactions-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[TransactionResponse](#schematransactionresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Create merchant user.

> Code samples

`POST /merchants/{merchantId}/users`

> Body parameter

```json
{}
```

<h3 id="create-merchant-user.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantUser](#schemamerchantuser)|true|none|
|merchantId|path|string|true|none|

> Example responses

> 200 Response

```json
{}
```

<h3 id="create-merchant-user.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantUserPostResponse](#schemamerchantuserpostresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Returns merchant users.

> Code samples

`GET /merchants/{merchantId}/users`

<h3 id="returns-merchant-users.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|merchantId|path|string|true|none|

> Example responses

> 200 Response

```json
{}
```

<h3 id="returns-merchant-users.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantUserGetResponse](#schemamerchantusergetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Returns merchant users list.

> Code samples

`GET /users`

<h3 id="returns-merchant-users-list.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|limit|query|integer|false|none|

> Example responses

> 200 Response

```json
{}
```

<h3 id="returns-merchant-users-list.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantUserGetResponse](#schemamerchantusergetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Retrieves merchant user information based on merchant user id.

> Code samples

`GET /users/{userId}`

<h3 id="retrieves-merchant-user-information-based-on-merchant-user-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|userId|path|string|true|The previously determined merchant user id.|

> Example responses

> 200 Response

```json
{}
```

<h3 id="retrieves-merchant-user-information-based-on-merchant-user-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantUserGetResponse](#schemamerchantusergetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Updates merchant user information.

> Code samples

`PATCH /users/{userId}`

> Body parameter

```json
{}
```

<h3 id="updates-merchant-user-information.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[MerchantUser](#schemamerchantuser)|true|none|
|userId|path|string|true|The previously determined merchant user id.|

> Example responses

> 200 Response

```json
{
  "responseBody": {},
  "statusCode": "string"
}
```

<h3 id="updates-merchant-user-information.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantUserPatchResponse](#schemamerchantuserpatchresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Deletes merchant user based on merchant user id.

> Code samples

`DELETE /users/{userId}`

<h3 id="deletes-merchant-user-based-on-merchant-user-id.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|userId|path|string|true|The previously determined merchant user id.|

> Example responses

> 200 Response

```json
{}
```

<h3 id="deletes-merchant-user-based-on-merchant-user-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantUserDeleteResponse](#schemamerchantuserdeleteresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Get a list of the loan offers for this consumer.

> Code samples

`GET /loanApplications/{loanApplicationId}/offers`

<h3 id="get-a-list-of-the-loan-offers-for-this-consumer.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|loanApplicationId|path|string|true|none|

> Example responses

> 200 Response

```json
{
  "loanApplicationId": "string",
  "loanOfferDetailsList": [
    {
      "id": "string",
      "loanAmount": "string",
      "loanTermMonths": 0,
      "interestRate": 0,
      "monthlyPayment": 0,
      "numberOfPayments": 0,
      "firstPaymentDue": "string",
      "totalInterest": 0,
      "totalPayments": 0,
      "totalFinancialCharges": 0,
      "status": "string",
      "truthInLending": "string",
      "loanAgreement": "string",
      "creditScoreDisclosure": "string"
    }
  ],
  "loanAdversActionsList": [
    {
      "rank": "string",
      "text": "string"
    }
  ]
}
```

<h3 id="get-a-list-of-the-loan-offers-for-this-consumer.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[LoanOfferResponse](#schemaloanofferresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Get the details for this individual loan offer.

> Code samples

`GET /loanApplications/{loanApplicationId}/offers/{loanOfferId}`

> Body parameter

```json
{
  "status": "SELECTED"
}
```

<h3 id="get-the-details-for-this-individual-loan-offer.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[LoanOfferRequest](#schemaloanofferrequest)|false|none|
|loanApplicationId|path|string|true|none|
|loanOfferId|path|string|true|none|
|provideTruthInLendingDocument|query|string|false|none|

> Example responses

> 200 Response

```json
{
  "loanApplicationId": "string",
  "loanOfferDetailsList": [
    {
      "id": "string",
      "loanAmount": "string",
      "loanTermMonths": 0,
      "interestRate": 0,
      "monthlyPayment": 0,
      "numberOfPayments": 0,
      "firstPaymentDue": "string",
      "totalInterest": 0,
      "totalPayments": 0,
      "totalFinancialCharges": 0,
      "status": "string",
      "truthInLending": "string",
      "loanAgreement": "string",
      "creditScoreDisclosure": "string"
    }
  ],
  "loanAdversActionsList": [
    {
      "rank": "string",
      "text": "string"
    }
  ]
}
```

<h3 id="get-the-details-for-this-individual-loan-offer.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[LoanOfferResponse](#schemaloanofferresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Update the loan offer to indicate that it was the selected offer.

> Code samples

`PATCH /loanApplications/{loanApplicationId}/offers/{loanOfferId}`

> Body parameter

```json
{
  "status": "SELECTED"
}
```

<h3 id="update-the-loan-offer-to-indicate-that-it-was-the-selected-offer.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[LoanOfferRequest](#schemaloanofferrequest)|true|none|
|loanApplicationId|path|string|true|none|
|loanOfferId|path|string|true|none|
|provideTruthInLendingDocument|query|string|false|none|

> Example responses

> 200 Response

```json
{
  "loanApplicationId": "string",
  "loanOfferDetailsList": [
    {
      "id": "string",
      "loanAmount": "string",
      "loanTermMonths": 0,
      "interestRate": 0,
      "monthlyPayment": 0,
      "numberOfPayments": 0,
      "firstPaymentDue": "string",
      "totalInterest": 0,
      "totalPayments": 0,
      "totalFinancialCharges": 0,
      "status": "string",
      "truthInLending": "string",
      "loanAgreement": "string",
      "creditScoreDisclosure": "string"
    }
  ],
  "loanAdversActionsList": [
    {
      "rank": "string",
      "text": "string"
    }
  ]
}
```

<h3 id="update-the-loan-offer-to-indicate-that-it-was-the-selected-offer.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[LoanOfferResponse](#schemaloanofferresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Creates a new payment account and associates it with the loan application.

> Code samples

`POST /loanApplications/{loanApplicationId}/paymentAccounts`

> Body parameter

```json
{
  "plaidToken": "access-sandbox-5cd6e1b1-1b5b-459d-9284-366e2da89755"
}
```

<h3 id="creates-a-new-payment-account-and-associates-it-with-the-loan-application.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[PaymentAccountRequest](#schemapaymentaccountrequest)|true|none|
|loanApplicationId|path|string|true|none|

> Example responses

> 200 Response

```json
{
  "status": "plaidTokenAccepted"
}
```

<h3 id="creates-a-new-payment-account-and-associates-it-with-the-loan-application.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[PaymentAccountResponse](#schemapaymentaccountresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|[Error](#schemaerror)|
|401|[Unauthorized](https://tools.ietf.org/html/rfc7235#section-3.1)|Unauthorized.|[Error](#schemaerror)|
|403|[Forbidden](https://tools.ietf.org/html/rfc7231#section-6.5.3)|Forbidden.|[Error](#schemaerror)|
|404|[Not Found](https://tools.ietf.org/html/rfc7231#section-6.5.4)|Not Found.|[Error](#schemaerror)|
|409|[Conflict](https://tools.ietf.org/html/rfc7231#section-6.5.8)|Conflict.|[Error](#schemaerror)|
|500|[Internal Server Error](https://tools.ietf.org/html/rfc7231#section-6.6.1)|Internal Server Error.|[Error](#schemaerror)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|
|400|Access-Control-Allow-Headers|undefined||none|
|400|Access-Control-Allow-Methods|undefined||none|
|400|Access-Control-Allow-Origin|undefined||none|
|401|Access-Control-Allow-Headers|undefined||none|
|401|Access-Control-Allow-Methods|undefined||none|
|401|Access-Control-Allow-Origin|undefined||none|
|403|Access-Control-Allow-Headers|undefined||none|
|403|Access-Control-Allow-Methods|undefined||none|
|403|Access-Control-Allow-Origin|undefined||none|
|404|Access-Control-Allow-Headers|undefined||none|
|404|Access-Control-Allow-Methods|undefined||none|
|404|Access-Control-Allow-Origin|undefined||none|
|409|Access-Control-Allow-Headers|undefined||none|
|409|Access-Control-Allow-Methods|undefined||none|
|409|Access-Control-Allow-Origin|undefined||none|
|500|Access-Control-Allow-Headers|undefined||none|
|500|Access-Control-Allow-Methods|undefined||none|
|500|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Checks if the region is healthy.

> Code samples

`GET /healthcheck`

Health check endpoint.

> Example responses

> 200 Response

```json
{
  "message": "string"
}
```

<h3 id="checks-if-the-region-is-healthy.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Test response|[HealthCheckResponse](#schemahealthcheckresponse)|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

## Returns the request parameters.

> Code samples

`POST /test/{paramInPath}`

Test endpoint.

<h3 id="returns-the-request-parameters.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|paraminheader|header|string|false|Parameter passed through header.|
|paramInPath|path|string|true|Parameter passed through path.|
|paramInQuery|query|string|false|Parameter passed in query.|
|body|header|[testbody](#schematestbody)|true|Test Request.|

> Example responses

> 200 Response

```json
{
  "message": "string"
}
```

<h3 id="returns-the-request-parameters.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Test response|[testresponse](#schematestresponse)|

### Response Headers

|Status|Header|Type|Format|Description|
|---|---|---|---|---|
|200|Access-Control-Allow-Headers|undefined||none|
|200|Access-Control-Allow-Methods|undefined||none|
|200|Access-Control-Allow-Origin|undefined||none|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

<h1 id="wisetack-api-webhooks">Webhooks</h1>

## POST to your webhook as specified in the callBackURL field in the Transactions POST.

> Code samples

`POST /subscribe`

When you intially POST a new Transaction, you can supply a webhook callBackURL for that Transaction.

Each time the status of a loan application changes, Wisetack sends a request to the URL specified in the
Transactions POST. The request contains the new status and other information about the loan. When your
webhook is called, it will receive a StatusUpdateRequest.

Statuses:

* **Initiated:**  You sent a transaction to your customer but they have not submitted an application.

* **Authorized:**  We approved the application but the customer has not accepted the loan documents.

* **Declined:** We were unable to approved the application.

* **Confirmed:** The customer has accepted the loan documents and confirmed the purchase.

* **Settled:** We've sent the funds to your bank account.

* **Refunded:** The customer requested and received a refund.

* **Expired:** The customer did not complete the loan application before it expired.

> Body parameter

```json
{
  "transactionId": "string",
  "changedStatus": "Incomplete Information",
  "date": "string",
  "requestedLoanAmount": "string",
  "approvedLoanAmount": "string",
  "settledLoanAmount": "string",
  "refundAmount": "string",
  "maximumAmount": "string",
  "consumer": {
    "fullName": "string",
    "email": "string",
    "phone": "string",
    "zip": "string"
  },
  "transactionPurpose": "string",
  "serviceCompletedOn": "string",
  "tilaAcceptedOn": "string",
  "createdAt": "string"
}
```

<h3 id="post-to-your-webhook-as-specified-in-the-callbackurl-field-in-the-transactions-post.-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|body|body|[StatusUpdateRequest](#schemastatusupdaterequest)|true|none|

<h3 id="post-to-your-webhook-as-specified-in-the-callbackurl-field-in-the-transactions-post.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|201|[Created](https://tools.ietf.org/html/rfc7231#section-6.3.2)|Webhook created.|None|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

# Schemas

<h2 id="tocStransactionrequest">TransactionRequest</h2>

<a id="schematransactionrequest"></a>

```json
{
  "transactionAmount": 1200,
  "mobileNumber": "string",
  "transactionPurpose": "string",
  "serviceCompletedOn": "string",
  "callbackURL": "string",
  "selectedFinancialProduct": "string",
  "firstName": "Esther",
  "lastName": "Savage",
  "email": "sample@example.com",
  "dob": 0,
  "ssn4": 1234,
  "ssn": 123456789,
  "streetAddress1": "123 Elm Street",
  "streetAddress2": "Suite 9",
  "city": "Austin",
  "stateCode": "TX",
  "zip": 80401,
  "employer": "Acme Delivery Service 1-800-333-4444",
  "annualIncomeBeforeTaxes": 200000,
  "coborrowerMobileNumber": 5552223333,
  "transactionLineItems": [
    {
      "productDescription": "labor",
      "SKU": "none",
      "pricePerUnit": "50000.00",
      "tax": "na",
      "discount": "5000.00",
      "totalAmount": "55000.00"
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionAmount|string|false|none|Required for POST. Includes two decimal points but no dollar symbol.|
|mobileNumber|string|false|none|Required for POST. International phone numbers are supported. No formating should be included. Just the digits.|
|transactionPurpose|string|false|none|Required for POST. Currently this is freeform but will be enumerated in database in the future.|
|serviceCompletedOn|string|false|none|Required by POST. The date when the merchant completes the service.|
|callbackURL|string|false|none|Optional. URL to call on status change of transaction. See StatusUpdateRequest in the schema.|
|selectedFinancialProduct|string|false|none|The merchant can have one or more financial products from which to choose for each transaction.|
|firstName|string|false|none|Customer first name|
|lastName|string|false|none|Customer last name|
|email|string|false|none|Customer email|
|dob|string|false|none|Format is YYYY-MM-DD. Please use the whole format as shown below in the example.|
|ssn4|string|false|none|Last four digits of the customer's social security number.|
|ssn|string|false|none|The customer's full social security number with no dashes.|
|streetAddress1|string|false|none|The customer's street address including number, street, and street type.|
|streetAddress2|string|false|none|Additional customer address information.|
|city|string|false|none|The customer's city of residence.|
|stateCode|string|false|none|The customer's state of residence.|
|zip|string|false|none|Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.|
|employer|string|false|none|Any available information regarding the customer's employer.|
|annualIncomeBeforeTaxes|string|false|none|Includes the decimal point but no dollar sign.|
|coborrowerMobileNumber|string|false|none|Coborrower mobile number. International phone numbers are supported. No formatting should be included. Just the digits.|
|transactionLineItems|[[LoanApplicationLineItems](#schemaloanapplicationlineitems)]|false|none|Future.|

<h2 id="tocStransactionresponse">TransactionResponse</h2>

<a id="schematransactionresponse"></a>

```json
{
  "transactionId": "96fd73a4-36d2-45da-b7b2-19ec7b4b3dc5",
  "status": null
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionId|string|false|none|UUID uniquely identifying the transaction.|
|status|any|false|none|Always Initiated or Incomplete Information|

<h2 id="tocSpaymentlinkobject">PaymentLinkObject</h2>

<a id="schemapaymentlinkobject"></a>

```json
{
  "paymentLink": "http://business.wisetack.us/loanApplicationId=80349125-3b0c-4fd6-b2ef-568a4844321d",
  "transactionAmount": 1000,
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
  "annualIncomeBeforeTaxes": 950000,
  "coborrowerMobileNumber": 5555556767
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|paymentLink|string|false|none|This link is created and can be embedded in invoices. When the customer clicks this link, they will proceed to a web page that will initiate a transaction for that customer.|
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
|transactionLineItems|[[LoanApplicationLineItems](#schemaloanapplicationlineitems)]|false|none|none|

<h2 id="tocSmerchantgetresponse">MerchantGetResponse</h2>

<a id="schemamerchantgetresponse"></a>

```json
{
  "merchantId": "96fd73a4-36d2-45da-b7b2-19ec7b4b3dc5",
  "onboardingDate": 1575158400000,
  "transactionsEnabled": false,
  "companyLegalOperatingName": "Acme Delivery Services"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|merchantId|string|false|none|A UUID unique to the newly created merchant.|
|onboardingDate|string|false|none|Date this merchant was initially onboarded in YYYY-MM-DD format.|
|transactionsEnabled|boolean|false|none|Indicates whether this merchant has been fully onboarded and can initiate transactions.|
|companyLegalOperatingName|string|false|none|Full name of the merchant's business.|

<h2 id="tocSstatusupdaterequest">StatusUpdateRequest</h2>

<a id="schemastatusupdaterequest"></a>

```json
{
  "transactionId": "string",
  "changedStatus": "Incomplete Information",
  "date": "string",
  "requestedLoanAmount": "string",
  "approvedLoanAmount": "string",
  "settledLoanAmount": "string",
  "refundAmount": "string",
  "maximumAmount": "string",
  "consumer": {
    "fullName": "string",
    "email": "string",
    "phone": "string",
    "zip": "string"
  },
  "transactionPurpose": "string",
  "serviceCompletedOn": "string",
  "tilaAcceptedOn": "string",
  "createdAt": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionId|string|false|none|UUID uniquely identifying the transaction with changed status.|
|changedStatus|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|
|date|string|false|none|Date that status changed.|
|requestedLoanAmount|string|false|none|The original loan amount requested by the customer.|
|approvedLoanAmount|string|false|none|The loan amount approved for this user by Wisetack. Might be lower than originalLoanAmount in the event of a counter offer.|
|settledLoanAmount|string|false|none|Future. The loan amount that was paid to the merchant after the work was completed.|
|refundAmount|string|false|none|The amount, if any, that was refunded to the customer.|
|maximumAmount|string|false|none|Future. The largest transaction amount that can be offered to this consumer.|
|consumer|object|false|none|none|
|» fullName|string|false|none|Customer's first and last name.|
|» email|string|false|none|Customer's email.|
|» phone|string|false|none|Customer's phone.|
|» zip|string|false|none|Customer's postal code.|
|transactionPurpose|string|false|none|Purpose of the loan as entered by merchant.|
|serviceCompletedOn|string|false|none|The date by which the service should be completed.|
|tilaAcceptedOn|string|false|none|The data the Truth In Lending document was accepted.|
|createdAt|string|false|none|The date the transaction was initiated.|

<h2 id="tocSloanapplicationlineitems">LoanApplicationLineItems</h2>

<a id="schemaloanapplicationlineitems"></a>

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

<h2 id="tocSmerchanttransactionsresponse">MerchantTransactionsResponse</h2>

<a id="schemamerchanttransactionsresponse"></a>

```json
{
  "id": "8519e81f",
  "initiationDate": 1575158400000,
  "status": "Incomplete Information",
  "transactionPurpose": "miscellaneous",
  "serviceCompletedOn": "2019-08-30 07:00:00+0000",
  "requestedLoanAmount": null,
  "approvedLoanAmount": "string",
  "settledLoanAmount": "string",
  "refundAmount": "string",
  "maximumAmount": "string",
  "tilaAcceptedOn": "2019-08-30 15:26:37+0000",
  "createdAt": 1575158400000,
  "consumer": {
    "fullName": "string",
    "email": "string",
    "phone": 15555555552,
    "zip": 84101
  },
  "statusHistory": [
    {
      "date": "8/30",
      "amount": "$3,425.00",
      "status": "Incomplete Information"
    }
  ]
}

```

*All known information about a transaction for a merchant.*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|false|none|transaction short id|
|initiationDate|string|false|none|Date the loan initiated.|
|status|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|
|transactionPurpose|string|false|none|transaction purpose|
|serviceCompletedOn|string(date-time)|false|none|none|
|requestedLoanAmount|string|false|none|The original loan amount requested by the customer.|
|approvedLoanAmount|string|false|none|The loan amount approved for this user by Wisetack. Might be lower than originalLoanAmount in the event of a counter offer.|
|settledLoanAmount|string|false|none|Future. The loan amount that was paid to the merchant after the work was completed.|
|refundAmount|string|false|none|The amount, if any, that was refunded to the customer.|
|maximumAmount|string|false|none|Future. The largest transaction amount that can be offered to this consumer.|
|tilaAcceptedOn|string(date-time)|false|none|none|
|createdAt|integer|false|none|unix timestamp when transaction created|
|consumer|object|false|none|none|
|» fullName|string|false|none|consumer full name|
|» email|string|false|none|consumer email|
|» phone|string|false|none|consumer phone|
|» zip|string|false|none|consumer zip|
|statusHistory|[object]|false|none|none|
|» date|string|false|none|status set date|
|» amount|string|false|none|transaction amount|
|» status|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|

<h2 id="tocStransactionstatus">TransactionStatus</h2>

<a id="schematransactionstatus"></a>

```json
"Incomplete Information"

```

*transaction status to display in merchant UI*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|*anonymous*|string|false|none|transaction status to display in merchant UI|

#### Enumerated Values

|Property|Value|
|---|---|
|*anonymous*|Incomplete Information|
|*anonymous*|Initiated|
|*anonymous*|Authorized|
|*anonymous*|Loan confirmed|
|*anonymous*|Settled|
|*anonymous*|Refunded|
|*anonymous*|Declined|
|*anonymous*|Expired|

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

<h2 id="tocStestbody">testbody</h2>

<a id="schematestbody"></a>

```json
{
  "paramInBody": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|paramInBody|string|true|none|none|

<h2 id="tocStestresponse">testresponse</h2>

<a id="schematestresponse"></a>

```json
{
  "message": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|message|string|true|none|none|

<h2 id="tocShealthcheckresponse">HealthCheckResponse</h2>

<a id="schemahealthcheckresponse"></a>

```json
{
  "message": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|message|string|true|none|none|

<h2 id="tocSmerchant">Merchant</h2>

<a id="schemamerchant"></a>

```json
{
  "merchantId": "string",
  "businessName": "string",
  "displayName": "string",
  "email": "string",
  "statementDescriptor": "string",
  "businessTaxId": "string",
  "addressInformation": "string",
  "chargesEnabled": true,
  "payoutsEnabled": true,
  "payoutSchedule": "string",
  "tos_acceptance": true,
  "pricingTier": "string",
  "borrowerInformations": [
    {
      "borrowerInformation": "string"
    }
  ]
}

```

*Merchant information.*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|merchantId|string|false|none|none|
|businessName|string|false|none|none|
|displayName|string|false|none|none|
|email|string|false|none|none|
|statementDescriptor|string|false|none|none|
|businessTaxId|string|false|none|none|
|addressInformation|string|false|none|none|
|chargesEnabled|boolean|false|none|none|
|payoutsEnabled|boolean|false|none|none|
|payoutSchedule|string|false|none|none|
|tos_acceptance|boolean|false|none|none|
|pricingTier|string|false|none|none|
|borrowerInformations|[object]|false|none|none|
|» borrowerInformation|string|false|none|none|

<h2 id="tocSloanapplicationrequest">LoanApplicationRequest</h2>

<a id="schemaloanapplicationrequest"></a>

```json
{
  "transactionAmount": 1000,
  "mobileNumber": 1235554567,
  "loanPurpose": "landscape",
  "selectedFinancialProduct": "fully_amortizing_risk_based",
  "firstName": "Clark",
  "lastName": "Smith",
  "email": "casmith@example.com",
  "dob": -535420800000,
  "ssn4": 3333,
  "zip": 95602,
  "annualIncomeBeforeTaxes": 120000,
  "status": "initiated"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionAmount|string|false|none|Required for POST. Includes two decimal points but no dollar symbol.|
|mobileNumber|string|false|none|Required for POST. International phone numbers are supported. No formatting should be included. Just the digits.|
|loanPurpose|string|false|none|Required for POST. Currently this is freeform but will be enumerated in database in the future.|
|serviceCompletedOn|string|false|none|Required by POST. The date when the merchant completes the service.|
|callBackURL|string|false|none|Optional. URL to call on status change of transaction. See StatusUpdateRequest in the schema.|
|selectedFinancialProduct|string|false|none|The merchant can have one or more financial products from which to choose for each transaction.|
|firstName|string|false|none|none|
|lastName|string|false|none|none|
|email|string|false|none|none|
|dob|string|false|none|Format is YYYY-MM-DD. Please use the whole format as shown below in the example.|
|ssn4|string|false|none|none|
|ssn|string|false|none|none|
|streetAddress1|string|false|none|none|
|streetAddress2|string|false|none|none|
|city|string|false|none|none|
|stateCode|string|false|none|none|
|zip|string|false|none|Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.|
|authPin|string|false|none|none|
|employer|string|false|none|none|
|annualIncomeBeforeTaxes|string|false|none|Includes the decimal point but no dollar sign.|
|coborrowerMobileNumber|string|false|none|Coborrower mobile number. International phone numbers are supported. No formatted should be included. Just the digits.|
|escalateAuthentication|boolean|false|none|Set to true if the borrower should be challenged to enter a pin.|
|termsOfServiceAccepted|boolean|false|none|Set to true if the borrower accepted the terms of service agreement.|
|electronicDisclosuresAccepted|boolean|false|none|Set to true if the borrower accepted the electronic disclosure.|
|privacyPolicyAccepted|boolean|false|none|Set to true if the borrower accepted privacy policy.|
|transactionLineItems|[[LoanApplicationLineItems](#schemaloanapplicationlineitems)]|false|none|none|

<h2 id="tocSloanapplicationresponse">LoanApplicationResponse</h2>

<a id="schemaloanapplicationresponse"></a>

```json
{
  "loanApplicationId": "39f11e30-0b2c-499e-9180-0c2ed29ad11d",
  "initToken": "12AB7",
  "status": "OFFER_AVAILABLE"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|loanApplicationId|string|false|none|Unique UUID for transaction.|
|initToken|string|false|none|Internal use only.|
|status|string|false|none|See supported values in LoanApplicationStatus class.|
|selectedLoanOfferId|string|false|none|none|
|selectedLoanOfferStatus|string|false|none|See supported values in LoanOfferStatus class.|
|dataInquiryList|[any]|false|none|See supported values in the LoanApplicationDataInquiry class.|

<h2 id="tocSloanofferrequest">LoanOfferRequest</h2>

<a id="schemaloanofferrequest"></a>

```json
{
  "status": "SELECTED"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|provideTruthInLendingDocument|boolean|false|none|Indicates if TILA should be included in the response.|
|provideLoanAgreementDocument|boolean|false|none|Indicates if Loan Agreement should be included in the response.|
|provideCreditScoreDocument|boolean|false|none|Indicates if Credit Score Disclosure should be included in the response.|
|status|string|false|none|See LoanOfferStatus class for supported values.|
|truthInLendingDisclosureAccepted|boolean|false|none|Set to true if the borrower accepted the Truth In Lending disclosure.|
|loanAgreementAccepted|boolean|false|none|Set to true if the borrower accepted the loan agreement.|
|creditScoreDisclosureAccepted|boolean|false|none|Set to true if the borrower accepted the credit score disclosure.|

<h2 id="tocSloanofferresponse">LoanOfferResponse</h2>

<a id="schemaloanofferresponse"></a>

```json
{
  "loanApplicationId": "string",
  "loanOfferDetailsList": [
    {
      "id": "string",
      "loanAmount": "string",
      "loanTermMonths": 0,
      "interestRate": 0,
      "monthlyPayment": 0,
      "numberOfPayments": 0,
      "firstPaymentDue": "string",
      "totalInterest": 0,
      "totalPayments": 0,
      "totalFinancialCharges": 0,
      "status": "string",
      "truthInLending": "string",
      "loanAgreement": "string",
      "creditScoreDisclosure": "string"
    }
  ],
  "loanAdversActionsList": [
    {
      "rank": "string",
      "text": "string"
    }
  ]
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|loanApplicationId|string|false|none|none|
|loanOfferDetailsList|[[LoanOfferDetails](#schemaloanofferdetails)]|false|none|none|
|loanAdversActionsList|[[LoanAdverseActions](#schemaloanadverseactions)]|false|none|none|

<h2 id="tocSloanadverseactions">LoanAdverseActions</h2>

<a id="schemaloanadverseactions"></a>

```json
{
  "rank": "string",
  "text": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|rank|string|false|none|none|
|text|string|false|none|none|

<h2 id="tocSloanofferdetails">LoanOfferDetails</h2>

<a id="schemaloanofferdetails"></a>

```json
{
  "id": "string",
  "loanAmount": "string",
  "loanTermMonths": 0,
  "interestRate": 0,
  "monthlyPayment": 0,
  "numberOfPayments": 0,
  "firstPaymentDue": "string",
  "totalInterest": 0,
  "totalPayments": 0,
  "totalFinancialCharges": 0,
  "status": "string",
  "truthInLending": "string",
  "loanAgreement": "string",
  "creditScoreDisclosure": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|id|string|false|none|none|
|loanAmount|string|false|none|none|
|loanTermMonths|integer|false|none|none|
|interestRate|number|false|none|none|
|monthlyPayment|number|false|none|none|
|numberOfPayments|integer|false|none|none|
|firstPaymentDue|string|false|none|none|
|totalInterest|number|false|none|none|
|totalPayments|number|false|none|none|
|totalFinancialCharges|number|false|none|none|
|status|string|false|none|See LoanOfferStatus calss for supported values.|
|truthInLending|string|false|none|none|
|loanAgreement|string|false|none|none|
|creditScoreDisclosure|string|false|none|none|

<h2 id="tocSpaymentaccountrequest">PaymentAccountRequest</h2>

<a id="schemapaymentaccountrequest"></a>

```json
{
  "plaidToken": "access-sandbox-5cd6e1b1-1b5b-459d-9284-366e2da89755"
}

```

*Account to associate with a loan.*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|plaidToken|string|false|none|Plaid token gathered from user interaction with embedded Plaid sign in. If no account is attached, send 'notAttached' as token value.|
|paymentAuthorizationAccepted|boolean|false|none|Set to true if the borrower enabled bank payments by linking a bank account.|

<h2 id="tocSpaymentaccountresponse">PaymentAccountResponse</h2>

<a id="schemapaymentaccountresponse"></a>

```json
{
  "status": "plaidTokenAccepted"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|status|string|false|none|none|

<h2 id="tocSmerchantpostresponse">MerchantPostResponse</h2>

<a id="schemamerchantpostresponse"></a>

```json
{
  "merchantResourceURL": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|merchantResourceURL|string|false|none|none|

<h2 id="tocSmerchantloginrequest">MerchantLoginRequest</h2>

<a id="schemamerchantloginrequest"></a>

```json
{
  "username": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|username|string|true|none|merchant user email or phone number|

<h2 id="tocSmerchantloginresponse">MerchantLoginResponse</h2>

<a id="schemamerchantloginresponse"></a>

```json
{
  "responseBody": {
    "success": true,
    "message": "string",
    "code": "string"
  },
  "statusCode": "string"
}

```

*this response returned if no errors found, in case of error see 'Error' schema*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|responseBody|object|false|none|none|
|» success|boolean|false|none|result of login, should be true|
|» message|string|false|none|message on login, in case of successful login should be 'Verification code sent!'|
|» code|string|false|none|merchant user verification code (returned only if test phone/email specified in request)|
|statusCode|string|false|none|response status code, should be 200 if case of success login|

<h2 id="tocSmerchantauthrequest">MerchantAuthRequest</h2>

<a id="schemamerchantauthrequest"></a>

```json
{
  "code": "string",
  "username": "string",
  "token": "string"
}

```

*this request used for merchant user authentication if code specified and for JWT token refresh if 'token' parameter specified*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|code|string|false|none|merchant user verification code, sent previously to user in SMS or email|
|username|string|false|none|merchant user email or phone number, required parameter in case of authentication, but not for JWT token refresh|
|token|string|false|none|merchant user JWT to refresh (code should not be specified in the case of token refresh)|

<h2 id="tocSmerchantauthresponse">MerchantAuthResponse</h2>

<a id="schemamerchantauthresponse"></a>

```json
{
  "responseBody": {
    "success": true,
    "token": "string",
    "merchant": {
      "id": "string",
      "name": "string"
    },
    "user": {
      "userId": "string",
      "merchantId": "string"
    }
  },
  "statusCode": "string"
}

```

*this response returned if no errors found, in case of error see 'Error' schema*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|responseBody|object|false|none|none|
|» success|boolean|false|none|result of auth, should be true|
|» token|string|false|none|JWT token to be used in further merchant user requests|
|» merchant|object|false|none|merchant data, this property will not be returned in case of token refresh|
|»» id|string|false|none|merchant ID|
|»» name|string|false|none|merchant name|
|» user|object|false|none|user data, this property will not be returned in case of token refresh|
|»» userId|string|false|none|merchant user ID|
|»» merchantId|string|false|none|merchant ID|
|» statusCode|string|false|none|response status code, should be 200 in case of success auth|

<h2 id="tocSmerchantpatchresponse">MerchantPatchResponse</h2>

<a id="schemamerchantpatchresponse"></a>

```json
{
  "responseBody": {
    "merchantId": "string",
    "businessName": "string",
    "displayName": "string",
    "email": "string",
    "statementDescriptor": "string",
    "businessTaxId": "string",
    "addressInformation": "string",
    "chargesEnabled": true,
    "payoutsEnabled": true,
    "payoutSchedule": "string",
    "tos_acceptance": true,
    "pricingTier": "string",
    "borrowerInformations": [
      {
        "borrowerInformation": "string"
      }
    ]
  },
  "statusCode": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|responseBody|[Merchant](#schemamerchant)|false|none|Merchant information.|
|statusCode|string|false|none|response status code, should be 200 in case of success|

<h2 id="tocSmerchantdeleteresponse">MerchantDeleteResponse</h2>

<a id="schemamerchantdeleteresponse"></a>

```json
{
  "responseBody": {
    "merchantId": "string",
    "deleted": true
  },
  "statusCode": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|responseBody|object|false|none|none|
|» merchantId|string|false|none|none|
|» deleted|boolean|false|none|none|
|statusCode|string|false|none|response status code, should be 200 in case of success|

<h2 id="tocSmerchantuser">MerchantUser</h2>

<a id="schemamerchantuser"></a>

```json
{}

```

### Properties

*None*

<h2 id="tocSmerchantuserpostresponse">MerchantUserPostResponse</h2>

<a id="schemamerchantuserpostresponse"></a>

```json
{}

```

### Properties

*None*

<h2 id="tocSmerchantuserpatchresponse">MerchantUserPatchResponse</h2>

<a id="schemamerchantuserpatchresponse"></a>

```json
{
  "responseBody": {},
  "statusCode": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|responseBody|[MerchantUser](#schemamerchantuser)|false|none|none|
|statusCode|string|false|none|response status code, should be 200 in case of success|

<h2 id="tocSmerchantusergetresponse">MerchantUserGetResponse</h2>

<a id="schemamerchantusergetresponse"></a>

```json
{}

```

### Properties

*None*

<h2 id="tocSmerchantuserdeleteresponse">MerchantUserDeleteResponse</h2>

<a id="schemamerchantuserdeleteresponse"></a>

```json
{}

```

### Properties

*None*

