# AuthKit

A package for making authenticated REST API calls from Salesforce back to the same org, using JWT Bearer authentication.

## Features

- Make REST API calls to your own org from Apex
- Secure JWT Bearer OAuth 2.0 authentication
- Simple installation with minimal manual setup
- Utility class with helper methods for common API operations

## Installation

1. Deploy the package using SFDX:

```bash
sfdx force:source:deploy -p force-app
```

2. Configure the Remote Site Setting:

The Remote Site Setting will be deployed, but you may need to update the URL to match your org's instance. Navigate to Setup > Remote Site Settings > AuthKit and update the URL if needed.

3. Configure the Connected App:

After deployment, the Connected App will be created with the name "AuthKit". You'll need to:
- Navigate to Setup > App Manager > AuthKit
- Copy the Consumer Key (Client ID)
- Update the External Credential to use this Consumer Key:
  - Navigate to Setup > Named Credentials > External Credentials > AuthKit
  - Edit the "iss" parameter to contain your Consumer Key

## Usage

Once configured, you can make callouts to your org using the AuthKitUtility class:

```apex
// Simple GET request
HttpResponse res = AuthKitUtility.get('/services/data/v59.0/sobjects/Account');

// Query for accounts
List<Account> accounts = AuthKitUtility.getAccounts();

// Create an account
String newAccountId = AuthKitUtility.createAccount('New Account From API');

// PATCH request to update a record
HttpResponse updateRes = AuthKitUtility.patch(
    '/services/data/v59.0/sobjects/Account/001xx000003DGb2AAG',
    '{"Name":"Updated Account"}'
);

// DELETE request
HttpResponse deleteRes = AuthKitUtility.del('/services/data/v59.0/sobjects/Account/001xx000003DGb2AAG');
```

## Custom endpoints

You can also call your custom Apex REST endpoints:

```apex
HttpResponse res = AuthKitUtility.get('/services/apexrest/YourCustomEndpoint');
```

## Components

The package includes:

1. **Self-Signed Certificate**: `AuthKit.crt`
2. **Connected App**: `AuthKit.connectedApp`
3. **Remote Site Setting**: `AuthKit.remoteSite`
4. **Named Credential**: `AuthKit.namedCredential`
5. **External Credential**: `AuthKit.externalCredential`
6. **Apex Utility Class**: `AuthKitUtility.cls`
7. **Apex Test Class**: `AuthKitTest.cls`

## Troubleshooting

If you encounter issues, check:

1. The Remote Site Setting is active and points to your org's instance URL
2. The Consumer Key from the Connected App is correctly copied to the External Credential
3. The Named Credential is correctly using the External Credential

## Security Considerations

- This package uses JWT Bearer authentication, which is secure and doesn't require storing passwords
- API access is limited to the permissions of the running user
- All communication is encrypted via HTTPS

## License

MIT
