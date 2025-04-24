/**
 * @description Example usage of the CredentialService classes
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
        
        // Convert to JSON and send to the Connect API
        String jsonConfig = externalCredModel.toJson();
        HttpResponse response = CredentialService.upsertExternalCredential(
            'OAuthBrowserFlowExternalCredential',
            jsonConfig
        );
        
        System.debug('Response status: ' + response.getStatusCode());
        System.debug('Response body: ' + response.getBody());
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
        
        // Convert to JSON and send to the Connect API
        String jsonConfig = externalCredModel.toJson();
        HttpResponse response = CredentialService.upsertExternalCredential(
            'OAuthJwtBearerExternalCredential',
            jsonConfig
        );
        
        System.debug('Response status: ' + response.getStatusCode());
        System.debug('Response body: ' + response.getBody());
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
        
        String jsonConfig = externalCredModel.toJson();
        HttpResponse response = CredentialService.upsertExternalCredential(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            jsonConfig
        );
        
        System.debug('External Credential Response status: ' + response.getStatusCode());
        
        // Then populate the client ID
        CredentialModel credModel = CredentialFactory.createClientIdCredential(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            'your-client-id'
        );
        
        String credJson = credModel.toJson();
        HttpResponse credResponse = CredentialService.populateCredential(credJson);
        
        System.debug('Credential Response status: ' + credResponse.getStatusCode());
        System.debug('Credential Response body: ' + credResponse.getBody());
    }
    
    /**
     * @description Example of creating an AWS SigV4 credential
     */
    public static void createAwsSigV4Example() {
        // First create or update the External Credential
        ExternalCredentialModel externalCredModel = CredentialFactory.createAwsSigV4('AwsSv4ExternalCredential');
        
        String jsonConfig = externalCredModel.toJson();
        HttpResponse response = CredentialService.upsertExternalCredential(
            'AwsSv4ExternalCredential',
            jsonConfig
        );
        
        System.debug('External Credential Response status: ' + response.getStatusCode());
        
        // Then populate the credentials
        CredentialModel credModel = CredentialFactory.createAwsAccessKeyCredential(
            'AwsSv4ExternalCredential',
            'accessKey',
            'accessSecret'
        );
        
        String credJson = credModel.toJson();
        HttpResponse credResponse = CredentialService.populateCredential(credJson);
        
        System.debug('Credential Response status: ' + credResponse.getStatusCode());
        System.debug('Credential Response body: ' + credResponse.getBody());
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
        
        String credJson = credModel.toJson();
        HttpResponse credResponse = CredentialService.populateCredential(credJson);
        
        System.debug('Response status: ' + credResponse.getStatusCode());
        System.debug('Response body: ' + credResponse.getBody());
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
        
        String credJson = credModel.toJson();
        HttpResponse credResponse = CredentialService.populateCredential(credJson);
        
        System.debug('Response status: ' + credResponse.getStatusCode());
        System.debug('Response body: ' + credResponse.getBody());
    }
} 