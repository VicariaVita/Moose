trigger AccountTrigger on Account (after update, after insert, before insert) {

    if (Trigger.isAfter && Trigger.isUpdate){
        //AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isInsert){
        //кэлаут
        AccountTriggerHandler.afterInsert(Trigger.new);
    }

}