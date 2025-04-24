[Original Gist](https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755)

# Populating Credentials with the Connect API

## Introduction and Purpose

The purpose of this unofficial document to illuminate how developers and skilled system administrators can achieve a high level of automation when deploying Named Credentials to one or more Salesforce orgs by combining packaging with Connect API methods designed to support this use case. 

The expanded Connect API is needed to reach this goal because the current state of the Metadata API and packaging do not support moving shared secrets or sensitive values like API keys between orgs. Doing so would necessitate retrieving the secret value from the org in clear text before deploying it to the target org; this is not workable from a security and trust point of view.

So although packaging is unlikely to address this completely, it can be _part_ of the solution. Customers can package a Named Credential and External Credential and deploy them to one or more orgs, then use the Connect API in a minimal way to populate the sensitive values.

The rest of this document includes samples for each authentication protocol using the REST API. Essentially, **this document shows how to automate what you cannot package**. The anticipated pattern is that commands similar to these would be woven into a CI/CD toolchain.

## Samples

### OAuth

#### Browser Flow

ExternalCredential `PUT` to add AuthProvider

```
curl -X PUT https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/external-credentials/OAuthBrowserFlowExternalCredential -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@ec.json"
```

File contents: ec.json

```
{
    "developerName": "OAuthBrowserFlowExternalCredential",
    "masterLabel": "OAuthBrowserFlowExternalCredential",
    "authenticationProtocol": "OAuth",
    "parameters": [
        {
            "parameterName": "AuthProvider",
            "parameterType": "AuthProvider",
            "parameterValue": "authProvider"
        },
        {
            "parameterName": "Scope",
            "parameterType": "AuthParameter",
            "parameterValue": "some_access"
        }
    ],
    "principals": [
        {
            "principalName": "NamedPrincipal",
            "principalType": "NamedPrincipal",
            "sequenceNumber": 1
        },
        {
            "principalName": "PerUserPrincipal",
            "principalType": "PerUserPrincipal",
            "sequenceNumber": 2
        }
    ]
}
```

#### JWT Bearer Flow

ExternalCredential `PUT` to add SigningCertificate

```
curl -X PUT https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/external-credentials/OAuthJwtBearerExternalCredential -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@ec.json"
```

File contents: ec.json 

```
{
    "developerName": "OAuthJwtBearerExternalCredential",
    "masterLabel": "OAuthJwtBearerExternalCredential",
    "authenticationProtocol": "OAuth",
    "authenticationProtocolVariant": "JwtBearer",
    "parameters": [
        {
            "parameterName": "SigningCertificate",
            "parameterType": "SigningCertificate",
            "parameterValue": "yourCert"
        },
        {
            "parameterName": "iss",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "iss"
        },
        {
            "parameterName": "sub",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "sub"
        },
        {
            "parameterName": "aud",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "aud"
        },
        {
            "parameterName": "Scope",
            "parameterType": "AuthParameter",
            "parameterValue": "some_access"
        },
        {
            "parameterName": "Identity Provider URL",
            "parameterType": "AuthProviderUrl",
            "parameterValue": "https://something.com/oauth/idp"
        }
    ],
    "principals": [
        {
            "principalName": "NamedPrincipal",
            "principalType": "NamedPrincipal",
            "sequenceNumber": 1
        },
        {
            "principalName": "PerUserPrincipal",
            "principalType": "PerUserPrincipal",
            "sequenceNumber": 2
        }
    ]
}
```

#### Client Credentials with JWT Assertion 

ExternalCredential `PUT` to add SigningCertificate and Credential POST for Client ID

```
curl -X PUT https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/external-credentials/OAuthClientCredentialsJwtAssertionExternalCredential -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@ec.json"
```

File contents: ec.json 

```
{
"developerName": "OAuthClientCredentialsJwtAssertionExternalCredential",
    "masterLabel": "OAuthClientCredentialsJwtAssertionExternalCredential",
    "authenticationProtocol": "OAuth",
    "authenticationProtocolVariant": "ClientCredentialsJwtAssertion",
    "parameters": [
        {
            "parameterName": "Scope",
            "parameterType": "AuthParameter",
            "parameterValue": "some_access"
        },
        {
            "parameterName": "Identity Provider URL",
            "parameterType": "AuthProviderUrl",
            "parameterValue": "https://something.com/oauth/client-credentials"
        },
        {
            "parameterName": "SigningCertificate",
            "parameterType": "SigningCertificate",
            "parameterValue": "yourCert"
        },
        {
            "parameterName": "iss",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "iss"
        },
        {
            "parameterName": "sub",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "sub"
        },
        {
            "parameterName": "aud",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "aud"
        }
    ],
    "principals": [
        {
            "principalName": "NamedPrincipal",
            "principalType": "NamedPrincipal",
            "sequenceNumber": 1
        }
    ]
}
```

Additional command to populate Client ID

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "OAuthClientCredentialsJwtAssertionExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "clientId": {
            "value": "your-client-id",
            "encrypted": false
        }
    }
}
```

#### Client Credentials with Client Secret

Credential `POST` for Client ID and Secret

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "OAuthClientCredentialsClientSecretExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "clientId": {
            "value": "your-client-id",
            "encrypted": false
        },
        "clientSecret": {
            "value": "your-client-secret",
            "encrypted": true
        }
    }
}
```

### AWS SigV4

#### Access Key and Secret

Credential `POST` for Access Key and Secret

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "AwsSv4ExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "awsAccessKeyId": {
            "value": "accessKey",
            "encrypted": false
        },
        "awsSecretAccessKey": {
            "value": "acessSecret",
            "encrypted": true
        }
    }
}
```

#### STS

Credential `POST` for STS Principal 

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "AwsSv4StsExternalCredential",
    "principalName": "AwsStsPrincipal",
    "principalType": "AwsStsPrincipal",
    "credentials": {
        "awsAccessKeyId": {
            "value": "accessKeyHere",
            "encrypted": false
        },
        "awsSecretAccessKey": {
            "value": "accessSecretHere",
            "encrypted": true
        }
    }
}
```

Credential `POST` for Role ARN 

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "AwsSv4StsExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "awsRoleArn": {
            "value": "arn:aws:iam::1234567890:yourRole/",
            "encrypted": false
        }
    }
}
```


#### STS with Roles Anywhere

Credential `POST` for Role ARN

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "AwsSv4StsRolesAnywhereExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "awsRoleArn": {
            "value": "arn:aws:iam::1234567890:yourRole/",
            "encrypted": false
        }
    }
}
```

> **Note**: with this variant, a certificate is used instead of a key & secret.

### Custom

ExternalCredential `POST` for custom user specified credentials (e.g. API Key)

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "CustomExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "customCredentialName": {
            "value": "customCredentialValue",
            "encrypted": false
        },
        "yourApiKeyHeaderNameHere": {
            "value": "yourApiKeyValueHere",
            "encrypted": true
        }
    }
}
```


### JWT

ExternalCredential `PUT` to add signing certificate

```
curl -X PUT https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/external-credentials/JwtExternalCredential -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@ec.json"
```

File contents: ec.json 

```
{
    "developerName": "JwtExternalCredential",
    "masterLabel": "JwtExternalCredential",
    "authenticationProtocol": "Jwt",
    "parameters": [
        {
            "parameterName": "SigningCertificate",
            "parameterType": "SigningCertificate",
            "parameterValue": "yourCert"
        },
        {
            "parameterName": "iss",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "iss"
        },
        {
            "parameterName": "sub",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "sub"
        },
        {
            "parameterName": "aud",
            "parameterType": "JwtBodyClaim",
            "parameterValue": "echo"
        }
    ],
    "principals": [
        {
            "principalName": "NamedPrincipal",
            "principalType": "NamedPrincipal",
            "sequenceNumber": 1
        },
        {
            "principalName": "PerUserPrincipal",
            "principalType": "PerUserPrincipal",
            "sequenceNumber": 2
        }
    ]
}
```

### Basic Authentication

ExternalCredential `POST` for Named Principal Username/Password

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "BasicExternalCredential",
    "principalName": "NamedPrincipal",
    "principalType": "NamedPrincipal",
    "credentials": {
        "username": {
            "value": "you@example.com",
            "encrypted": false
        },
        "password": {
            "value": "test1234",
            "encrypted": true
        }
    }
}
```

ExternalCredential `POST` for Per-User Principal Username/Password

```
curl -X POST https://MyDomainName.my.salesforce.com/services/data/v60.0/named-credentials/credential/ -H "Authorization: Bearer token" -H "Content-Type: application/json" -d "@credentials.json"
```

File contents: credentials.json

```
{
    "externalCredential": "BasicExternalCredential",
    "principalName": "PerUserPrincipal",
    "principalType": "PerUserPrincipal",
    "credentials": {
        "username": {
            "value": "you@example.com",
            "encrypted": false
        },
        "password": {
            "value": "test1234",
            "encrypted": true
        }
    }
}
```