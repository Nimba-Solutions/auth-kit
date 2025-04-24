/**
 * @description Service class for managing credentials via the Connect API
 * This class uses DTOs to simplify working with the Connect API
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialService {
    
    /**
     * @description Creates or updates an External Credential using the Connect API
     * @param dto The External Credential DTO
     * @return Object The response from the Connect API
     */
    public static Object upsertExternalCredential(ExternalCredentialDTO dto) {
        try {
            ConnectApi.ExternalCredentialInput input = dto.toConnectApiInput();
            
            // Check if the External Credential already exists
            // If it exists, use update; if not, use create
            try {
                // Try to retrieve the External Credential first
                ConnectApi.NamedCredential.getExternalCredential(input.developerName);
                // If it exists, update it
                return ConnectApi.NamedCredential.updateExternalCredential(input.developerName, input);
            } catch (Exception e) {
                // If it doesn't exist, create it
                return ConnectApi.NamedCredential.createExternalCredential(input);
            }
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error upserting External Credential: ' + e.getMessage());
            throw e;
        }
    }
    
    /**
     * @description Creates or updates an External Credential using JSON
     * @param jsonString JSON string representation of the External Credential
     * @return Object The response from the Connect API
     */
    public static Object upsertExternalCredentialFromJson(String jsonString) {
        ExternalCredentialDTO dto = (ExternalCredentialDTO)JSON.deserialize(
            jsonString,
            ExternalCredentialDTO.class
        );
        return upsertExternalCredential(dto);
    }
    
    /**
     * @description Populates credential values for an External Credential
     * @param dto The Credential DTO
     * @return Object The response from the Connect API
     */
    public static Object populateCredential(CredentialDTO dto) {
        try {
            ConnectApi.CredentialInput input = dto.toConnectApiInput();
            
            // Use the ConnectApi to set the credential
            return ConnectApi.NamedCredential.setCredential(input);
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error creating Credential: ' + e.getMessage());
            throw e;
        }
    }
    
    /**
     * @description Populates credential values using JSON
     * @param jsonString JSON string representation of the Credential
     * @return Object The response from the Connect API
     */
    public static Object populateCredentialFromJson(String jsonString) {
        CredentialDTO dto = (CredentialDTO)JSON.deserialize(
            jsonString,
            CredentialDTO.class
        );
        return populateCredential(dto);
    }
} 