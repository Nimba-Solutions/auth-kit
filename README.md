# auth-kit

AuthKit is an open source unlocked package for Salesforce that streamlines the management of authentication and credential configurations through Lightning Web Components and Apex. This toolkit simplifies the administration of NamedCredential, ExternalCredential, AuthProvider, and related metadata types, eliminating the need for repetitive configuration tasks.

Designed for Salesforce developers and administrators, AuthKit provides user-friendly UX, API, and CICD interfaces to create, manage, and deploy credential configurations across orgs. The package reduces implementation time for integrations by offering reusable components and standardized patterns for secure authentication management.

## Features

### Credential Configuration Automation
- **Simplified Workflow**: Generate all required credential metadata through a simple guided interface
- **Template-Based Generation**: Pre-configured templates for common authentication scenarios
- **Metadata Generation**: Automatically creates all required Connected Apps, Named Credentials, and External Credentials

### Credential Configuration Templates
- [**Loopback Authorization**](#loopback-authorization): Quickly set up the infrastructure needed for Apex code to call your org's REST API
- [**JWT Bearer Authorization**](#jwt-bearer-authorization): Pre-configured templates for JWT Bearer OAuth 2.0 flow
- [**AWS Signature v4**](#aws-signature-v4): Complete templates for AWS service authentication
- [**Basic Auth**](#basic-auth): Simple username/password authentication configuration
- [**OAuth 2.0 Client Credentials**](#oauth-20-client-credentials): Templates for server-to-server OAuth authentication
- [**OAuth Browser Flow**](#oauth-browser-flow): Interactive user authorization via web browser
- [**Custom API Key**](#custom-api-key): Configurable header or parameter-based API key authentication
- [**OAuth 2.0 Password Flow**](#oauth-20-password-flow): User context authentication templates (WIP)
- [**OAuth 2.0 Refresh Token Flow**](#oauth-20-refresh-token-flow): Long-lived authentication setup (WIP)

## Template Usage Examples

### Loopback Authorization

Configure authentication for your Apex code to call your own org's REST API:

```apex
// Create JWT Bearer configuration for self-org access
ExternalCredentialDTO selfOrgConfig = CredentialFactory.createOAuthJwtBearer(
    'SelfOrgAccess',
    'SelfSignedCert',
    'client_id_from_connected_app',
    '{!$User.Username}',
    'https://your-org-domain.my.salesforce.com',
    'api refresh_token',
    'https://your-org-domain.my.salesforce.com/services/oauth2/token'
);

// Deploy the configuration
Object result = CredentialService.upsertExternalCredential(selfOrgConfig);
```

### JWT Bearer Authorization

Configure JWT Bearer authorization for OAuth 2.0 authentication:

```apex
// Create JWT Bearer configuration
ExternalCredentialDTO jwtConfig = CredentialFactory.createOAuthJwtBearer(
    'JWTBearerAuth',
    'SigningCertName',
    'client_id',
    'user@example.com',
    'https://login.salesforce.com',
    'api refresh_token',
    'https://login.salesforce.com/services/oauth2/token'
);

// Deploy the configuration
Object result = CredentialService.upsertExternalCredential(jwtConfig);
```

### AWS Signature v4

Configure AWS Signature v4 authentication for AWS services:

```apex
// Create AWS SigV4 configuration
ExternalCredentialDTO awsConfig = CredentialFactory.createAwsSigV4(
    'AWSIntegration'
);

// Deploy the configuration
Object extResult = CredentialService.upsertExternalCredential(awsConfig);

// Configure the AWS credentials
CredentialDTO awsCredentials = CredentialFactory.createAwsAccessKeyCredential(
    'AWSIntegration',
    'AWS_ACCESS_KEY',
    'AWS_SECRET_KEY'
);

// Deploy the credentials
Object credResult = CredentialService.populateCredential(awsCredentials);
```

### Basic Auth

Configure Basic Authentication with username and password:

```apex
// Create Basic Auth credentials
CredentialDTO basicAuth = CredentialFactory.createBasicAuthCredential(
    'BasicAuthIntegration',
    'NamedPrincipal',
    'NamedPrincipal',
    'username',
    'password'
);

// Deploy the credentials
Object result = CredentialService.populateCredential(basicAuth);
```

### OAuth 2.0 Client Credentials

Configure OAuth 2.0 Client Credentials flow with JWT assertion:

```apex
// Create OAuth Client Credentials configuration
ExternalCredentialDTO clientCredConfig = CredentialFactory.createOAuthClientCredentialsJwtAssertion(
    'OAuthClientCred',
    'SigningCertName',
    'client_id',
    'subject',
    'https://example.com/token',
    'api',
    'https://example.com/oauth/token'
);

// Deploy the configuration
Object extResult = CredentialService.upsertExternalCredential(clientCredConfig);

// Configure the client ID
CredentialDTO clientCredentials = CredentialFactory.createClientIdCredential(
    'OAuthClientCred',
    'client_id_value'
);

// Deploy the credentials
Object credResult = CredentialService.populateCredential(clientCredentials);
```

### OAuth Browser Flow

Configure OAuth 2.0 authorization with browser flow:

```apex
// Create OAuth Browser Flow configuration
ExternalCredentialDTO browserFlowConfig = CredentialFactory.createOAuthBrowserFlow(
    'OAuthBrowserFlow',
    'MyAuthProvider',
    'api refresh_token'
);

// Deploy the configuration
Object result = CredentialService.upsertExternalCredential(browserFlowConfig);
```

### Custom API Key

Configure custom API key authentication:

```apex
// Setup the API key details
Map<String, String> apiKeyMap = new Map<String, String>{
    'x-api-key' => 'your_api_key_here'
};

// Mark sensitive fields for encryption
Set<String> encryptedFields = new Set<String>{'x-api-key'};

// Create the custom API key credential
CredentialDTO apiKeyConfig = CredentialFactory.createCustomCredential(
    'APIKeyAuth',
    'NamedPrincipal',
    'NamedPrincipal',
    apiKeyMap,
    encryptedFields
);

// Deploy the credential
Object result = CredentialService.populateCredential(apiKeyConfig);
```

### OAuth 2.0 Password Flow

*WIP: This template is currently under development.*

### OAuth 2.0 Refresh Token Flow

*WIP: This template is currently under development.*

## Contributing

### To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Run `cci flow run dev_org --org dev` to deploy this project.
3. Run `cci org browser dev` to open the org in your browser.

### To contribute to on this project on github:

1. Prepare your changes in a `feature/*` branch
2. Submit a Pull Request to the `main` branch


## Credit

This project was partially inspired by [this excellent gist](./.docs/Populating%20Credentials%20with%20the%20Connect%20API.md) by GitHub user [rossbelmont](https://gist.github.com/rossbelmont).

