/**
 * @description Builder class for Credential using ConnectApi classes
 * This class provides a fluent interface for building Credential inputs
 */
public with sharing class CredentialModel {
    
    private ConnectApi.CredentialInput credentialInput;
    
    /**
     * @description Constructor
     */
    public CredentialModel() {
        this.credentialInput = new ConnectApi.CredentialInput();
        this.credentialInput.credentials = new Map<String, ConnectApi.CredentialValueInput>();
    }
    
    /**
     * @description Constructor with external credential and principal information
     * @param externalCredential The external credential developer name
     * @param principalName The principal name
     * @param principalType The principal type
     */
    public CredentialModel(String externalCredential, String principalName, String principalType) {
        this();
        this.credentialInput.externalCredential = externalCredential;
        this.credentialInput.principalName = principalName;
        this.credentialInput.principalType = principalType;
    }
    
    /**
     * @description Sets the external credential name
     * @param externalCredential The external credential name
     * @return CredentialModel This instance for method chaining
     */
    public CredentialModel setExternalCredential(String externalCredential) {
        this.credentialInput.externalCredential = externalCredential;
        return this;
    }
    
    /**
     * @description Sets the principal name
     * @param principalName The principal name
     * @return CredentialModel This instance for method chaining
     */
    public CredentialModel setPrincipalName(String principalName) {
        this.credentialInput.principalName = principalName;
        return this;
    }
    
    /**
     * @description Sets the principal type
     * @param principalType The principal type
     * @return CredentialModel This instance for method chaining
     */
    public CredentialModel setPrincipalType(String principalType) {
        this.credentialInput.principalType = principalType;
        return this;
    }
    
    /**
     * @description Adds a credential value
     * @param name The credential name
     * @param value The credential value
     * @param encrypted Whether the value should be encrypted
     * @return CredentialModel This instance for method chaining
     */
    public CredentialModel addCredential(String name, String value, Boolean encrypted) {
        ConnectApi.CredentialValueInput credValue = new ConnectApi.CredentialValueInput();
        credValue.value = value;
        credValue.encrypted = encrypted;
        
        this.credentialInput.credentials.put(name, credValue);
        return this;
    }
    
    /**
     * @description Builds the ConnectApi.CredentialInput
     * @return ConnectApi.CredentialInput The built Credential input
     */
    public ConnectApi.CredentialInput build() {
        return this.credentialInput;
    }
} 