public with sharing class SingletonHandlerUtil {

    SingletonHandler handler;

    public SingletonHandlerUtil(List<Corporation__c> corps) {
        this.handler = SingletonHandler.getInstance(corps);
    }
}
