trigger CorporationTrigger on Corporation__c (before insert) {

    SingletonHandler.tryInstance(Trigger.new);

/*     Director__c[] assignedDirectors =
    [SELECT Id FROM Director__c WHERE Id IN (SELECT Director__c FROM Corporation__c)];

    for (Corporation__c corp : Trigger.new){
        for (Director__c curDirector : assignedDirectors){
            if (corp.Director__c == curDirector.Id){
                corp.addError('This director already assigned to other Corp');
            }
        }
    } */

/*     Director__c[] assignedDirectors =
    [SELECT Id FROM Director__c WHERE Id IN (SELECT Director__c FROM Corporation__c)];

    Corporation__c[] tk = new List<Corporation__c>();
    tk = [Select id, Director__r.id from Corporation__c]; //ЧТОТО ОЧЕНЬ ВАЖНОЕ
    System.debug(tk[0]);

    tk.add(new Corporation__c(name='jopa', director__c = 'a095j0000018XW7AAM'));

    for (Corporation__c corp : tk){
        for (Director__c curDirector : assignedDirectors){
            if (corp.director__c == curDirector.Id){
                System.debug(corp.Director__c);
                System.debug(curDirector);
                System.debug('hello');
                System.debug(corp);
                //corp.addError('This director already assigned to other Corp');
            }
        }
    } */

}