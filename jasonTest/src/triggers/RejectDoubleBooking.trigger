trigger RejectDoubleBooking on Session_Speaker__c (before insert, before update) {
	for (session_speaker__c sessionSpeaker : trigger.new) {
		// retrieve session info
		session__c session = [select id, session_date__c 
								from session__c
								where id = :sessionSpeaker.session__c];
		
		// retrieve conflicts: other assignments for that speaker at the same time
		List<session_speaker__c> conflicts = 
			[select id from session_speaker__c
			 where speaker__c = :sessionSpeaker.speaker__c
			 and session__r.session_date__c = :session.session_date__c];
			 
		// if conflicts exist, add an error (and reject the db operation)
		if (!conflicts.isEmpty()) {
			sessionSpeaker.addError('The speaker is already booked at that time.');
		}
	}    
}