public with sharing class AccountCallouts {
    

    public Account getAccountById(String id) {
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        request.setEndpoint('callout:MooseAPI/services/apexrest/Accounts/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        System.debug(response.getStatusCode());
        Account account = (Account) JSON.deserialize(response.getBody(), Type.forName('Account'));
        return account;
    }

    public String createAccount(String name, String rating, String website){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:MooseAPI/services/apexrest/Accounts/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
/*         request.setBody('{"name":"' + name +
                '", "website":"' + website +
                '", "rating":"' + rating + 
                '"}'); */
        request.setBody(String.format('\'{\'"name":"{0}", "website":"{1}", "rating":"{2}"\'}\'',
                                    new String[]{name, website, rating}));
        HttpResponse response = http.send(request);

        //не возвращает 201! просто 200
        System.debug(response.getStatusCode());

        //String id = (String)JSON.deserialize(response.getBody(), String);
        //Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        //String id = m.get('id');
        return response.getBody();

    }

    public void deleteAccount(String id){
        HttpRequest request = new HttpRequest();
        Http http = new Http();
        request.setEndpoint('callout:MooseAPI/services/apexrest/Accounts/' + id);
        request.setMethod('DELETE');
        HttpResponse response = http.send(request);

        System.debug(response.getStatusCode());
    }

    public void upsertAccount(String id, String name, String rating){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:MooseAPI/services/apexrest/Accounts/');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(String.format('\'{\'"name":"{0}", "rating":"{1}", "id":"{2}"\'}\'',
                                        new String[]{name, rating, id}));
        HttpResponse response = http.send(request);

        System.debug(response.getStatusCode());
    }
    
/*     public void updateAccount(String id, String name, String website){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:MooseAPI/services/apexrest/Accounts/' + id);
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(String.format('\'{\'"name":"{0}", "website":"{1}"\'}\'',
                                        new String[]{name, website}));
        HttpResponse response = http.send(request);

        System.debug(response.getStatusCode());
    } */

    public void updateFullAccount(Account account){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:MooseAPI/services/apexrest/Accounts/');
        request.setMethod('PATCH');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');

        Map<String, Object> mapToGo = new Map<String, Object>();
        mapToGo.put('Account', account);
        String serialized = JSON.serialize(mapToGo);
        
        request.setBody(serialized);

        HttpResponse response = http.send(request);

        System.debug(response.getStatusCode());

    }
}
