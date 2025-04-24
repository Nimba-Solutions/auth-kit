/**
 * @description Service class for managing credentials via the Connect API
 * This class uses ConnectApi classes to work with credentials
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialService {
    
    /**
     * @description Creates or updates an External Credential using the Connect API
     * @param externalCredentialInput The External Credential input object
     * @return ConnectApi.ExternalCredentialRepresentation The response from the Connect API
     */
    public static ConnectApi.ExternalCredentialRepresentation upsertExternalCredential(ConnectApi.ExternalCredentialInput externalCredentialInput) {
        try {
            // Use the ConnectApi to create or update the external credential
            return ConnectApi.NamedCredential.updateExternalCredential(
                externalCredentialInput.developerName,
                externalCredentialInput
            );
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error upserting External Credential: ' + e.getMessage());
            throw e;
        }
    }
    
    /**
     * @description Populates credential values for an External Credential
     * @param credentialInput The credential input object
     * @return ConnectApi.CredentialRepresentation The response from the Connect API
     */
    public static ConnectApi.CredentialRepresentation populateCredential(ConnectApi.CredentialInput credentialInput) {
        try {
            // Use the ConnectApi to create the credential
            return ConnectApi.NamedCredential.createCredential(credentialInput);
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error creating Credential: ' + e.getMessage());
            throw e;
        }
    }
} 