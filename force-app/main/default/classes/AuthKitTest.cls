/**
 * @description Test class for AuthKitUtility
 */
@IsTest
private class AuthKitTest {
    
    /**
     * @description Set up mock response for HTTP callouts
     */
    private class MockHttpResponse implements HttpCalloutMock {
        private Integer statusCode;
        private String status;
        private String body;
        
        public MockHttpResponse(Integer statusCode, String status, String body) {
            this.statusCode = statusCode;
            this.status = status;
            this.body = body;
        }
        
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(statusCode);
            res.setStatus(status);
            res.setBody(body);
            return res;
        }
    }
    
    /**
     * @description Test GET request
     */
    @IsTest
    static void testGet() {
        // Set up mock response
        String mockResponseBody = '{"records":[{"Id":"001xx000003DGb2AAG","Name":"Test Account 1"},{"Id":"001xx000003DGb3AAG","Name":"Test Account 2"}]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(200, 'OK', mockResponseBody));
        
        // Call method
        Test.startTest();
        HttpResponse res = AuthKitUtility.get('/services/data/v59.0/query?q=SELECT+Id,Name+FROM+Account');
        Test.stopTest();
        
        // Verify response
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('OK', res.getStatus());
        System.assertEquals(mockResponseBody, res.getBody());
    }
    
    /**
     * @description Test POST request
     */
    @IsTest
    static void testPost() {
        // Set up mock response
        String mockResponseBody = '{"id":"001xx000003DGb4AAG","success":true,"errors":[]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(201, 'Created', mockResponseBody));
        
        // Call method
        Test.startTest();
        HttpResponse res = AuthKitUtility.post('/services/data/v59.0/sobjects/Account', '{"Name":"Test Account"}');
        Test.stopTest();
        
        // Verify response
        System.assertEquals(201, res.getStatusCode());
        System.assertEquals('Created', res.getStatus());
        System.assertEquals(mockResponseBody, res.getBody());
    }
    
    /**
     * @description Test PATCH request
     */
    @IsTest
    static void testPatch() {
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(204, 'No Content', ''));
        
        // Call method
        Test.startTest();
        HttpResponse res = AuthKitUtility.patch('/services/data/v59.0/sobjects/Account/001xx000003DGb2AAG', '{"Name":"Updated Account"}');
        Test.stopTest();
        
        // Verify response
        System.assertEquals(204, res.getStatusCode());
        System.assertEquals('No Content', res.getStatus());
    }
    
    /**
     * @description Test DELETE request
     */
    @IsTest
    static void testDelete() {
        // Set up mock response
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(204, 'No Content', ''));
        
        // Call method
        Test.startTest();
        HttpResponse res = AuthKitUtility.del('/services/data/v59.0/sobjects/Account/001xx000003DGb2AAG');
        Test.stopTest();
        
        // Verify response
        System.assertEquals(204, res.getStatusCode());
        System.assertEquals('No Content', res.getStatus());
    }
    
    /**
     * @description Test getAccounts method
     */
    @IsTest
    static void testGetAccounts() {
        // Set up mock response
        String mockResponseBody = '{"records":[{"Id":"001xx000003DGb2AAG","Name":"Test Account 1"},{"Id":"001xx000003DGb3AAG","Name":"Test Account 2"}]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(200, 'OK', mockResponseBody));
        
        // Call method
        Test.startTest();
        List<Account> accounts = AuthKitUtility.getAccounts();
        Test.stopTest();
        
        // Verify response
        System.assertEquals(2, accounts.size());
        System.assertEquals('001xx000003DGb2AAG', accounts[0].Id);
        System.assertEquals('Test Account 1', accounts[0].Name);
        System.assertEquals('001xx000003DGb3AAG', accounts[1].Id);
        System.assertEquals('Test Account 2', accounts[1].Name);
    }
    
    /**
     * @description Test createAccount method
     */
    @IsTest
    static void testCreateAccount() {
        // Set up mock response
        String mockResponseBody = '{"id":"001xx000003DGb4AAG","success":true,"errors":[]}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(201, 'Created', mockResponseBody));
        
        // Call method
        Test.startTest();
        String accountId = AuthKitUtility.createAccount('Test Account');
        Test.stopTest();
        
        // Verify response
        System.assertEquals('001xx000003DGb4AAG', accountId);
    }
    
    /**
     * @description Test error handling in getAccounts
     */
    @IsTest
    static void testGetAccountsError() {
        // Set up mock response
        String mockResponseBody = '{"error":"Invalid Session ID","errorCode":"INVALID_SESSION_ID"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(401, 'Unauthorized', mockResponseBody));
        
        // Call method
        Test.startTest();
        List<Account> accounts = AuthKitUtility.getAccounts();
        Test.stopTest();
        
        // Verify response
        System.assertEquals(0, accounts.size());
    }
    
    /**
     * @description Test error handling in createAccount
     */
    @IsTest
    static void testCreateAccountError() {
        // Set up mock response
        String mockResponseBody = '{"error":"Required fields are missing","errorCode":"REQUIRED_FIELD_MISSING"}';
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse(400, 'Bad Request', mockResponseBody));
        
        // Call method
        Test.startTest();
        String accountId = AuthKitUtility.createAccount('');
        Test.stopTest();
        
        // Verify response
        System.assertEquals(null, accountId);
    }
} 