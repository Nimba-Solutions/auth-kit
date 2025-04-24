/**
 * @description Factory class for creating credential configurations using ConnectApi classes
 * This class provides methods to easily create common authentication configurations
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialFactory {
    
    /**
     * @description Creates an OAuth Browser Flow External Credential configuration
     * @param developerName The developer name for the External Credential
     * @param authProviderName The Auth Provider name to use
     * @param scope The OAuth scope
     * @return ExternalCredentialModel The configured External Credential model
     */
    public static ExternalCredentialModel createOAuthBrowserFlow(String developerName, String authProviderName, String scope) {
        ExternalCredentialModel model = new ExternalCredentialModel();
        model.setDeveloperName(developerName)
             .setMasterLabel(developerName)
             .setAuthenticationProtocol('OAuth')
             .addParameter('AuthProvider', 'AuthProvider', authProviderName)
             .addParameter('Scope', 'AuthParameter', scope)
             .addPrincipal('NamedPrincipal', 'NamedPrincipal', 1)
             .addPrincipal('PerUserPrincipal', 'PerUserPrincipal', 2);
        
        return model;
    }
    
    /**
     * @description Creates an OAuth JWT Bearer Flow External Credential configuration
     * @param developerName The developer name for the External Credential
     * @param certName The signing certificate name
     * @param issuer The JWT issuer claim
     * @param subject The JWT subject claim
     * @param audience The JWT audience claim
     * @param scope The OAuth scope
     * @param idpUrl The Identity Provider URL
     * @return ExternalCredentialModel The configured External Credential model
     */
    public static ExternalCredentialModel createOAuthJwtBearer(
        String developerName, 
        String certName, 
        String issuer, 
        String subject, 
        String audience, 
        String scope, 
        String idpUrl
    ) {
        ExternalCredentialModel model = new ExternalCredentialModel();
        model.setDeveloperName(developerName)
             .setMasterLabel(developerName)
             .setAuthenticationProtocol('OAuth')
             .setAuthenticationProtocolVariant('JwtBearer')
             .addParameter('SigningCertificate', 'SigningCertificate', certName)
             .addParameter('iss', 'JwtBodyClaim', issuer)
             .addParameter('sub', 'JwtBodyClaim', subject)
             .addParameter('aud', 'JwtBodyClaim', audience)
             .addParameter('Scope', 'AuthParameter', scope)
             .addParameter('Identity Provider URL', 'AuthProviderUrl', idpUrl)
             .addPrincipal('NamedPrincipal', 'NamedPrincipal', 1)
             .addPrincipal('PerUserPrincipal', 'PerUserPrincipal', 2);
        
        return model;
    }
    
    /**
     * @description Creates an OAuth Client Credentials with JWT Assertion External Credential configuration
     * @param developerName The developer name for the External Credential
     * @param certName The signing certificate name
     * @param issuer The JWT issuer claim
     * @param subject The JWT subject claim
     * @param audience The JWT audience claim
     * @param scope The OAuth scope
     * @param idpUrl The Identity Provider URL
     * @return ExternalCredentialModel The configured External Credential model
     */
    public static ExternalCredentialModel createOAuthClientCredentialsJwtAssertion(
        String developerName, 
        String certName, 
        String issuer, 
        String subject, 
        String audience, 
        String scope, 
        String idpUrl
    ) {
        ExternalCredentialModel model = new ExternalCredentialModel();
        model.setDeveloperName(developerName)
             .setMasterLabel(developerName)
             .setAuthenticationProtocol('OAuth')
             .setAuthenticationProtocolVariant('ClientCredentialsJwtAssertion')
             .addParameter('Scope', 'AuthParameter', scope)
             .addParameter('Identity Provider URL', 'AuthProviderUrl', idpUrl)
             .addParameter('SigningCertificate', 'SigningCertificate', certName)
             .addParameter('iss', 'JwtBodyClaim', issuer)
             .addParameter('sub', 'JwtBodyClaim', subject)
             .addParameter('aud', 'JwtBodyClaim', audience)
             .addPrincipal('NamedPrincipal', 'NamedPrincipal', 1);
        
        return model;
    }
    
    /**
     * @description Creates a Client ID credential for OAuth Client Credentials with JWT Assertion
     * @param externalCredentialName The External Credential developer name
     * @param clientId The client ID
     * @return CredentialModel The configured Credential model
     */
    public static CredentialModel createClientIdCredential(
        String externalCredentialName,
        String clientId
    ) {
        CredentialModel model = new CredentialModel(
            externalCredentialName,
            'NamedPrincipal',
            'NamedPrincipal'
        );
        
        model.addCredential('clientId', clientId, false);
        
        return model;
    }
    
    /**
     * @description Creates an AWS SigV4 External Credential configuration for Access Key and Secret
     * @param developerName The developer name for the External Credential
     * @return ExternalCredentialModel The configured External Credential model
     */
    public static ExternalCredentialModel createAwsSigV4(String developerName) {
        ExternalCredentialModel model = new ExternalCredentialModel();
        model.setDeveloperName(developerName)
             .setMasterLabel(developerName)
             .setAuthenticationProtocol('AwsSig4')
             .addPrincipal('NamedPrincipal', 'NamedPrincipal', 1);
        
        return model;
    }
    
    /**
     * @description Creates an AWS SigV4 credential for Access Key and Secret
     * @param externalCredentialName The External Credential developer name
     * @param accessKey The AWS access key
     * @param secretKey The AWS secret key
     * @return CredentialModel The configured Credential model
     */
    public static CredentialModel createAwsAccessKeyCredential(
        String externalCredentialName,
        String accessKey,
        String secretKey
    ) {
        CredentialModel model = new CredentialModel(
            externalCredentialName,
            'NamedPrincipal',
            'NamedPrincipal'
        );
        
        model.addCredential('awsAccessKeyId', accessKey, false)
             .addCredential('awsSecretAccessKey', secretKey, true);
        
        return model;
    }
    
    /**
     * @description Creates a Basic Authentication credential
     * @param externalCredentialName The External Credential developer name
     * @param principalName The principal name
     * @param principalType The principal type
     * @param username The username
     * @param password The password
     * @return CredentialModel The configured Credential model
     */
    public static CredentialModel createBasicAuthCredential(
        String externalCredentialName,
        String principalName,
        String principalType,
        String username,
        String password
    ) {
        CredentialModel model = new CredentialModel(
            externalCredentialName,
            principalName,
            principalType
        );
        
        model.addCredential('username', username, false)
             .addCredential('password', password, true);
        
        return model;
    }
    
    /**
     * @description Creates a custom credential (e.g., API Key)
     * @param externalCredentialName The External Credential developer name
     * @param principalName The principal name
     * @param principalType The principal type
     * @param credentialMap Map of credential name to value pairs
     * @param encryptedFields Set of field names that should be encrypted
     * @return CredentialModel The configured Credential model
     */
    public static CredentialModel createCustomCredential(
        String externalCredentialName,
        String principalName,
        String principalType,
        Map<String, String> credentialMap,
        Set<String> encryptedFields
    ) {
        CredentialModel model = new CredentialModel(
            externalCredentialName,
            principalName,
            principalType
        );
        
        for (String key : credentialMap.keySet()) {
            Boolean encrypted = encryptedFields.contains(key);
            model.addCredential(key, credentialMap.get(key), encrypted);
        }
        
        return model;
    }
} 