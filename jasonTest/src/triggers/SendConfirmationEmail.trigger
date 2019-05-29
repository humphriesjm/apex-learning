trigger SendConfirmationEmail on Session_Speaker__c (after insert) {
    for (session_speaker__c newItem : trigger.new) {
        // retrieve session name and time + speaker name and email
        session_speaker__c sessionSpeaker =
            [select session__r.name,
            		session__r.session_date__c,
            		speaker__r.first_name__c,
            		speaker__r.last_name__c,
            		speaker__r.email__c
            from session_speaker__c
            where id = :newItem.id];

        // send confirmation email if we know the speaker's email
        if (sessionSpeaker.speaker__r.email__c != null) {
            string address = sessionSpeaker.speaker__r.email__c;
            string subject = 'Speaker Confirmation';
            string message = 'Dear ' + sessionSpeaker.speaker__r.first_name__c +
                ',\nYour session "' + sessionSpeaker.session__r.name + '" on ' +
                sessionSpeaker.session__r.session_date__c + 'is confirmed.\n\n' +
                'Thanks for speaking at the conference!';
            EmailManager.sendMail(address, subject, message); 
        }
    }
}