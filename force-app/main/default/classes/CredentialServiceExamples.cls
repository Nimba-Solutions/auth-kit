/**
 * @description Example usage of the CredentialService classes with ConnectApi
 * These methods demonstrate how to use the Apex service layer for the Connect API
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialServiceExamples {
    
    /**
     * @description Example of creating an OAuth Browser Flow External Credential
     */
    public static void createOAuthBrowserFlowExample() {
        // Create the External Credential model
        ExternalCredentialModel externalCredModel = CredentialFactory.createOAuthBrowserFlow(
            'OAuthBrowserFlowExternalCredential',
            'authProvider',
            'some_access'
        );
        
        // Build the ConnectApi input and call the service
        ConnectApi.ExternalCredentialInput input = externalCredModel.build();
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(input);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating an OAuth JWT Bearer Flow External Credential
     */
    public static void createOAuthJwtBearerExample() {
        // Create the External Credential model
        ExternalCredentialModel externalCredModel = CredentialFactory.createOAuthJwtBearer(
            'OAuthJwtBearerExternalCredential',
            'yourCert',
            'iss',
            'sub',
            'aud',
            'some_access',
            'https://something.com/oauth/idp'
        );
        
        // Build the ConnectApi input and call the service
        ConnectApi.ExternalCredentialInput input = externalCredModel.build();
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(input);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating an OAuth Client Credentials with JWT Assertion
     */
    public static void createOAuthClientCredentialsJwtAssertionExample() {
        // First create or update the External Credential
        ExternalCredentialModel externalCredModel = CredentialFactory.createOAuthClientCredentialsJwtAssertion(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            'yourCert',
            'iss',
            'sub',
            'aud',
            'some_access',
            'https://something.com/oauth/client-credentials'
        );
        
        // Build the ConnectApi input and call the service
        ConnectApi.ExternalCredentialInput input = externalCredModel.build();
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(input);
        
        System.debug('External Credential Response: ' + response);
        
        // Then populate the client ID
        CredentialModel credModel = CredentialFactory.createClientIdCredential(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            'your-client-id'
        );
        
        ConnectApi.CredentialInput credInput = credModel.build();
        ConnectApi.CredentialRepresentation credResponse = CredentialService.populateCredential(credInput);
        
        System.debug('Credential Response: ' + credResponse);
    }
    
    /**
     * @description Example of creating an AWS SigV4 credential
     */
    public static void createAwsSigV4Example() {
        // First create or update the External Credential
        ExternalCredentialModel externalCredModel = CredentialFactory.createAwsSigV4('AwsSv4ExternalCredential');
        
        ConnectApi.ExternalCredentialInput input = externalCredModel.build();
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(input);
        
        System.debug('External Credential Response: ' + response);
        
        // Then populate the credentials
        CredentialModel credModel = CredentialFactory.createAwsAccessKeyCredential(
            'AwsSv4ExternalCredential',
            'accessKey',
            'accessSecret'
        );
        
        ConnectApi.CredentialInput credInput = credModel.build();
        ConnectApi.CredentialRepresentation credResponse = CredentialService.populateCredential(credInput);
        
        System.debug('Credential Response: ' + credResponse);
    }
    
    /**
     * @description Example of creating a Basic Authentication credential
     */
    public static void createBasicAuthExample() {
        CredentialModel credModel = CredentialFactory.createBasicAuthCredential(
            'BasicExternalCredential',
            'NamedPrincipal',
            'NamedPrincipal',
            'you@example.com',
            'test1234'
        );
        
        ConnectApi.CredentialInput credInput = credModel.build();
        ConnectApi.CredentialRepresentation credResponse = CredentialService.populateCredential(credInput);
        
        System.debug('Response: ' + credResponse);
    }
    
    /**
     * @description Example of creating a custom API Key credential
     */
    public static void createCustomApiKeyExample() {
        Map<String, String> credMap = new Map<String, String>{
            'customCredentialName' => 'customCredentialValue',
            'yourApiKeyHeaderNameHere' => 'yourApiKeyValueHere'
        };
        
        Set<String> encryptedFields = new Set<String>{'yourApiKeyHeaderNameHere'};
        
        CredentialModel credModel = CredentialFactory.createCustomCredential(
            'CustomExternalCredential',
            'NamedPrincipal',
            'NamedPrincipal',
            credMap,
            encryptedFields
        );
        
        ConnectApi.CredentialInput credInput = credModel.build();
        ConnectApi.CredentialRepresentation credResponse = CredentialService.populateCredential(credInput);
        
        System.debug('Response: ' + credResponse);
    }
} 