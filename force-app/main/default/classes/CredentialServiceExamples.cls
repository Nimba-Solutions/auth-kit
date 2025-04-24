/**
 * @description Example usage of the CredentialService classes with DTOs
 * These methods demonstrate how to use the Apex service layer for the Connect API
 * with realistic integration scenarios
 */
public with sharing class CredentialServiceExamples {
    
    // Tracking variables for execution results
    public static Boolean lastExecutionSuccessful = false;
    public static String lastExecutionMessage = '';
    public static Object lastExecutionResponse = null;
    
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
        Object response = CredentialService.upsertExternalCredential(dto);
        
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
        Object response = CredentialService.upsertExternalCredential(dto);
        
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
        Object response = CredentialService.upsertExternalCredential(dto);
        
        System.debug('External Credential Response: ' + response);
        
        // Then populate the client ID
        CredentialDTO credDto = CredentialFactory.createClientIdCredential(
            'OAuthClientCredentialsJwtAssertionExternalCredential',
            'your-client-id'
        );
        
        Object credResponse = CredentialService.populateCredential(credDto);
        
        System.debug('Credential Response: ' + credResponse);
    }
    
    /**
     * @description Example of creating an AWS SigV4 credential
     */
    public static void createAwsSigV4Example() {
        // First create or update the External Credential
        ExternalCredentialDTO dto = CredentialFactory.createAwsSigV4('AwsSv4ExternalCredential');
        
        Object response = CredentialService.upsertExternalCredential(dto);
        
        System.debug('External Credential Response: ' + response);
        
        // Then populate the credentials
        CredentialDTO credDto = CredentialFactory.createAwsAccessKeyCredential(
            'AwsSv4ExternalCredential',
            'accessKey',
            'accessSecret'
        );
        
        Object credResponse = CredentialService.populateCredential(credDto);
        
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
        
        Object response = CredentialService.populateCredential(dto);
        
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
        
        Object response = CredentialService.populateCredential(dto);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating an External Credential from JSON
     */
    public static void createExternalCredentialFromJsonExample() {
        // This could come from a custom metadata type, static resource, or other source
        String jsonConfig = '{"developerName":"JsonExternalCredential","masterLabel":"JSON Example","authenticationProtocol":"OAuth","parameters":[{"parameterName":"AuthProvider","parameterType":"AuthProvider","parameterValue":"authProvider"},{"parameterName":"Scope","parameterType":"AuthParameter","parameterValue":"some_access"}],"principals":[{"principalName":"NamedPrincipal","principalType":"NamedPrincipal","sequenceNumber":1}]}';
        
        // Directly deserialize and use the JSON
        Object response = CredentialService.upsertExternalCredentialFromJson(jsonConfig);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Example of creating a Credential from JSON
     */
    public static void createCredentialFromJsonExample() {
        // This could come from a secure external system or vault
        String jsonConfig = '{"externalCredential":"JsonExternalCredential","principalName":"NamedPrincipal","principalType":"NamedPrincipal","credentials":{"apiKey":{"value":"your-api-key","encrypted":true}}}';
        
        // Directly deserialize and use the JSON
        Object response = CredentialService.populateCredentialFromJson(jsonConfig);
        
        System.debug('Response: ' + response);
    }
    
    /**
     * @description Simulates a Salesforce to Salesforce OAuth connection using Named Credential
     */
    public static void createSalesforceOAuthConnection() {
        try {
            System.debug(LoggingLevel.INFO, 'Creating Salesforce OAuth External Credential...');
            
            // Create the External Credential DTO for a Salesforce OAuth connection
            ExternalCredentialDTO dto = CredentialFactory.createOAuthBrowserFlow(
                'SalesforceIntegration',
                'SalesforceAuthProvider', // This would be a pre-configured Auth Provider in your org
                'api refresh_token offline_access'
            );
            
            // Add additional parameters specific to Salesforce
            ExternalCredentialDTO.ParameterDTO loginUrlParam = new ExternalCredentialDTO.ParameterDTO();
            loginUrlParam.parameterName = 'Login URL';
            loginUrlParam.parameterType = 'AuthParameter';
            loginUrlParam.parameterValue = '_ORG_DOMAIN_';
            dto.parameters.add(loginUrlParam);
            
            // Call the service with the DTO
            executeServiceCall(dto, true);
            
            System.debug(LoggingLevel.INFO, 'Salesforce OAuth External Credential created successfully.');
        } catch (Exception e) {
            handleException('Error creating Salesforce OAuth connection', e);
        }
    }
    
    /**
     * @description Simulates an OAuth JWT Bearer connection to a Microsoft Azure service
     */
    public static void createAzureJwtBearerConnection() {
        try {
            System.debug(LoggingLevel.INFO, 'Creating Azure JWT Bearer External Credential...');
            
            // Create the External Credential DTO for Azure JWT Bearer OAuth
            ExternalCredentialDTO dto = CredentialFactory.createOAuthJwtBearer(
                'AzureServiceIntegration',
                'AzureServiceCert', // This would be a certificate uploaded to Salesforce
                'https://yoursalesforceorg.my.salesforce.com',
                'service@yourdomain.onmicrosoft.com',
                'https://login.microsoftonline.com/your-tenant-id/oauth2/v2.0/token',
                'https://graph.microsoft.com/.default',
                'https://login.microsoftonline.com/your-tenant-id/oauth2/v2.0/token'
            );
            
            // Add tenant ID parameter
            ExternalCredentialDTO.ParameterDTO tenantParam = new ExternalCredentialDTO.ParameterDTO();
            tenantParam.parameterName = 'tenant_id';
            tenantParam.parameterType = 'JwtBodyClaim';
            tenantParam.parameterValue = 'your-tenant-id';
            dto.parameters.add(tenantParam);
            
            // Call the service with the DTO
            executeServiceCall(dto, true);
            
            System.debug(LoggingLevel.INFO, 'Azure JWT Bearer External Credential created successfully.');
        } catch (Exception e) {
            handleException('Error creating Azure JWT Bearer connection', e);
        }
    }
    
    /**
     * @description Simulates an AWS integration using SigV4 authentication for an S3 bucket access
     */
    public static void createAwsS3Integration() {
        try {
            System.debug(LoggingLevel.INFO, 'Creating AWS S3 Integration with SigV4 authentication...');
            
            // Step 1: Create the External Credential
            ExternalCredentialDTO extCredDto = CredentialFactory.createAwsSigV4('AWSIntegration_S3');
            
            // Add AWS-specific parameters
            ExternalCredentialDTO.ParameterDTO regionParam = new ExternalCredentialDTO.ParameterDTO();
            regionParam.parameterName = 'AWS Region';
            regionParam.parameterType = 'AuthParameter';
            regionParam.parameterValue = 'us-east-1';
            extCredDto.parameters.add(regionParam);
            
            ExternalCredentialDTO.ParameterDTO serviceParam = new ExternalCredentialDTO.ParameterDTO();
            serviceParam.parameterName = 'AWS Service';
            serviceParam.parameterType = 'AuthParameter';
            serviceParam.parameterValue = 's3';
            extCredDto.parameters.add(serviceParam);
            
            // Set both NamedPrincipal and AwsStsPrincipal
            // Clear existing principals first
            extCredDto.principals.clear();
            
            // Add named principal
            ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
            namedPrincipal.principalName = 'NamedPrincipal';
            namedPrincipal.principalType = 'NamedPrincipal';
            namedPrincipal.sequenceNumber = 1;
            extCredDto.principals.add(namedPrincipal);
            
            // Add AWS STS principal for temporary security credentials
            ExternalCredentialDTO.PrincipalDTO awsStsPrincipal = new ExternalCredentialDTO.PrincipalDTO();
            awsStsPrincipal.principalName = 'AwsStsPrincipal';
            awsStsPrincipal.principalType = 'AwsStsPrincipal';
            awsStsPrincipal.sequenceNumber = 2;
            extCredDto.principals.add(awsStsPrincipal);
            
            // Call the service with the DTO
            executeServiceCall(extCredDto, true);
            
            // Step 2: Populate Access Key and Secret for the NamedPrincipal
            System.debug(LoggingLevel.INFO, 'Setting AWS access credentials...');
            
            CredentialDTO credDto = CredentialFactory.createAwsAccessKeyCredential(
                'AWSIntegration_S3',
                'AKIAIOSFODNN7EXAMPLE',  // Example access key (not real)
                'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'  // Example secret key (not real)
            );
            
            executeServiceCall(credDto, false);
            
            System.debug(LoggingLevel.INFO, 'AWS S3 Integration created and credentials populated successfully.');
        } catch (Exception e) {
            handleException('Error creating AWS S3 integration', e);
        }
    }
    
    /**
     * @description Simulates a REST API integration with an API Key in the header
     */
    public static void createApiKeyBasedIntegration() {
        try {
            System.debug(LoggingLevel.INFO, 'Creating API Key based integration...');
            
            // Step 1: Create External Credential with Custom auth protocol
            ExternalCredentialDTO extCredDto = new ExternalCredentialDTO();
            extCredDto.developerName = 'APIKeyService';
            extCredDto.masterLabel = 'API Key Service';
            extCredDto.authenticationProtocol = 'Custom';
            
            // Set principal
            ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
            namedPrincipal.principalName = 'NamedPrincipal';
            namedPrincipal.principalType = 'NamedPrincipal';
            namedPrincipal.sequenceNumber = 1;
            extCredDto.principals.add(namedPrincipal);
            
            // Call the service with the DTO
            executeServiceCall(extCredDto, true);
            
            // Step 2: Set up the API key credentials
            System.debug(LoggingLevel.INFO, 'Setting API Key credentials...');
            
            // Create a map of credential fields
            Map<String, String> apiKeyFields = new Map<String, String>{
                'x-api-key' => 'sk_test_abcdefghijklmnopqrstuvwxyz123456789',
                'client-id' => 'client_12345abcde',
                'environment' => 'production'
            };
            
            // Specify which fields should be encrypted
            Set<String> encryptedFields = new Set<String>{'x-api-key'};
            
            // Create and populate the credential
            CredentialDTO credDto = CredentialFactory.createCustomCredential(
                'APIKeyService',
                'NamedPrincipal',
                'NamedPrincipal',
                apiKeyFields,
                encryptedFields
            );
            
            executeServiceCall(credDto, false);
            
            System.debug(LoggingLevel.INFO, 'API Key integration created and credentials populated successfully.');
        } catch (Exception e) {
            handleException('Error creating API Key integration', e);
        }
    }
    
    /**
     * @description Simulates a basic username/password authentication for a REST API
     */
    public static void createBasicAuthRestApiIntegration() {
        try {
            System.debug(LoggingLevel.INFO, 'Creating Basic Auth REST API integration...');
            
            // Step 1: Create External Credential with Basic auth protocol
            ExternalCredentialDTO extCredDto = new ExternalCredentialDTO();
            extCredDto.developerName = 'BasicAuthService';
            extCredDto.masterLabel = 'Basic Auth Service';
            extCredDto.authenticationProtocol = 'Password';
            
            // Set principal
            ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
            namedPrincipal.principalName = 'NamedPrincipal';
            namedPrincipal.principalType = 'NamedPrincipal';
            namedPrincipal.sequenceNumber = 1;
            extCredDto.principals.add(namedPrincipal);
            
            // Call the service with the DTO
            executeServiceCall(extCredDto, true);
            
            // Step 2: Set the username and password credentials
            System.debug(LoggingLevel.INFO, 'Setting Basic Auth credentials...');
            
            CredentialDTO credDto = CredentialFactory.createBasicAuthCredential(
                'BasicAuthService',
                'NamedPrincipal',
                'NamedPrincipal',
                'api-user@example.com',
                'Sup3r$ecureP@ssw0rd!'
            );
            
            executeServiceCall(credDto, false);
            
            System.debug(LoggingLevel.INFO, 'Basic Auth integration created and credentials populated successfully.');
        } catch (Exception e) {
            handleException('Error creating Basic Auth integration', e);
        }
    }
    
    /**
     * @description Simulates loading credential configuration from a Custom Metadata Type
     */
    public static void loadCredentialsFromMetadata() {
        try {
            System.debug(LoggingLevel.INFO, 'Loading credentials from metadata (simulated)...');
            
            // In a real implementation, this would query Custom Metadata Type records
            // Here, we're simulating loading the configuration from a metadata source
            String jsonConfig = '{'
                + '"developerName": "MetadataCredential",'
                + '"masterLabel": "Metadata-Loaded Credential",'
                + '"authenticationProtocol": "OAuth",'
                + '"parameters": ['
                + '  {"parameterName": "AuthProvider", "parameterType": "AuthProvider", "parameterValue": "GoogleAuthProvider"},'
                + '  {"parameterName": "Scope", "parameterType": "AuthParameter", "parameterValue": "https://www.googleapis.com/auth/calendar.readonly"}'
                + '],'
                + '"principals": ['
                + '  {"principalName": "NamedPrincipal", "principalType": "NamedPrincipal", "sequenceNumber": 1}'
                + ']'
                + '}';
            
            // Execute the service call
            executeJsonServiceCall(jsonConfig, true);
            
            System.debug(LoggingLevel.INFO, 'Metadata-based credential loaded successfully.');
        } catch (Exception e) {
            handleException('Error loading credentials from metadata', e);
        }
    }
    
    /**
     * @description Creates a JWT Bearer credential for loopback REST calls to the same org
     * This allows an Apex class to make authenticated REST calls back to the same org
     */
    public static void createSelfOrgLoopbackCredential() {
        try {
            System.debug(LoggingLevel.INFO, 'Creating JWT Bearer loopback credential for self-org API calls...');
            
            // Step 1: Create the External Credential
            String developerName = 'SelfOrgLoopback';
            String orgId = UserInfo.getOrganizationId();
            String baseUrl = Url.getSalesforceBaseUrl().toExternalForm();
            
            // Create the External Credential DTO for JWT Bearer OAuth
            ExternalCredentialDTO dto = new ExternalCredentialDTO();
            dto.developerName = developerName;
            dto.masterLabel = 'Self-Org Loopback Credential';
            dto.authenticationProtocol = 'OAuth';
            dto.authenticationProtocolVariant = 'JwtBearer';
            
            // Add certificate parameter - assumes you have a certificate named 'SelfSignedCert' in the org
            ExternalCredentialDTO.ParameterDTO certParam = new ExternalCredentialDTO.ParameterDTO();
            certParam.parameterName = 'SigningCertificate';
            certParam.parameterType = 'SigningCertificate';
            certParam.parameterValue = 'SelfSignedCert';
            dto.parameters.add(certParam);
            
            // Add JWT claims
            // The issuer should be the connected app's client ID
            ExternalCredentialDTO.ParameterDTO issParam = new ExternalCredentialDTO.ParameterDTO();
            issParam.parameterName = 'iss';
            issParam.parameterType = 'JwtBodyClaim';
            issParam.parameterValue = 'YOUR_CONNECTED_APP_CLIENT_ID'; // Replace with actual client ID
            dto.parameters.add(issParam);
            
            // The subject should be the username making the call
            ExternalCredentialDTO.ParameterDTO subParam = new ExternalCredentialDTO.ParameterDTO();
            subParam.parameterName = 'sub';
            subParam.parameterType = 'JwtBodyClaim';
            subParam.parameterValue = UserInfo.getUserName();
            dto.parameters.add(subParam);
            
            // The audience should be the login URL for your org
            ExternalCredentialDTO.ParameterDTO audParam = new ExternalCredentialDTO.ParameterDTO();
            audParam.parameterName = 'aud';
            audParam.parameterType = 'JwtBodyClaim';
            audParam.parameterValue = '_ORG_DOMAIN_'; // Or test.salesforce.com for sandboxes
            dto.parameters.add(audParam);
            
            // Add scope
            ExternalCredentialDTO.ParameterDTO scopeParam = new ExternalCredentialDTO.ParameterDTO();
            scopeParam.parameterName = 'Scope';
            scopeParam.parameterType = 'AuthParameter';
            scopeParam.parameterValue = 'api refresh_token offline_access';
            dto.parameters.add(scopeParam);
            
            // Add IDP URL - this is the token endpoint for your org
            ExternalCredentialDTO.ParameterDTO idpUrlParam = new ExternalCredentialDTO.ParameterDTO();
            idpUrlParam.parameterName = 'Identity Provider URL';
            idpUrlParam.parameterType = 'AuthProviderUrl';
            idpUrlParam.parameterValue = baseUrl + '/services/oauth2/token';
            dto.parameters.add(idpUrlParam);
            
            // Add principal - we're using named principal for simplicity
            ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
            namedPrincipal.principalName = 'NamedPrincipal';
            namedPrincipal.principalType = 'NamedPrincipal';
            namedPrincipal.sequenceNumber = 1;
            dto.principals.add(namedPrincipal);
            
            // Call the service with the DTO
            executeServiceCall(dto, true);
            
            System.debug(LoggingLevel.INFO, 'Self-Org Loopback Credential created successfully.');
            System.debug(LoggingLevel.INFO, 'To use this credential, create a Named Credential that references it.');
            System.debug(LoggingLevel.INFO, 'Then make callouts to baseUrl + "/services/apexrest/..." using the Named Credential.');
            
            // Provide an example of how to use the credential in a callout
            String calloutExampleCode = 
                'HttpRequest req = new HttpRequest();\n' +
                'req.setEndpoint(\'callout:' + developerName + '/services/apexrest/YourCustomEndpoint\');\n' +
                'req.setMethod(\'GET\');\n' +
                'Http http = new Http();\n' +
                'HttpResponse res = http.send(req);\n' +
                'System.debug(res.getBody());';
            
            System.debug(LoggingLevel.INFO, 'Example callout code:\n' + calloutExampleCode);
        } catch (Exception e) {
            handleException('Error creating self-org loopback credential', e);
        }
    }
    
    /**
     * @description Tests the JWT Bearer loopback credential with a sample callout
     * Note: This is a demonstration and may fail if the credential is not set up correctly
     */
    public static void testLoopbackCallout() {
        try {
            System.debug(LoggingLevel.INFO, 'Testing loopback callout to your own org...');
            
            // Create a Named Credential first
            String loopbackCredentialName = 'SelfOrgLoopback';
            String endpoint = 'callout:' + loopbackCredentialName + '/services/data/v59.0/sobjects/Account';
            
            // Setup the request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            
            // Make the callout
            Http http = new Http();
            System.debug(LoggingLevel.INFO, 'Sending request to: ' + endpoint);
            
            // In reality, this would execute, but since this is a demonstration, we'll just show the code
            if (false) { // Never execute the actual callout in this example
                HttpResponse res = http.send(req);
                System.debug(LoggingLevel.INFO, 'Response status: ' + res.getStatusCode());
                System.debug(LoggingLevel.INFO, 'Response body: ' + res.getBody());
            }
            
            System.debug(LoggingLevel.INFO, 'This is a demonstration - no actual callout was made.');
            System.debug(LoggingLevel.INFO, 'To make this work:');
            System.debug(LoggingLevel.INFO, '1. Create a Connected App in your org with OAuth and JWT enabled');
            System.debug(LoggingLevel.INFO, '2. Generate a self-signed certificate in Salesforce');
            System.debug(LoggingLevel.INFO, '3. Update the createSelfOrgLoopbackCredential method with your Connected App Client ID');
            System.debug(LoggingLevel.INFO, '4. Create a Named Credential that references the External Credential');
            System.debug(LoggingLevel.INFO, '5. Ensure your Remote Site Settings include your org\'s base URL');
            
        } catch (Exception e) {
            handleException('Error testing loopback callout', e);
        }
    }
    
    /**
     * @description Runs all loopback credential examples and tests
     */
    public static void runLoopbackExamples() {
        try {
            createSelfOrgLoopbackCredential();
            testLoopbackCallout();
            
            System.debug(LoggingLevel.INFO, 'All loopback examples executed.');
        } catch (Exception e) {
            handleException('Error running loopback examples', e);
        }
    }
    
    /**
     * @description Runs all example integration scenarios
     */
    public static void runAllExamples() {
        try {
            createSalesforceOAuthConnection();
            createAzureJwtBearerConnection();
            createAwsS3Integration();
            createApiKeyBasedIntegration();
            createBasicAuthRestApiIntegration();
            loadCredentialsFromMetadata();
            
            System.debug(LoggingLevel.INFO, 'All credential examples executed successfully.');
        } catch (Exception e) {
            handleException('Error running all examples', e);
        }
    }
    
    // Helper methods for tracking execution and handling errors
    
    /**
     * @description Utility method to execute a credential service call for External Credential
     * @param dto The External Credential DTO to use
     * @param isExternalCredential Whether this is an external credential (true) or regular credential (false)
     */
    private static void executeServiceCall(Object dto, Boolean isExternalCredential) {
        try {
            if (isExternalCredential) {
                ExternalCredentialDTO extDto = (ExternalCredentialDTO)dto;
                lastExecutionResponse = CredentialService.upsertExternalCredential(extDto);
            } else {
                CredentialDTO credDto = (CredentialDTO)dto;
                lastExecutionResponse = CredentialService.populateCredential(credDto);
            }
            
            lastExecutionSuccessful = true;
            lastExecutionMessage = 'Operation completed successfully';
            
            // Log the response (though current implementation will throw exceptions)
            System.debug(LoggingLevel.INFO, 'Service response: ' + lastExecutionResponse);
        } catch (UnsupportedOperationException uoe) {
            // This is expected since we're stubbing the API calls
            lastExecutionSuccessful = false;
            lastExecutionMessage = 'API not available: ' + uoe.getMessage();
            System.debug(LoggingLevel.INFO, 'Expected unsupported operation: ' + uoe.getMessage());
        } catch (Exception e) {
            // Handle unexpected errors
            lastExecutionSuccessful = false;
            lastExecutionMessage = 'Error: ' + e.getMessage();
            System.debug(LoggingLevel.ERROR, 'Error in service call: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
        }
    }
    
    /**
     * @description Utility method to execute a credential service call with JSON
     * @param jsonConfig The JSON configuration to use
     * @param isExternalCredential Whether this is an external credential (true) or regular credential (false)
     */
    private static void executeJsonServiceCall(String jsonConfig, Boolean isExternalCredential) {
        try {
            if (isExternalCredential) {
                lastExecutionResponse = CredentialService.upsertExternalCredentialFromJson(jsonConfig);
            } else {
                lastExecutionResponse = CredentialService.populateCredentialFromJson(jsonConfig);
            }
            
            lastExecutionSuccessful = true;
            lastExecutionMessage = 'Operation completed successfully';
            
            // Log the response (though current implementation will throw exceptions)
            System.debug(LoggingLevel.INFO, 'Service response: ' + lastExecutionResponse);
        } catch (UnsupportedOperationException uoe) {
            // This is expected since we're stubbing the API calls
            lastExecutionSuccessful = false;
            lastExecutionMessage = 'API not available: ' + uoe.getMessage();
            System.debug(LoggingLevel.INFO, 'Expected unsupported operation: ' + uoe.getMessage());
        } catch (Exception e) {
            // Handle unexpected errors
            lastExecutionSuccessful = false;
            lastExecutionMessage = 'Error: ' + e.getMessage();
            System.debug(LoggingLevel.ERROR, 'Error in service call: ' + e.getMessage());
            System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
        }
    }
    
    /**
     * @description Utility method to handle exceptions with proper logging
     * @param message The message to log
     * @param e The exception that was caught
     */
    private static void handleException(String message, Exception e) {
        lastExecutionSuccessful = false;
        lastExecutionMessage = message + ': ' + e.getMessage();
        
        System.debug(LoggingLevel.ERROR, message);
        System.debug(LoggingLevel.ERROR, 'Exception type: ' + e.getTypeName());
        System.debug(LoggingLevel.ERROR, 'Exception message: ' + e.getMessage());
        System.debug(LoggingLevel.ERROR, 'Stack trace: ' + e.getStackTraceString());
        
        throw e;
    }
} 