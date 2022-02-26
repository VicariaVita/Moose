trigger CorporationTrigger on Corporation__c (before insert) {

    if (Trigger.isBefore && Trigger.isInsert){
        //SingletonHandlerUtil handlerUtil = new SingletonHandlerUtil(Trigger.new);
        new SingletonHandler(Trigger.new);
    }

}