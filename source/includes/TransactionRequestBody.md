<a name="transaction-request-body"</a>
# TransactionRequestBody
```json
transactionAmount	string
Required for POST. Includes two decimal points but no dollar symbol.

mobileNumber	string
Required for POST. International phone numbers are supported. No formatted should be included. Just the digits.

loanPurpose	string
Required for POST. Currently this is freeform but will be enumerated in database in the future.

firstName	string
optional

lastName	string
optional

email	string
optional

dob	string
Optional. Format is YYYY-MM-DD. Please use the whole format as shown below in the example.

ssn4	string
ssn	string
optional

streetAddress1	string
optional

streetAddress2	string
optional

city	string
optional

stateCode	string
optional

zip	string
Optional. Zip code can be either the full nine digits (nnnnn-mmmm) or just the five digit delivery area.

employer	string
optional

annualIncomeBeforeTaxes	string
Optional. Includes the decimal point but no dollar sign.

coborrowerMobileNumber	string
Optional. Coborrower mobile number. International phone numbers are supported. No formatted should be included. Just the digits.

transactionLineItems	[...]
}
```

