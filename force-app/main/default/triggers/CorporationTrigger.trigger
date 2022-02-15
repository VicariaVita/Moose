trigger CorporationTrigger on Corporation__c (before insert) {

    SingletonHandler.tryInstance(Trigger.new);

}