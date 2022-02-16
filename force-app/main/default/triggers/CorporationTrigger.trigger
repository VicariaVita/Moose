trigger CorporationTrigger on Corporation__c (before insert, after update) {

    if (Trigger.isBefore && Trigger.isInsert){
        SingletonHandlerUtil handlerUtil = new SingletonHandlerUtil(Trigger.new);
    }

}