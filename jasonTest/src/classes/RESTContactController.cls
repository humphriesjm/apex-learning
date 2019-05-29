@RestResource(urlMapping='/FieldContact/*')
global with sharing class RESTContactController {
	@HttpGet
	global static List<Contact> getStateContacts() {
		String state = RestContext.request.params.get('state');
		List<Contact> contacts = [select name, id, email, phone, MailingState from Contact where MailingState = :state];
		if (contacts.size() > 0) {
			System.debug('****** Found ' + contacts.size() + ' contacts from ' + state);
		}
		return contacts;
	}
	
	@HttpPost
	global static String createNewContact(string firstName, string lastName, string phone, string email) {
		Contact c = new Contact();
		c.firstname = firstName;
		c.lastname = lastName;
		c.phone = phone;
		c.email = email;
		insert c;
		return 'New Contact Created: ' + c.firstname + ' ' + c.lastname;
	}
	
	@HttpPatch
	global static String updateContactState(string name, string state) {
		List<Contact> contacts = [select name, id, mailingstate from Contact where Name = :name and MailingState != :state];
		if (contacts.size() > 0) {
			// contacts found with same name and state
			Contact c = contacts[0];
			c.mailingstate = state;
			update c;
			return 'Contact updated: ' + c.name;
		} else {
			// no contacts found with same name and state
			return 'No contacts found with name = ' + name + ' and state = ' + state;
		}
	}
}