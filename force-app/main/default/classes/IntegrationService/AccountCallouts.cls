public with sharing class AccountCallouts {
    
    private final static String callout = 'callout:MooseAPI/services/apexrest/Accounts/';
    private final static String header = 'Content-Type';
    private final static String headerType = 'application/json;charset=UTF-8';

    public static HttpResponse getAccountById(String id) {
        HttpResponse response = sendRequest('GET', callout + id);
        //Account account = (Account) JSON.deserialize(response.getBody(), Type.forName('Account'));
        return response;
    }

    public static HttpResponse createAccount(Account account){
        return sendRequest('POST', callout, JSON.serialize(account));
    }

    public static HttpResponse deleteAccount(String id){
        return sendRequest('DELETE', callout + id);
    }

    public static HttpResponse upsertAccount(Account account){
        return sendRequest('PUT', callout, JSON.serialize(account));
    }

    public static HttpResponse updateAccount(Account account){
        return sendRequest('PATCH', callout, JSON.serialize(account));
    }

    private static HttpResponse sendRequest(String method, String endPoint, String body){
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setEndpoint(endPoint);
        request.setHeader(header, headerType);

        if (String.isNotBlank(body)) request.setBody(body);

        Http http = new Http();
        HttpResponse response = http.send(request);

        if(response.getStatusCode()!=200){
            System.debug('ERROR Send Request - Status Code: ' + response.getStatusCode());
            throw new MyRestException(response.getStatus());
        }
        return response;

    }

    // почему просто Null не передавать методу выше
    private static HttpResponse sendRequest(String method, String endPoint){
        return sendRequest(method, endPoint, null);
    }

    private class MyRestException  extends Exception {}
}
