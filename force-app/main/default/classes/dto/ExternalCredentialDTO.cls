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
        input.authenticationProtocol = this.authenticationProtocol;
        input.authenticationProtocolVariant = this.authenticationProtocolVariant;
        
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
            input.parameterType = this.parameterType;
            input.parameterValue = this.parameterValue;
            return input;
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
            input.principalType = this.principalType;
            input.sequenceNumber = this.sequenceNumber;
            return input;
        }
    }
} 