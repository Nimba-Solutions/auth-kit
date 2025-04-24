/**
 * @description Model class for External Credential
 * This class provides a structured way to build External Credential configurations
 */
public with sharing class ExternalCredentialModel {
    
    public String developerName { get; set; }
    public String masterLabel { get; set; }
    public String authenticationProtocol { get; set; }
    public String authenticationProtocolVariant { get; set; }
    public List<ParameterModel> parameters { get; set; }
    public List<PrincipalModel> principals { get; set; }
    
    public ExternalCredentialModel() {
        this.parameters = new List<ParameterModel>();
        this.principals = new List<PrincipalModel>();
    }
    
    /**
     * @description Adds a parameter to the External Credential
     * @param name The parameter name
     * @param type The parameter type
     * @param value The parameter value
     * @return ExternalCredentialModel This instance for method chaining
     */
    public ExternalCredentialModel addParameter(String name, String type, String value) {
        this.parameters.add(new ParameterModel(name, type, value));
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
        this.principals.add(new PrincipalModel(name, type, sequenceNumber));
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
     * @description Parameter model for External Credential
     */
    public class ParameterModel {
        public String parameterName { get; set; }
        public String parameterType { get; set; }
        public String parameterValue { get; set; }
        
        public ParameterModel(String name, String type, String value) {
            this.parameterName = name;
            this.parameterType = type;
            this.parameterValue = value;
        }
    }
    
    /**
     * @description Principal model for External Credential
     */
    public class PrincipalModel {
        public String principalName { get; set; }
        public String principalType { get; set; }
        public Integer sequenceNumber { get; set; }
        
        public PrincipalModel(String name, String type, Integer sequenceNumber) {
            this.principalName = name;
            this.principalType = type;
            this.sequenceNumber = sequenceNumber;
        }
    }
} 