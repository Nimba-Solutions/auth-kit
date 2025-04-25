/**
 * @description Data Transfer Object for Credential
 * This class can be directly deserialized from JSON
 */
public class CredentialDTO {
    public String externalCredential { get; set; }
    public String principalName { get; set; }
    public String principalType { get; set; }
    public Map<String, CredentialValueDTO> credentials { get; set; }
    
    public CredentialDTO() {
        this.credentials = new Map<String, CredentialValueDTO>();
    }
    
    /**
     * @description Converts this DTO to a ConnectApi.CredentialInput
     * @return ConnectApi.CredentialInput The converted input object
     */
    public ConnectApi.CredentialInput toConnectApiInput() {
        ConnectApi.CredentialInput input = new ConnectApi.CredentialInput();
        input.externalCredential = this.externalCredential;
        input.principalName = this.principalName;
        
        // Convert String to enum
        if (this.principalType != null) {
            input.principalType = getPrincipalTypeEnum(this.principalType);
        }
        
        input.credentials = new Map<String, ConnectApi.CredentialValueInput>();
        if (this.credentials != null) {
            for (String key : this.credentials.keySet()) {
                input.credentials.put(key, this.credentials.get(key).toConnectApiInput());
            }
        }
        
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
    
    /**
     * @description Credential Value DTO for Credential
     */
    public class CredentialValueDTO {
        public String value { get; set; }
        public Boolean encrypted { get; set; }
        
        /**
         * @description Converts this DTO to a ConnectApi.CredentialValueInput
         * @return ConnectApi.CredentialValueInput The converted input object
         */
        public ConnectApi.CredentialValueInput toConnectApiInput() {
            ConnectApi.CredentialValueInput input = new ConnectApi.CredentialValueInput();
            input.value = this.value;
            input.encrypted = this.encrypted;
            return input;
        }
    }
} 