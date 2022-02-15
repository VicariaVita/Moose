global class ContactIterator implements Iterator<Contact>{

    List<Contact> contacts{get; set;}
    Integer i {get; set;}

    public ContactIterator(){
        contacts = [SELECT Contact.Account.Id,
            Contact.Account.BillingStreet,
            Contact.Account.BillingCity,
            Contact.Account.BillingState,
            Contact.Account.BillingPostalCode,
            Contact.Account.BillingCountry
            FROM Contact
            WHERE id = '0035j00000INx5OAAT'
            //WHERE Is_Synced__c = false
        ];
        i=0;
    }
  
    global boolean hasNext(){
        if(i >= contacts.size()){
           return false;
        } else {
            return true;
        }
    }

    global Contact next(){
        if (i == contacts.size()) {
            return null;
        }
        i++;
        return contacts[i-1];
    }
}