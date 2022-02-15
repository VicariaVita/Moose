global class ContactIterable implements Iterable<Contact>{
    global Iterator<Contact> Iterator(){ 
        return new ContactIterator();
    }
}
