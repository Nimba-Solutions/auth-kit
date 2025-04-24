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
        input.principalType = this.principalType;
        
        input.credentials = new Map<String, ConnectApi.CredentialValueInput>();
        if (this.credentials != null) {
            for (String key : this.credentials.keySet()) {
                input.credentials.put(key, this.credentials.get(key).toConnectApiInput());
            }
        }
        
        return input;
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