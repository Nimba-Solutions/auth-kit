/**
 * @description Factory class for creating credential DTOs
 * This class provides methods to easily create common authentication configurations
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialFactory {
    
    /**
     * @description Creates an OAuth Browser Flow External Credential configuration
     * @param developerName The developer name for the External Credential
     * @param authProviderName The Auth Provider name to use
     * @param scope The OAuth scope
     * @return ExternalCredentialDTO The configured External Credential DTO
     */
    public static ExternalCredentialDTO createOAuthBrowserFlow(String developerName, String authProviderName, String scope) {
        ExternalCredentialDTO dto = new ExternalCredentialDTO();
        dto.developerName = developerName;
        dto.masterLabel = developerName;
        dto.authenticationProtocol = 'OAuth';
        
        ExternalCredentialDTO.ParameterDTO authProviderParam = new ExternalCredentialDTO.ParameterDTO();
        authProviderParam.parameterName = 'AuthProvider';
        authProviderParam.parameterType = 'AuthProvider';
        authProviderParam.parameterValue = authProviderName;
        dto.parameters.add(authProviderParam);
        
        ExternalCredentialDTO.ParameterDTO scopeParam = new ExternalCredentialDTO.ParameterDTO();
        scopeParam.parameterName = 'Scope';
        scopeParam.parameterType = 'AuthParameter';
        scopeParam.parameterValue = scope;
        dto.parameters.add(scopeParam);
        
        ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
        namedPrincipal.principalName = 'NamedPrincipal';
        namedPrincipal.principalType = 'NamedPrincipal';
        namedPrincipal.sequenceNumber = 1;
        dto.principals.add(namedPrincipal);
        
        ExternalCredentialDTO.PrincipalDTO perUserPrincipal = new ExternalCredentialDTO.PrincipalDTO();
        perUserPrincipal.principalName = 'PerUserPrincipal';
        perUserPrincipal.principalType = 'PerUserPrincipal';
        perUserPrincipal.sequenceNumber = 2;
        dto.principals.add(perUserPrincipal);
        
        return dto;
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
     * @return ExternalCredentialDTO The configured External Credential DTO
     */
    public static ExternalCredentialDTO createOAuthJwtBearer(
        String developerName, 
        String certName, 
        String issuer, 
        String subject, 
        String audience, 
        String scope, 
        String idpUrl
    ) {
        ExternalCredentialDTO dto = new ExternalCredentialDTO();
        dto.developerName = developerName;
        dto.masterLabel = developerName;
        dto.authenticationProtocol = 'OAuth';
        dto.authenticationProtocolVariant = 'JwtBearer';
        
        // Add certificate parameter
        ExternalCredentialDTO.ParameterDTO certParam = new ExternalCredentialDTO.ParameterDTO();
        certParam.parameterName = 'SigningCertificate';
        certParam.parameterType = 'SigningCertificate';
        certParam.parameterValue = certName;
        dto.parameters.add(certParam);
        
        // Add JWT claims
        ExternalCredentialDTO.ParameterDTO issParam = new ExternalCredentialDTO.ParameterDTO();
        issParam.parameterName = 'iss';
        issParam.parameterType = 'JwtBodyClaim';
        issParam.parameterValue = issuer;
        dto.parameters.add(issParam);
        
        ExternalCredentialDTO.ParameterDTO subParam = new ExternalCredentialDTO.ParameterDTO();
        subParam.parameterName = 'sub';
        subParam.parameterType = 'JwtBodyClaim';
        subParam.parameterValue = subject;
        dto.parameters.add(subParam);
        
        ExternalCredentialDTO.ParameterDTO audParam = new ExternalCredentialDTO.ParameterDTO();
        audParam.parameterName = 'aud';
        audParam.parameterType = 'JwtBodyClaim';
        audParam.parameterValue = audience;
        dto.parameters.add(audParam);
        
        // Add scope
        ExternalCredentialDTO.ParameterDTO scopeParam = new ExternalCredentialDTO.ParameterDTO();
        scopeParam.parameterName = 'Scope';
        scopeParam.parameterType = 'AuthParameter';
        scopeParam.parameterValue = scope;
        dto.parameters.add(scopeParam);
        
        // Add IDP URL
        ExternalCredentialDTO.ParameterDTO idpUrlParam = new ExternalCredentialDTO.ParameterDTO();
        idpUrlParam.parameterName = 'Identity Provider URL';
        idpUrlParam.parameterType = 'AuthProviderUrl';
        idpUrlParam.parameterValue = idpUrl;
        dto.parameters.add(idpUrlParam);
        
        // Add principals
        ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
        namedPrincipal.principalName = 'NamedPrincipal';
        namedPrincipal.principalType = 'NamedPrincipal';
        namedPrincipal.sequenceNumber = 1;
        dto.principals.add(namedPrincipal);
        
        ExternalCredentialDTO.PrincipalDTO perUserPrincipal = new ExternalCredentialDTO.PrincipalDTO();
        perUserPrincipal.principalName = 'PerUserPrincipal';
        perUserPrincipal.principalType = 'PerUserPrincipal';
        perUserPrincipal.sequenceNumber = 2;
        dto.principals.add(perUserPrincipal);
        
        return dto;
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
     * @return ExternalCredentialDTO The configured External Credential DTO
     */
    public static ExternalCredentialDTO createOAuthClientCredentialsJwtAssertion(
        String developerName, 
        String certName, 
        String issuer, 
        String subject, 
        String audience, 
        String scope, 
        String idpUrl
    ) {
        ExternalCredentialDTO dto = new ExternalCredentialDTO();
        dto.developerName = developerName;
        dto.masterLabel = developerName;
        dto.authenticationProtocol = 'OAuth';
        dto.authenticationProtocolVariant = 'ClientCredentialsJwtAssertion';
        
        // Add scope
        ExternalCredentialDTO.ParameterDTO scopeParam = new ExternalCredentialDTO.ParameterDTO();
        scopeParam.parameterName = 'Scope';
        scopeParam.parameterType = 'AuthParameter';
        scopeParam.parameterValue = scope;
        dto.parameters.add(scopeParam);
        
        // Add IDP URL
        ExternalCredentialDTO.ParameterDTO idpUrlParam = new ExternalCredentialDTO.ParameterDTO();
        idpUrlParam.parameterName = 'Identity Provider URL';
        idpUrlParam.parameterType = 'AuthProviderUrl';
        idpUrlParam.parameterValue = idpUrl;
        dto.parameters.add(idpUrlParam);
        
        // Add certificate parameter
        ExternalCredentialDTO.ParameterDTO certParam = new ExternalCredentialDTO.ParameterDTO();
        certParam.parameterName = 'SigningCertificate';
        certParam.parameterType = 'SigningCertificate';
        certParam.parameterValue = certName;
        dto.parameters.add(certParam);
        
        // Add JWT claims
        ExternalCredentialDTO.ParameterDTO issParam = new ExternalCredentialDTO.ParameterDTO();
        issParam.parameterName = 'iss';
        issParam.parameterType = 'JwtBodyClaim';
        issParam.parameterValue = issuer;
        dto.parameters.add(issParam);
        
        ExternalCredentialDTO.ParameterDTO subParam = new ExternalCredentialDTO.ParameterDTO();
        subParam.parameterName = 'sub';
        subParam.parameterType = 'JwtBodyClaim';
        subParam.parameterValue = subject;
        dto.parameters.add(subParam);
        
        ExternalCredentialDTO.ParameterDTO audParam = new ExternalCredentialDTO.ParameterDTO();
        audParam.parameterName = 'aud';
        audParam.parameterType = 'JwtBodyClaim';
        audParam.parameterValue = audience;
        dto.parameters.add(audParam);
        
        // Add principal
        ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
        namedPrincipal.principalName = 'NamedPrincipal';
        namedPrincipal.principalType = 'NamedPrincipal';
        namedPrincipal.sequenceNumber = 1;
        dto.principals.add(namedPrincipal);
        
        return dto;
    }
    
    /**
     * @description Creates a Client ID credential for OAuth Client Credentials with JWT Assertion
     * @param externalCredentialName The External Credential developer name
     * @param clientId The client ID
     * @return CredentialDTO The configured Credential DTO
     */
    public static CredentialDTO createClientIdCredential(
        String externalCredentialName,
        String clientId
    ) {
        CredentialDTO dto = new CredentialDTO();
        dto.externalCredential = externalCredentialName;
        dto.principalName = 'NamedPrincipal';
        dto.principalType = 'NamedPrincipal';
        
        CredentialDTO.CredentialValueDTO clientIdValue = new CredentialDTO.CredentialValueDTO();
        clientIdValue.value = clientId;
        clientIdValue.encrypted = false;
        dto.credentials.put('clientId', clientIdValue);
        
        return dto;
    }
    
    /**
     * @description Creates an AWS SigV4 External Credential configuration for Access Key and Secret
     * @param developerName The developer name for the External Credential
     * @return ExternalCredentialDTO The configured External Credential DTO
     */
    public static ExternalCredentialDTO createAwsSigV4(String developerName) {
        ExternalCredentialDTO dto = new ExternalCredentialDTO();
        dto.developerName = developerName;
        dto.masterLabel = developerName;
        dto.authenticationProtocol = 'AwsSig4';
        
        ExternalCredentialDTO.PrincipalDTO namedPrincipal = new ExternalCredentialDTO.PrincipalDTO();
        namedPrincipal.principalName = 'NamedPrincipal';
        namedPrincipal.principalType = 'NamedPrincipal';
        namedPrincipal.sequenceNumber = 1;
        dto.principals.add(namedPrincipal);
        
        return dto;
    }
    
    /**
     * @description Creates an AWS SigV4 credential for Access Key and Secret
     * @param externalCredentialName The External Credential developer name
     * @param accessKey The AWS access key
     * @param secretKey The AWS secret key
     * @return CredentialDTO The configured Credential DTO
     */
    public static CredentialDTO createAwsAccessKeyCredential(
        String externalCredentialName,
        String accessKey,
        String secretKey
    ) {
        CredentialDTO dto = new CredentialDTO();
        dto.externalCredential = externalCredentialName;
        dto.principalName = 'NamedPrincipal';
        dto.principalType = 'NamedPrincipal';
        
        CredentialDTO.CredentialValueDTO accessKeyValue = new CredentialDTO.CredentialValueDTO();
        accessKeyValue.value = accessKey;
        accessKeyValue.encrypted = false;
        dto.credentials.put('awsAccessKeyId', accessKeyValue);
        
        CredentialDTO.CredentialValueDTO secretKeyValue = new CredentialDTO.CredentialValueDTO();
        secretKeyValue.value = secretKey;
        secretKeyValue.encrypted = true;
        dto.credentials.put('awsSecretAccessKey', secretKeyValue);
        
        return dto;
    }
    
    /**
     * @description Creates a Basic Authentication credential
     * @param externalCredentialName The External Credential developer name
     * @param principalName The principal name
     * @param principalType The principal type
     * @param username The username
     * @param password The password
     * @return CredentialDTO The configured Credential DTO
     */
    public static CredentialDTO createBasicAuthCredential(
        String externalCredentialName,
        String principalName,
        String principalType,
        String username,
        String password
    ) {
        CredentialDTO dto = new CredentialDTO();
        dto.externalCredential = externalCredentialName;
        dto.principalName = principalName;
        dto.principalType = principalType;
        
        CredentialDTO.CredentialValueDTO usernameValue = new CredentialDTO.CredentialValueDTO();
        usernameValue.value = username;
        usernameValue.encrypted = false;
        dto.credentials.put('username', usernameValue);
        
        CredentialDTO.CredentialValueDTO passwordValue = new CredentialDTO.CredentialValueDTO();
        passwordValue.value = password;
        passwordValue.encrypted = true;
        dto.credentials.put('password', passwordValue);
        
        return dto;
    }
    
    /**
     * @description Creates a custom credential (e.g., API Key)
     * @param externalCredentialName The External Credential developer name
     * @param principalName The principal name
     * @param principalType The principal type
     * @param credentialMap Map of credential name to value pairs
     * @param encryptedFields Set of field names that should be encrypted
     * @return CredentialDTO The configured Credential DTO
     */
    public static CredentialDTO createCustomCredential(
        String externalCredentialName,
        String principalName,
        String principalType,
        Map<String, String> credentialMap,
        Set<String> encryptedFields
    ) {
        CredentialDTO dto = new CredentialDTO();
        dto.externalCredential = externalCredentialName;
        dto.principalName = principalName;
        dto.principalType = principalType;
        
        for (String key : credentialMap.keySet()) {
            CredentialDTO.CredentialValueDTO valueDto = new CredentialDTO.CredentialValueDTO();
            valueDto.value = credentialMap.get(key);
            valueDto.encrypted = encryptedFields.contains(key);
            dto.credentials.put(key, valueDto);
        }
        
        return dto;
    }
} 