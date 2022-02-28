trigger AccountTrigger on Account (after update, after insert, before insert) {

    if (Trigger.isAfter && Trigger.isUpdate){
        AccountTriggerHandler.afterUpdate(Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isInsert){
        //кэлаут (тесты ругаются!)
        //AccountTriggerHandler.afterInsert(Trigger.new);
    }

}