/**
 * @description Data Transfer Object for External Credential
 * This class can be directly deserialized from JSON
 */
public class ExternalCredentialDTO {
    public String developerName { get; set; }
    public String masterLabel { get; set; }
    public String authenticationProtocol { get; set; }
    public String authenticationProtocolVariant { get; set; }
    public List<ParameterDTO> parameters { get; set; }
    public List<PrincipalDTO> principals { get; set; }
    
    public ExternalCredentialDTO() {
        this.parameters = new List<ParameterDTO>();
        this.principals = new List<PrincipalDTO>();
    }
    
    /**
     * @description Converts this DTO to a ConnectApi.ExternalCredentialInput
     * @return ConnectApi.ExternalCredentialInput The converted input object
     */
    public ConnectApi.ExternalCredentialInput toConnectApiInput() {
        ConnectApi.ExternalCredentialInput input = new ConnectApi.ExternalCredentialInput();
        input.developerName = this.developerName;
        input.masterLabel = this.masterLabel;
        
        // Convert String to enum
        if (this.authenticationProtocol != null) {
            input.authenticationProtocol = getAuthProtocolEnum(this.authenticationProtocol);
        }
        
        if (this.authenticationProtocolVariant != null) {
            input.authenticationProtocolVariant = getAuthProtocolVariantEnum(this.authenticationProtocolVariant);
        }
        
        input.parameters = new List<ConnectApi.ExternalCredentialParameterInput>();
        if (this.parameters != null) {
            for (ParameterDTO paramDto : this.parameters) {
                input.parameters.add(paramDto.toConnectApiInput());
            }
        }
        
        input.principals = new List<ConnectApi.ExternalCredentialPrincipalInput>();
        if (this.principals != null) {
            for (PrincipalDTO principalDto : this.principals) {
                input.principals.add(principalDto.toConnectApiInput());
            }
        }
        
        return input;
    }
    
    /**
     * @description Get the authentication protocol enum from a string
     * @param protocol The protocol as a string
     * @return ConnectApi.CredentialAuthenticationProtocol The enum value
     */
    private ConnectApi.CredentialAuthenticationProtocol getAuthProtocolEnum(String protocol) {
        if (protocol.equalsIgnoreCase('OAuth')) {
            return ConnectApi.CredentialAuthenticationProtocol.OAUTH;
        } else if (protocol.equalsIgnoreCase('AwsSig4')) {
            return ConnectApi.CredentialAuthenticationProtocol.AWSSV4;
        } else if (protocol.equalsIgnoreCase('JWT')) {
            return ConnectApi.CredentialAuthenticationProtocol.JWT;
        } else if (protocol.equalsIgnoreCase('Password')) {
            return ConnectApi.CredentialAuthenticationProtocol.BASIC;
        } else {
            return ConnectApi.CredentialAuthenticationProtocol.CUSTOM;
        }
    }
    
    /**
     * @description Get the authentication protocol variant enum from a string
     * @param variant The variant as a string
     * @return ConnectApi.CredentialAuthenticationProtocolVariant The enum value
     */
    private ConnectApi.CredentialAuthenticationProtocolVariant getAuthProtocolVariantEnum(String variant) {
        if (variant.equalsIgnoreCase('JwtBearer')) {
            return ConnectApi.CredentialAuthenticationProtocolVariant.JwtBearer;
        } else if (variant.equalsIgnoreCase('ClientCredentialsJwtAssertion')) {
            return ConnectApi.CredentialAuthenticationProtocolVariant.ClientCredentialsJwtAssertion;
        } else {
            return null;
        }
    }
    
    /**
     * @description Parameter DTO for External Credential
     */
    public class ParameterDTO {
        public String parameterName { get; set; }
        public String parameterType { get; set; }
        public String parameterValue { get; set; }
        
        /**
         * @description Converts this DTO to a ConnectApi.ExternalCredentialParameterInput
         * @return ConnectApi.ExternalCredentialParameterInput The converted input object
         */
        public ConnectApi.ExternalCredentialParameterInput toConnectApiInput() {
            ConnectApi.ExternalCredentialParameterInput input = new ConnectApi.ExternalCredentialParameterInput();
            input.parameterName = this.parameterName;
            
            // Convert String to enum
            if (this.parameterType != null) {
                input.parameterType = getParameterTypeEnum(this.parameterType);
            }
            
            input.parameterValue = this.parameterValue;
            return input;
        }
        
        /**
         * @description Get the parameter type enum from a string
         * @param paramType The parameter type as a string
         * @return ConnectApi.ExternalCredentialParameterType The enum value
         */
        private ConnectApi.ExternalCredentialParameterType getParameterTypeEnum(String paramType) {
            if (paramType.equalsIgnoreCase('AuthParameter')) {
                return ConnectApi.ExternalCredentialParameterType.AuthParameter;
            } else if (paramType.equalsIgnoreCase('AuthProvider')) {
                return ConnectApi.ExternalCredentialParameterType.AuthProvider;
            } else if (paramType.equalsIgnoreCase('AuthProviderUrl')) {
                return ConnectApi.ExternalCredentialParameterType.AuthProviderUrl;
            } else if (paramType.equalsIgnoreCase('JwtBodyClaim')) {
                return ConnectApi.ExternalCredentialParameterType.JwtBodyClaim;
            } else if (paramType.equalsIgnoreCase('SigningCertificate')) {
                return ConnectApi.ExternalCredentialParameterType.SigningCertificate;
            } else {
                return ConnectApi.ExternalCredentialParameterType.Custom;
            }
        }
    }
    
    /**
     * @description Principal DTO for External Credential
     */
    public class PrincipalDTO {
        public String principalName { get; set; }
        public String principalType { get; set; }
        public Integer sequenceNumber { get; set; }
        
        /**
         * @description Converts this DTO to a ConnectApi.ExternalCredentialPrincipalInput
         * @return ConnectApi.ExternalCredentialPrincipalInput The converted input object
         */
        public ConnectApi.ExternalCredentialPrincipalInput toConnectApiInput() {
            ConnectApi.ExternalCredentialPrincipalInput input = new ConnectApi.ExternalCredentialPrincipalInput();
            input.principalName = this.principalName;
            
            // Convert String to enum
            if (this.principalType != null) {
                input.principalType = getPrincipalTypeEnum(this.principalType);
            }
            
            input.sequenceNumber = this.sequenceNumber;
            return input;
        }
        
        /**
         * @description Get the principal type enum from a string
         * @param principalType The principal type as a string
         * @return ConnectApi.CredentialPrincipalType The enum value
         */
        private ConnectApi.CredentialPrincipalType getPrincipalTypeEnum(String principalType) {
            if (principalType.equalsIgnoreCase('NamedPrincipal')) {
                return ConnectApi.CredentialPrincipalType.NAMEDPRINCIPAL;
            } else if (principalType.equalsIgnoreCase('PerUserPrincipal')) {
                return ConnectApi.CredentialPrincipalType.PERUSERPRINCIPAL;
            } else if (principalType.equalsIgnoreCase('AwsStsPrincipal')) {
                return ConnectApi.CredentialPrincipalType.AWSSTSPRINCIPAL;
            } else {
                // Default to NAMEDPRINCIPAL if not recognized
                return ConnectApi.CredentialPrincipalType.NAMEDPRINCIPAL;
            }
        }
    }
} 