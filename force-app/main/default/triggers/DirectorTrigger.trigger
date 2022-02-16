trigger DirectorTrigger on Director__c (after update) {

    if (Trigger.new[0].Is_Assigned__c && !Trigger.old[0].Is_Assigned__c){
        Director__c director = new Director__c(name = 'i shouldnt exist FROM DIR TRIGGER');
        System.debug('dir Trigger here');
        insert director;
        Corporation__c corp = new Corporation__c(Name = 'new corp FROM DIR TRIGGER', Director__c = director.Id);
        insert corp;
    }

}