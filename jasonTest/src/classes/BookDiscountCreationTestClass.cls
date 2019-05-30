@IsTest
public class BookDiscountCreationTestClass {
    static testMethod void validateHelloWorld() {
        integer beforePrice = 50;
        double afterPrice = beforePrice * 0.9;
    	Book__c b = new Book__c(Name = 'Advanced Apex Programming', Price__c = beforePrice);
    	System.debug('Price before inserting new book: ' + b.Price__c);
    	
    	insert b;
    	
    	b = [select Price__c from Book__c where iD = : b.Id];
    	System.assertEquals(afterPrice, b.Price__c);
    }
}