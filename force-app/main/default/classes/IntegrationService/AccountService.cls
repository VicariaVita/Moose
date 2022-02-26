//Это веб сервис с орга к которому обращаемся

@RestResource(urlMapping='/Accounts/*')
global class AccountService {

    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String id = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account result =  [SELECT Name, Rating, Website FROM Account WHERE Id = :id];
        return result;
    }

    @HttpPost
    global static ID createAccount() {
        RestRequest request = RestContext.request;

        Account account = (Account)JSON.deserialize(request.requestbody.tostring(), Account.class);
        insert account;
        return account.Id;
    }

    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String id = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account account = [SELECT Id FROM Account WHERE Id = :id];
        delete account;
    }

    // ЧИСТИТ ФИЛД ЕСЛИ ОН НЕ ПЕРЕДАН
    @HttpPut
    global static ID upsertAccount(String id, String name, String rating, String website) {
        Account account = new Account(Id = id, Name = name, Rating = rating, Website = website);
        upsert account;
        return account.Id;
    }

    //НЕ ЧИСТИТ ФИЛД
    //OLD
/*     @HttpPatch
    global static ID updateAccount() {
        RestRequest request = RestContext.request;
        String id = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        Account account = [SELECT Id FROM Account WHERE Id = :id];

        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());

        for(String fieldName : params.keySet()) {
            account.put(fieldName, params.get(fieldName));
        }
        update account;
        return account.Id;
    } */

    @HttpPatch
    global static ID updateFullAccount() {
        RestRequest request = RestContext.request;

        Account account = (Account)JSON.deserialize(request.requestbody.tostring(), Account.class);

        update account;
        return account.Id;
    }
}
