public with sharing class SingletonHandler {
    private static SingletonHandler instance;

    public static SingletonHandler tryInstance(List<Corporation__c> corps) {
        if (instance == null) {
            instance = new SingletonHandler(corps);
        }
        return instance;
    }

    private SingletonHandler (List<Corporation__c> corps) {
    Director__c[] assignedDirectors =
    [SELECT Id FROM Director__c WHERE Id IN (SELECT Director__c FROM Corporation__c)];

    for (Corporation__c corp : corps){
        for (Director__c curDirector : assignedDirectors){
            if (corp.Director__c == curDirector.Id){
                corp.addError('This director already assigned to other Corp');
            }
        }
    }
    // метод на dml запрос самого себя
    }
}
