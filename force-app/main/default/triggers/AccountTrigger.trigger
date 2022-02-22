trigger AccountTrigger on Account (after update) {

    if (Trigger.isAfter && Trigger.isUpdate){
        AccountTriggerHandler.afterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
        // trigger old no need
    }

}