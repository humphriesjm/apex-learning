@isTest
public class SecondTestRejectDoubleBooking {
	// check for good scenario
    static testmethod void TestSingleBooking() {
        Datetime now = System.now();
        
        Speaker__c speaker = new Speaker__c(First_Name__c = 'John', Last_Name__c = 'Smith');
        
        insert speaker;
        
        session__c session = new session__c(name = 'HR Session', session_date__c = now);
        insert session;
        
        session_speaker__c assignment = 
            new session_speaker__c(session__c = session.id, speaker__c = speaker.id);
        Test.startTest();
        Database.SaveResult result = Database.insert(assignment, false);
        Test.stopTest();
        
        System.assert(result.isSuccess());	    
    }
    
    static testmethod void TestDoubleBooking() {
        Datetime now = System.now();
        
        Speaker__c speaker = new Speaker__c(First_Name__c = 'John', Last_Name__c = 'Smith');
        insert speaker;
        
        session__c session1 = new session__c(name = 'Engineering Session 1', session_date__c = now);
        insert session1;
        
        session__c session2 = new session__c(name = 'Engineering Session 2', session_date__c = now);
        insert session2;
        
        session_speaker__c assignment1 = new session_speaker__c(session__c = session1.id, speaker__c = speaker.id);
		insert assignment1;
        
        session_speaker__c assignment2 = new session_speaker__c(session__c = session2.id, speaker__c = speaker.id);
        
        Test.startTest();
        Database.SaveResult result2 = Database.insert(assignment2, false);
        Test.stopTest();
        
        System.assert(!result2.isSuccess());	    
    }
}