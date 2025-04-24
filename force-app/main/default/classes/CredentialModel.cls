/**
 * @description Model class for Credential values
 * This class provides a structured way to build credential configurations
 */
public with sharing class CredentialModel {
    
    public String externalCredential { get; set; }
    public String principalName { get; set; }
    public String principalType { get; set; }
    public Map<String, CredentialValueModel> credentials { get; set; }
    
    public CredentialModel() {
        this.credentials = new Map<String, CredentialValueModel>();
    }
    
    /**
     * @description Constructor with external credential and principal information
     * @param externalCredential The external credential developer name
     * @param principalName The principal name
     * @param principalType The principal type
     */
    public CredentialModel(String externalCredential, String principalName, String principalType) {
        this();
        this.externalCredential = externalCredential;
        this.principalName = principalName;
        this.principalType = principalType;
    }
    
    /**
     * @description Adds a credential value
     * @param name The credential name
     * @param value The credential value
     * @param encrypted Whether the value should be encrypted
     * @return CredentialModel This instance for method chaining
     */
    public CredentialModel addCredential(String name, String value, Boolean encrypted) {
        this.credentials.put(name, new CredentialValueModel(value, encrypted));
        return this;
    }
    
    /**
     * @description Converts the model to JSON
     * @return String The JSON representation of the model
     */
    public String toJson() {
        return JSON.serialize(this, true);
    }
    
    /**
     * @description Model for credential values
     */
    public class CredentialValueModel {
        public String value { get; set; }
        public Boolean encrypted { get; set; }
        
        public CredentialValueModel(String value, Boolean encrypted) {
            this.value = value;
            this.encrypted = encrypted;
        }
    }
} 