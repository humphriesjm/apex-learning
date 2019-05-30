@RestResource(urlMapping='/v2/accounts/*')
global with sharing class AccountRESTService_V2 {
	
	@HttpGet
	global static AccountWrapper doGet() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		AccountWrapper response = new AccountWrapper();
		
		string accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		
		list<Account> result = [select id, name, phone, website from Account where id = :accountId];
		
		if (result != null && result.size() > 0) {
			response.acct = result[0];
			response.status = 'Success';
			response.message = 'Account found for accountId: ' + accountId;
			System.debug('****** response.acct: ' + result[0]);
		} else {
			response.acct = null;
			response.status = 'Error';
			response.message = 'This account (' + accountId + ') could not be found, please try again.';
			res.StatusCode = 404;
		}
		
		return response;
	}
	
	global class AccountWrapper {
		public Account acct;
		public string status;
		public string message;
		
		public AccountWrapper(){}
	}
}