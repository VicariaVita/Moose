@IsTest
private class AccountCalloutsTest {
    @IsTest
    static void testGet(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('AccountGetMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);

        HttpResponse result = AccountCallouts.getAccountById('some Id');
        
        System.assertNotEquals(null, result);
        System.assertEquals(200, result.getStatusCode());
        System.assertEquals('application/json;charset=UTF-8', result.getHeader('Content-Type'));
        Account account = (Account) JSON.deserialize(result.getBody(), Type.forName('Account'));
        System.assertEquals(account.Name, 'United Oil & Gas Corp.');

    }

    @IsTest
    static void testPost(){
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock()); 
        HttpResponse response = AccountCallouts.createAccount(new Account(Name = 'test'));
        System.assertEquals(response.getStatusCode(), 200);
        System.assertEquals(response.getHeader('Content-Type'), 'application/json');
        System.assertEquals(response.getBody(), 'ID');
    }
}
