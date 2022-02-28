
// THIS FROM OTHER ORG

@IsTest
private class AccountServiceTest {

    private final static String URI = 'https://mindful-goat-s44pg1-dev-ed.my.salesforce.com/services/apexrest/Accounts/';
    private final static String headerName = 'Content-Type';
    private final static String headerValue = 'application/json';

    @IsTest
    static void testGetAccount() {

        Id id = createTestRecord().Id;

        makeRequest('GET', URI + id, null, false);
        Account account = AccountService.getAccount();
        
        System.assert(account != null);
        System.assertEquals('Test record', account.Name);
    }

    @IsTest
    static void testCreateAccount() {

        makeRequest('POST', URI, Blob.valueOf(JSON.serialize(new Account(Name = 'test Account'))), true);
        Id id = AccountService.createAccount();

        System.assert(id != null);
        Account account = [SELECT Id, Name FROM Account WHERE Id = :id];
        System.assert(account != null);
        System.assertEquals(account.Name, 'test Account');
    }

    @IsTest
    static void testDeleteAccount() {
        
        Id id = createTestRecord().Id;

        makeRequest('DELETE', URI + id, null, false);
        AccountService.deleteAccount();

        List<Account> accounts = [SELECT Id FROM Account WHERE Id = :id];
        System.assert(accounts.size() == 0);
    }

    @isTest
    static void testUpsertAccount() {

        ID account1Id = AccountService.upsertAccount(null, 'test Acc', 'Warm', 'some.com');
        System.assert(account1Id != null);

        Account account1 = [SELECT Id, Name FROM Account WHERE Id=:account1Id];
        System.assert(account1 != null);
        System.assertEquals(account1.Name, 'test Acc');

        ID account2Id = AccountService.upsertAccount(account1Id, 'test Acc updated', 'Cold', null);

        System.assertEquals(account1Id, account2Id);
        Account account2 = [SELECT Id, Rating FROM Account WHERE Id = :account2Id];
        System.assert(account2 != null);
        System.assertEquals(account2.Rating, 'Cold');
    }

    @IsTest
    static void testUpdateAccount() {
        Account account = createTestRecord();
        account.Name = 'updated Account';

        makeRequest('PATCH', URI, Blob.valueOf(JSON.serialize(account)), TRUE);

        ID id = AccountService.updateFullAccount();

        System.assert(id != null);
        Account updatedAccount = [SELECT Id, Name FROM Account WHERE Id = :id];
        System.assert(updatedAccount != null);
        System.assertEquals(updatedAccount.Name, 'updated Account');
    }  

    private static void makeRequest(String method, String thisUri, Blob body, Boolean header){
        RestRequest request = new RestRequest();
        request.requestUri = thisUri;
        request.httpMethod = method;
        request.requestBody = body;
        if (header) request.addHeader(headerName, headerValue);
        RestContext.request = request;
    }

    private static Account createTestRecord() {
        Account account = new Account(
            Name='Test record',
            Rating='Warm',
            Website='win.com');
        insert account;
        return account;
    }   
}
