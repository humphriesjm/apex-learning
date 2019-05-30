@RestResource(urlMapping='/v3/accounts/*')
global with sharing class AccountRESTService_V3 {
	
	@HttpGet
	global static AccountWrapper doGet() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		AccountWrapper response = new AccountWrapper();
		
		string accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		
		if (doSearch(accountId)) {
			searchAccounts(req, res, response);
		} else {
			findAccount(res, response, accountId);
		}
		
		return response;
	}
	
	private static boolean doSearch(string accountId) {
		return accountId == 'accounts';
	}
	
	private static void searchAccounts(RestRequest req, RestResponse res, AccountWrapper response) {
		string searchTerm = req.params.get('name');
		
		if (searchTerm == null || searchTerm == '') {
			response.status = 'Error';
			response.message = 'You must provide a `name` for your search term.';
			res.StatusCode = 400;
		} else {
			System.debug('******* searchTerm: ' + searchTerm);
			string searchText = '%'+searchTerm+'%';
			list<Account> searchResults = [select id, name, phone, website from Account where name like : searchText];
			
			if (searchResults != null && searchResults.size() > 0) {
				response.acctList = searchResults;
				response.status = 'Success';
				response.message = searchResults.size() + ' Accounts were found that matched your search term.';
			} else {
				response.status = 'Error';
				response.message = 'No Accounts were found based on that search term (' + searchTerm + '), please search again.';
			}
		}
	}
	
	private static void findAccount(RestResponse res, AccountWrapper response, string accountId) {
		if (accountId != null && accountId != '') {
			list<Account> result = [select id, name, phone, website from Account where id = :accountId];
			
			if (result != null && result.size() > 0) {
				System.debug('***** result[0]: ' + result[0]);
				response.acctList.add(result[0]);
				response.status = 'Success';
			} else {
				response.status = 'Error';
				response.message = 'This account ('+ accountId +') could not be found, please try again.';
				res.StatusCode = 404;
			}
		} else {
			response.status = 'Error';
			response.message = 'You must specify an Id.';
			res.StatusCode = 400;
		}
	}
	
	
	global class AccountWrapper {
		public list<Account> acctList;
		public string status;
		public string message;
		
		public AccountWrapper() {
			acctList = new list<Account>();
		}
	}

}