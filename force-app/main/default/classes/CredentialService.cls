/**
 * @description Service class for managing credentials via the Connect API
 * This class uses DTOs to simplify working with the Connect API
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialService {
    
    /**
     * @description Creates or updates an External Credential using the Connect API
     * @param dto The External Credential DTO
     * @return ConnectApi.ExternalCredentialRepresentation The response from the Connect API
     */
    public static ConnectApi.ExternalCredentialRepresentation upsertExternalCredential(ExternalCredentialDTO dto) {
        try {
            ConnectApi.ExternalCredentialInput input = dto.toConnectApiInput();
            
            // Use the ConnectApi to create or update the external credential
            return ConnectApi.NamedCredential.updateExternalCredential(
                input.developerName,
                input
            );
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error upserting External Credential: ' + e.getMessage());
            throw e;
        }
    }
    
    /**
     * @description Creates or updates an External Credential using JSON
     * @param jsonString JSON string representation of the External Credential
     * @return ConnectApi.ExternalCredentialRepresentation The response from the Connect API
     */
    public static ConnectApi.ExternalCredentialRepresentation upsertExternalCredentialFromJson(String jsonString) {
        ExternalCredentialDTO dto = (ExternalCredentialDTO)JSON.deserialize(
            jsonString,
            ExternalCredentialDTO.class
        );
        return upsertExternalCredential(dto);
    }
    
    /**
     * @description Populates credential values for an External Credential
     * @param dto The Credential DTO
     * @return ConnectApi.CredentialRepresentation The response from the Connect API
     */
    public static ConnectApi.CredentialRepresentation populateCredential(CredentialDTO dto) {
        try {
            ConnectApi.CredentialInput input = dto.toConnectApiInput();
            
            // Use the ConnectApi to create the credential
            return ConnectApi.NamedCredential.createCredential(input);
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error creating Credential: ' + e.getMessage());
            throw e;
        }
    }
    
    /**
     * @description Populates credential values using JSON
     * @param jsonString JSON string representation of the Credential
     * @return ConnectApi.CredentialRepresentation The response from the Connect API
     */
    public static ConnectApi.CredentialRepresentation populateCredentialFromJson(String jsonString) {
        CredentialDTO dto = (CredentialDTO)JSON.deserialize(
            jsonString,
            CredentialDTO.class
        );
        return populateCredential(dto);
    }
} 