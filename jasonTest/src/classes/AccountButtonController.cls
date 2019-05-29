public class AccountButtonController {
	
	public ApexPages.standardcontroller Controller {get;set;}
	
	public AccountButtonController(ApexPages.StandardController stdController) {
		Controller = stdController;
	}
    
    public PageReference startBatch() {
    	string myId = ApexPages.currentPage().getParameters().get('id');
		
		// create a loader class - define query in loader class
		AccountLoader myLoader = new AccountLoader();
		myLoader.query = 'select Id, Name, AccountNumber, Active__c, BillingAddress, Website from Account';
		integer batchSize = 2;
		ID batchprocessid = Database.executeBatch(myLoader, batchSize);
		
		// return the user to the current page where the button was pressed
		PageReference pageRef = new PageReference('/' + myId);
		pageRef.setRedirect(true);
		return pageRef;
    }
}