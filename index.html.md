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

<h1 id="wisetack-api-default">Default</h1>

## CORS support

> Code samples

`OPTIONS /merchants`

Enable CORS by returning correct headers

<h3 id="cors-support-parameters">Parameters</h3>

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|limit|query|integer|false|Maximum number of merchants to return.|
|startingAfter|query|string|false|List only merchants who initiated their onboard after this date.|
|endingBefore|query|string|false|List only merchants who initiated their onboarding before this date.|
|transactionsEnabled|query|string|false|Return for currently enabled merchants, true or false.|

<h3 id="cors-support-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|

<aside class="warning">
To perform this operation, you must be authenticated by means of one of the following methods:
None
</aside>

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
  "transactionAmount": "string",
  "mobileNumber": "string",
  "loanPurpose": "string",
  "serviceCompletedOn": "string",
  "callBackURL": "string",
  "selectedFinancialProduct": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dob": "string",
  "ssn4": "string",
  "ssn": "string",
  "streetAddress1": "string",
  "streetAddress2": "string",
  "city": "string",
  "stateCode": "string",
  "zip": "string",
  "employer": "string",
  "annualIncomeBeforeTaxes": "string",
  "coborrowerMobileNumber": "string",
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
  "transactionId": "string",
  "changedStatus": "initiated",
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
  "loanPurpose": "string",
  "serviceCompletedOn": "string",
  "tilaAcceptedOn": "string",
  "createdAt": "string"
}
```

<h3 id="post-initiates-a-transaction-process.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[TransactionResponse](#schematransactionresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|None|

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
{
  "transactions": [
    {
      "id": "8519e81f",
      "date": "8/30",
      "name": "E. Bode",
      "amount": "$3,425.00",
      "status": "Initiated",
      "loanStatus": "OFFER_CONVERTED",
      "offerId": "ebd271c2-ebf1-4575-a56d-526256f9551a",
      "offerStatus": "CONVERTED",
      "loanPurpose": "string",
      "serviceCompletedOn": "2019-08-30 07:00:00+0000",
      "tilaAcceptedOn": "2019-08-30 15:26:37+0000",
      "createdAt": 1567178434626,
      "paymentId": "000000000000003#752fca11-3e7c-4b4e-91f3-629766be4422",
      "paymentCreatedOn": "2019-09-03 07:00:00+0000",
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
          "status": "Initiated"
        }
      ]
    }
  ]
}
```

<h3 id="get-returns-a-list-of-transactions-for-this-merchant.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantTransactionsResponse](#schemamerchanttransactionsresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|None|

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
  "transactions": [
    {
      "id": "8519e81f",
      "date": "8/30",
      "name": "E. Bode",
      "amount": "$3,425.00",
      "status": "Initiated",
      "loanStatus": "OFFER_CONVERTED",
      "offerId": "ebd271c2-ebf1-4575-a56d-526256f9551a",
      "offerStatus": "CONVERTED",
      "loanPurpose": "string",
      "serviceCompletedOn": "2019-08-30 07:00:00+0000",
      "tilaAcceptedOn": "2019-08-30 15:26:37+0000",
      "createdAt": 1567178434626,
      "paymentId": "000000000000003#752fca11-3e7c-4b4e-91f3-629766be4422",
      "paymentCreatedOn": "2019-09-03 07:00:00+0000",
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
          "status": "Initiated"
        }
      ]
    }
  ]
}
```

<h3 id="get-retrieves-information,-including-the-status,-on-a-specific-transaction.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantTransactionsResponse](#schemamerchanttransactionsresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|None|

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
|body|body|[PaymentLinkObject](#schemapaymentlinkobject)|false|none|

> Example responses

> 200 Response

```json
{
  "paymentLink": "http://business.wisetack.us/loanApplicationId=80349125-3b0c-4fd6-b2ef-568a4844321d",
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
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[PaymentLinkObject](#schemapaymentlinkobject)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|None|

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
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "companyLegalOperatingName": "string"
}
```

<h3 id="get-retrieves-merchant-information-based-on-merchant-id.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantGetResponse](#schemamerchantgetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|None|

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
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "companyLegalOperatingName": "string"
}
```

<h3 id="get-retrieves-a-list-of-merchants.-responses">Responses</h3>

|Status|Meaning|Description|Schema|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|Ok|[MerchantGetResponse](#schemamerchantgetresponse)|
|400|[Bad Request](https://tools.ietf.org/html/rfc7231#section-6.5.1)|Bad Request.|None|

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
  "changedStatus": "initiated",
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
  "loanPurpose": "string",
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
  "transactionAmount": "string",
  "mobileNumber": "string",
  "loanPurpose": "string",
  "serviceCompletedOn": "string",
  "callBackURL": "string",
  "selectedFinancialProduct": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dob": "string",
  "ssn4": "string",
  "ssn": "string",
  "streetAddress1": "string",
  "streetAddress2": "string",
  "city": "string",
  "stateCode": "string",
  "zip": "string",
  "employer": "string",
  "annualIncomeBeforeTaxes": "string",
  "coborrowerMobileNumber": "string",
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
|employer|string|false|none|none|
|annualIncomeBeforeTaxes|string|false|none|Includes the decimal point but no dollar sign.|
|coborrowerMobileNumber|string|false|none|Coborrower mobile number. International phone numbers are supported. No formatted should be included. Just the digits.|
|transactionLineItems|[[LoanApplicationLineItems](#schemaloanapplicationlineitems)]|false|none|none|

<h2 id="tocStransactionresponse">TransactionResponse</h2>

<a id="schematransactionresponse"></a>

```json
{
  "transactionId": "string",
  "changedStatus": "initiated",
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
  "loanPurpose": "string",
  "serviceCompletedOn": "string",
  "tilaAcceptedOn": "string",
  "createdAt": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionId|string|false|none|UUID uniquely identifying the transaction with changed status.|
|changedStatus|string|false|none|The new status of this loan application.|
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
|loanPurpose|string|false|none|Purpose of the loan as entered by merchant.|
|serviceCompletedOn|string|false|none|The date by which the service should be completed.|
|tilaAcceptedOn|string|false|none|The data the Truth In Lending document was accepted.|
|createdAt|string|false|none|The date the transaction was initiated.|

#### Enumerated Values

|Property|Value|
|---|---|
|changedStatus|initiated|
|changedStatus|authorized|
|changedStatus|confirmed|
|changedStatus|settled|
|changedStatus|refunded|
|changedStatus|declined|
|changedStatus|expired|

<h2 id="tocSpaymentlinkobject">PaymentLinkObject</h2>

<a id="schemapaymentlinkobject"></a>

```json
{
  "paymentLink": "http://business.wisetack.us/loanApplicationId=80349125-3b0c-4fd6-b2ef-568a4844321d",
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
  "merchantId": "string",
  "onboardingDate": "string",
  "transactionsEnabled": true,
  "companyLegalOperatingName": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|merchantId|string|false|none|A UUID unique to the newly created merchant.|
|onboardingDate|string|false|none|Date this merchant was initially onboarded in YYYY-MM-DD format.|
|transactionsEnabled|boolean|false|none|Indicates whether this merchant has been fully onboarded and can initiate transactions.|
|companyLegalOperatingName|string|false|none|none|

<h2 id="tocSstatusupdaterequest">StatusUpdateRequest</h2>

<a id="schemastatusupdaterequest"></a>

```json
{
  "transactionId": "string",
  "changedStatus": "initiated",
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
  "loanPurpose": "string",
  "serviceCompletedOn": "string",
  "tilaAcceptedOn": "string",
  "createdAt": "string"
}

```

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactionId|string|false|none|UUID uniquely identifying the transaction with changed status.|
|changedStatus|string|false|none|The new status of this loan application.|
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
|loanPurpose|string|false|none|Purpose of the loan as entered by merchant.|
|serviceCompletedOn|string|false|none|The date by which the service should be completed.|
|tilaAcceptedOn|string|false|none|The data the Truth In Lending document was accepted.|
|createdAt|string|false|none|The date the transaction was initiated.|

#### Enumerated Values

|Property|Value|
|---|---|
|changedStatus|initiated|
|changedStatus|authorized|
|changedStatus|confirmed|
|changedStatus|settled|
|changedStatus|refunded|
|changedStatus|declined|
|changedStatus|expired|

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
  "transactions": [
    {
      "id": "8519e81f",
      "date": "8/30",
      "name": "E. Bode",
      "amount": "$3,425.00",
      "status": "Initiated",
      "loanStatus": "OFFER_CONVERTED",
      "offerId": "ebd271c2-ebf1-4575-a56d-526256f9551a",
      "offerStatus": "CONVERTED",
      "loanPurpose": "string",
      "serviceCompletedOn": "2019-08-30 07:00:00+0000",
      "tilaAcceptedOn": "2019-08-30 15:26:37+0000",
      "createdAt": 1567178434626,
      "paymentId": "000000000000003#752fca11-3e7c-4b4e-91f3-629766be4422",
      "paymentCreatedOn": "2019-09-03 07:00:00+0000",
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
          "status": "Initiated"
        }
      ]
    }
  ]
}

```

*All known information about a transaction for a merchant.*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|transactions|[object]|false|none|none|
|» id|string|false|none|loan application short id|
|» date|string|false|none|transaction date|
|» name|string|false|none|consumer short name|
|» amount|string|false|none|transaction amount|
|» status|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|
|» loanStatus|string|false|none|loan internal status|
|» offerId|string|false|none|selected loan offer ID|
|» offerStatus|string|false|none|selected loan offer internal status|
|» loanPurpose|string|false|none|loan purpose|
|» serviceCompletedOn|string(date-time)|false|none|none|
|» tilaAcceptedOn|string(date-time)|false|none|none|
|» createdAt|integer|false|none|unix timestamp when transaction created|
|» paymentId|string|false|none|payment ID|
|» paymentCreatedOn|string(date-time)|false|none|payment creation date|
|» consumer|object|false|none|none|
|»» fullName|string|false|none|consumer full name|
|»» email|string|false|none|consumer email|
|»» phone|string|false|none|consumer phone|
|»» zip|string|false|none|consumer zip|
|» statusHistory|[object]|false|none|none|
|»» date|string|false|none|status set date|
|»» amount|string|false|none|transaction amount|
|»» status|[TransactionStatus](#schematransactionstatus)|false|none|transaction status to display in merchant UI|

<h2 id="tocStransactionstatus">TransactionStatus</h2>

<a id="schematransactionstatus"></a>

```json
"Initiated"

```

*transaction status to display in merchant UI*

### Properties

|Name|Type|Required|Restrictions|Description|
|---|---|---|---|---|
|*anonymous*|string|false|none|transaction status to display in merchant UI|

#### Enumerated Values

|Property|Value|
|---|---|
|*anonymous*|Initiated|
|*anonymous*|Loan confirmed|
|*anonymous*|Authorized|
|*anonymous*|Expired|
|*anonymous*|Rejected|
|*anonymous*|Declined|
|*anonymous*|Settled|

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

