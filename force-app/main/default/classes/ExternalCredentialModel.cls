/**
 * @description Builder class for External Credential using ConnectApi classes
 * This class provides a fluent interface for building External Credential inputs
 */
public with sharing class ExternalCredentialModel {
    
    private ConnectApi.ExternalCredentialInput externalCredentialInput;
    
    /**
     * @description Constructor
     */
    public ExternalCredentialModel() {
        this.externalCredentialInput = new ConnectApi.ExternalCredentialInput();
        this.externalCredentialInput.parameters = new List<ConnectApi.ExternalCredentialParameterInput>();
        this.externalCredentialInput.principals = new List<ConnectApi.ExternalCredentialPrincipalInput>();
    }
    
    /**
     * @description Sets the developer name
     * @param developerName The developer name
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel setDeveloperName(String developerName) {
        this.externalCredentialInput.developerName = developerName;
        return this;
    }
    
    /**
     * @description Sets the master label
     * @param masterLabel The master label
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel setMasterLabel(String masterLabel) {
        this.externalCredentialInput.masterLabel = masterLabel;
        return this;
    }
    
    /**
     * @description Sets the authentication protocol
     * @param authProtocol The authentication protocol
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel setAuthenticationProtocol(String authProtocol) {
        this.externalCredentialInput.authenticationProtocol = authProtocol;
        return this;
    }
    
    /**
     * @description Sets the authentication protocol variant
     * @param authProtocolVariant The authentication protocol variant
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel setAuthenticationProtocolVariant(String authProtocolVariant) {
        this.externalCredentialInput.authenticationProtocolVariant = authProtocolVariant;
        return this;
    }
    
    /**
     * @description Adds a parameter to the External Credential
     * @param name The parameter name
     * @param type The parameter type
     * @param value The parameter value
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel addParameter(String name, String type, String value) {
        ConnectApi.ExternalCredentialParameterInput parameter = new ConnectApi.ExternalCredentialParameterInput();
        parameter.parameterName = name;
        parameter.parameterType = type;
        parameter.parameterValue = value;
        
        this.externalCredentialInput.parameters.add(parameter);
        return this;
    }
    
    /**
     * @description Adds a principal to the External Credential
     * @param name The principal name
     * @param type The principal type
     * @param sequenceNumber The sequence number
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel addPrincipal(String name, String type, Integer sequenceNumber) {
        ConnectApi.ExternalCredentialPrincipalInput principal = new ConnectApi.ExternalCredentialPrincipalInput();
        principal.principalName = name;
        principal.principalType = type;
        principal.sequenceNumber = sequenceNumber;
        
        this.externalCredentialInput.principals.add(principal);
        return this;
    }
    
    /**
     * @description Builds the ConnectApi.ExternalCredentialInput
     * @return ConnectApi.ExternalCredentialInput The built External Credential input
     */
    public ConnectApi.ExternalCredentialInput build() {
        return this.externalCredentialInput;
    }
} 