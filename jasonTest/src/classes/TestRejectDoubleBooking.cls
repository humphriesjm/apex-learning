@isTest
public class TestRejectDoubleBooking {
	// check for good scenario
	static testmethod void TestSingleBooking() {
		
		Datetime now = System.now();
		
		Speaker__c speaker = new Speaker__c(First_Name__c = 'John', Last_Name__c = 'Smith');
		
		insert speaker;
		
		session__c session = new session__c(name = 'HR Session', session_date__c = now);
		insert session;
		
		session_speaker__c assignment = new session_speaker__c(session__c = session.id, speaker__c = speaker.id);
		Test.startTest();
		Database.SaveResult result = Database.insert(assignment, false);
		Test.stopTest();
		
		System.assert(result.isSuccess());
	}
}