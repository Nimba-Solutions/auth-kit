/**
 * @description Service class for managing credentials via the Connect API
 * This class transforms JSON into proper Connect API calls
 * Based on examples from https://gist.github.com/rossbelmont/b797c1871dd1187657db81cf1431b755
 */
public with sharing class CredentialService {
    
    private static final String CONNECT_API_BASE_PATH = '/services/data/v60.0/named-credentials/';
    
    /**
     * @description Creates or updates an External Credential using the Connect API
     * @param externalCredentialName The developer name of the External Credential
     * @param jsonConfig The JSON configuration for the External Credential
     * @return HttpResponse The response from the Connect API
     */
    public static HttpResponse upsertExternalCredential(String externalCredentialName, String jsonConfig) {
        String endpoint = CONNECT_API_BASE_PATH + 'external-credentials/' + externalCredentialName;
        return makeConnectApiRequest('PUT', endpoint, jsonConfig);
    }
    
    /**
     * @description Populates credential values for an External Credential
     * @param credentialJson The JSON containing credential values
     * @return HttpResponse The response from the Connect API
     */
    public static HttpResponse populateCredential(String credentialJson) {
        String endpoint = CONNECT_API_BASE_PATH + 'credential/';
        return makeConnectApiRequest('POST', endpoint, credentialJson);
    }
    
    /**
     * @description Makes an HTTP request to the Connect API
     * @param method The HTTP method (GET, POST, PUT, DELETE)
     * @param endpoint The endpoint to call
     * @param jsonBody The JSON body to send
     * @return HttpResponse The response from the Connect API
     */
    private static HttpResponse makeConnectApiRequest(String method, String endpoint, String jsonBody) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + endpoint);
        req.setMethod(method);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        
        if (jsonBody != null) {
            req.setBody(jsonBody);
        }
        
        Http http = new Http();
        return http.send(req);
    }
} 