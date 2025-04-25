/**
 * @description Utility class for making authenticated API calls back to the same org
 * Uses JWT Bearer authentication via the AuthKit Named Credential
 */
public with sharing class AuthKitUtility {
    
    /**
     * @description Make a callout to the current org's REST API
     * @param path The path to call (e.g., /services/data/v59.0/sobjects/Account)
     * @param method HTTP method (GET, POST, PATCH, DELETE)
     * @param requestBody Optional request body for POST/PATCH requests
     * @return HttpResponse The response from the API
     */
    public static HttpResponse callOrg(String path, String method, String requestBody) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:AuthKit' + path);
        req.setMethod(method);
        
        // Set content type for requests with a body
        if (String.isNotBlank(requestBody)) {
            req.setHeader('Content-Type', 'application/json');
            req.setBody(requestBody);
        }
        
        // Add any useful headers
        req.setHeader('Sforce-Call-Options', 'client=AuthKit');
        
        // Send the request
        Http http = new Http();
        return http.send(req);
    }
    
    /**
     * @description Make a GET request to the current org's REST API
     * @param path The path to call (e.g., /services/data/v59.0/sobjects/Account)
     * @return HttpResponse The response from the API
     */
    public static HttpResponse get(String path) {
        return callOrg(path, 'GET', null);
    }
    
    /**
     * @description Make a POST request to the current org's REST API
     * @param path The path to call (e.g., /services/data/v59.0/sobjects/Account)
     * @param jsonBody The JSON request body
     * @return HttpResponse The response from the API
     */
    public static HttpResponse post(String path, String jsonBody) {
        return callOrg(path, 'POST', jsonBody);
    }
    
    /**
     * @description Make a PATCH request to the current org's REST API
     * @param path The path to call (e.g., /services/data/v59.0/sobjects/Account/001xx000003DGb2AAG)
     * @param jsonBody The JSON request body
     * @return HttpResponse The response from the API
     */
    public static HttpResponse patch(String path, String jsonBody) {
        return callOrg(path, 'PATCH', jsonBody);
    }
    
    /**
     * @description Make a DELETE request to the current org's REST API
     * @param path The path to call (e.g., /services/data/v59.0/sobjects/Account/001xx000003DGb2AAG)
     * @return HttpResponse The response from the API
     */
    public static HttpResponse del(String path) {
        return callOrg(path, 'DELETE', null);
    }
    
    /**
     * @description Example method to query accounts
     * @return List<Account> List of accounts
     */
    public static List<Account> getAccounts() {
        HttpResponse res = get('/services/data/v59.0/query?q=' + 
                               EncodingUtil.urlEncode('SELECT Id, Name FROM Account LIMIT 10', 'UTF-8'));
        
        if (res.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            List<Object> records = (List<Object>)results.get('records');
            
            List<Account> accounts = new List<Account>();
            for (Object record : records) {
                Map<String, Object> accountMap = (Map<String, Object>)record;
                Account acc = new Account();
                acc.Id = (String)accountMap.get('Id');
                acc.Name = (String)accountMap.get('Name');
                accounts.add(acc);
            }
            
            return accounts;
        } else {
            System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            System.debug('Response: ' + res.getBody());
            return new List<Account>();
        }
    }
    
    /**
     * @description Example method to create an account
     * @param name Account name
     * @return String The ID of the created account, or null if creation failed
     */
    public static String createAccount(String name) {
        String body = '{"Name":"' + name + '"}';
        HttpResponse res = post('/services/data/v59.0/sobjects/Account', body);
        
        if (res.getStatusCode() == 201) {
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            return (String)results.get('id');
        } else {
            System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            System.debug('Response: ' + res.getBody());
            return null;
        }
    }
} 