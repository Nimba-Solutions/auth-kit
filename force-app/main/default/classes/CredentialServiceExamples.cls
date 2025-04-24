/**
 * @description Example usage of the CredentialService classes with DTOs
 * These methods demonstrate how to use the Apex service layer for the Connect API
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialServiceExamples {
    
    /**
     * @description Example of creating an OAuth Browser Flow External Credential
     */
    public static void createOAuthBrowserFlowExample() {
        // Create the External Credential DTO
        ExternalCredentialDTO dto = CredentialFactory.createOAuthBrowserFlow(
            'OAuthBrowserFlowExternalCredential',
            'authProvider',
            'some_access'
        );
        
        // Call the service with the DTO
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(dto);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating an OAuth JWT Bearer Flow External Credential
     */
    public static void createOAuthJwtBearerExample() {
        // Create the External Credential DTO
        ExternalCredentialDTO dto = CredentialFactory.createOAuthJwtBearer(
            'OAuthJwtBearerExternalCredential',
            'yourCert',
            'iss',
            'sub',
            'aud',
            'some_access',
            'https://something.com/oauth/idp'
        );
        
        // Call the service with the DTO
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(dto);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating an OAuth Client Credentials with JWT Assertion
     */
    public static void createOAuthClientCredentialsJwtAssertionExample() {
        // First create or update the External Credential
        ExternalCredentialDTO dto = CredentialFactory.createOAuthClientCredentialsJwtAssertion(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            'yourCert',
            'iss',
            'sub',
            'aud',
            'some_access',
            'https://something.com/oauth/client-credentials'
        );
        
        // Call the service with the DTO
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(dto);
        
        System.debug('External Credential Response: ' + response);
        
        // Then populate the client ID
        CredentialDTO credDto = CredentialFactory.createClientIdCredential(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            'your-client-id'
        );
        
        ConnectApi.CredentialRepresentation credResponse = CredentialService.populateCredential(credDto);
        
        System.debug('Credential Response: ' + credResponse);
    }
    
    /**
     * @description Example of creating an AWS SigV4 credential
     */
    public static void createAwsSigV4Example() {
        // First create or update the External Credential
        ExternalCredentialDTO dto = CredentialFactory.createAwsSigV4('AwsSv4ExternalCredential');
        
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredential(dto);
        
        System.debug('External Credential Response: ' + response);
        
        // Then populate the credentials
        CredentialDTO credDto = CredentialFactory.createAwsAccessKeyCredential(
            'AwsSv4ExternalCredential',
            'accessKey',
            'accessSecret'
        );
        
        ConnectApi.CredentialRepresentation credResponse = CredentialService.populateCredential(credDto);
        
        System.debug('Credential Response: ' + credResponse);
    }
    
    /**
     * @description Example of creating a Basic Authentication credential
     */
    public static void createBasicAuthExample() {
        CredentialDTO dto = CredentialFactory.createBasicAuthCredential(
            'BasicExternalCredential',
            'NamedPrincipal',
            'NamedPrincipal',
            'you@example.com',
            'test1234'
        );
        
        ConnectApi.CredentialRepresentation response = CredentialService.populateCredential(dto);
        
        System.debug('Response: ' + response);
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
        
        CredentialDTO dto = CredentialFactory.createCustomCredential(
            'CustomExternalCredential',
            'NamedPrincipal',
            'NamedPrincipal',
            credMap,
            encryptedFields
        );
        
        ConnectApi.CredentialRepresentation response = CredentialService.populateCredential(dto);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating an External Credential from JSON
     */
    public static void createExternalCredentialFromJsonExample() {
        // This could come from a custom metadata type, static resource, or other source
        String jsonConfig = '{"developerName":"JsonExternalCredential","masterLabel":"JSON Example","authenticationProtocol":"OAuth","parameters":[{"parameterName":"AuthProvider","parameterType":"AuthProvider","parameterValue":"authProvider"},{"parameterName":"Scope","parameterType":"AuthParameter","parameterValue":"some_access"}],"principals":[{"principalName":"NamedPrincipal","principalType":"NamedPrincipal","sequenceNumber":1}]}';
        
        // Directly deserialize and use the JSON
        ConnectApi.ExternalCredentialRepresentation response = CredentialService.upsertExternalCredentialFromJson(jsonConfig);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating a Credential from JSON
     */
    public static void createCredentialFromJsonExample() {
        // This could come from a secure external system or vault
        String jsonConfig = '{"externalCredential":"JsonExternalCredential","principalName":"NamedPrincipal","principalType":"NamedPrincipal","credentials":{"apiKey":{"value":"your-api-key","encrypted":true}}}';
        
        // Directly deserialize and use the JSON
        ConnectApi.CredentialRepresentation response = CredentialService.populateCredentialFromJson(jsonConfig);
        
        System.debug('Response: ' + response);
    }
} 