public with sharing class TodoController {

    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodoList() {
        return [SELECT
                    Id,
                    Name,
                    Description__c,
                    CreatedDate,
                    Category__c,
                    Priority__c,
                    Completed__c,
                    Image__c
                FROM Todo__c
                WITH SECURITY_ENFORCED
                LIMIT 50
                ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getFilteredTodoList(String category,
                                                    String priority,
                                                    Boolean completed) {

/* String category = 'Tomorrow';
String priority = 'High';
Boolean completed = true; */

        String whereQuery = ' ';

        
        if (category != null) {
            whereQuery = 'category__c = \'' + category + '\' ';
        }
        if (priority != null) {
            whereQuery = whereQuery + (String.isBlank(whereQuery) ? 'priority__c = \'' + priority + '\' '
                            : 'and priority__c = \'' + priority + '\' ');
        }
        if (completed != null) {
            whereQuery = whereQuery + (String.isBlank(whereQuery) ? 'completed__c = ' + completed + ' '
                            : 'and completed__c = ' + completed + ' ');
        }

        String test = 'SELECT Id, Name, Description__c, CreatedDate, Category__c, Priority__c, Completed__c, Image__c ' +
        'FROM Todo__c ' +
        'WHERE ' + whereQuery +
        'WITH SECURITY_ENFORCED ' +
        'LIMIT 50';

        if (whereQuery != ' ') {
            return Database.query('SELECT Id, Name, Description__c, CreatedDate, Category__c, Priority__c, Completed__c, Image__c ' +
            'FROM Todo__c ' +
            'WHERE ' + whereQuery +
            'WITH SECURITY_ENFORCED ' +
            'LIMIT 50');
        } else {
            return [
                SELECT Id, Name, Description__c, CreatedDate, Category__c, Priority__c, Completed__c, Image__c
                FROM Todo__c
                WITH SECURITY_ENFORCED
                LIMIT 50
            ];
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Todo__c> searchTodo(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Description__c, CreatedDate, Category__c, Priority__c, Completed__c, Image__c
            FROM Todo__c
            WHERE Name LIKE :key
            WITH SECURITY_ENFORCED
            LIMIT 50
        ];
    }
}
