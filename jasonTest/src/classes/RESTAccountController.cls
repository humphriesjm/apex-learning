@RestResource(urlMapping='/FieldAccount/*')
global with sharing class RESTAccountController {
  @HttpGet
  global static List<Account> getAccounts()
  {
	String accountName = RestContext.request.params.get('Name');
	System.debug('****** accountName: ' + accountName);
    Account[] accts = [select Id, name, BillingAddress, phone, Type from Account where name = :accountName];
    if (accts.size() > 0) {
    	Account acct = accts[0];
	    List <Account> accounts = [select Name, id, Active__c, NumberofLocations__c, Owner.Name from Account where Type = :acct.Type];
    	return accounts;
    } else {
    	return accts;
    }
  }
  
  @HttpDelete
  global static String deleteRecreationAccounts() {
	String industryName = RestContext.request.params.get('industry');
	System.debug('****** industryName: ' + industryName);
    //Account[] accts = [select Id, name, BillingAddress, phone, Type from Account where name = :industryName];
    List <Account> accounts = [select Name, Industry, id, Active__c, NumberofLocations__c, Owner.Name from Account where Industry = :industryName];
    if (accounts.size() > 0) {
	    delete accounts;
	    return 'Closed Accounts with Industry Type of ' + industryName;
    } else {
    	return 'No Accounts with Industry Type of ' + industryName;
    }     
  }
  
	@HttpPost 
	global static String createNewAccount(String acctName, String phone) {
		integer numLocations = 6;
		integer numEmployees = 500;
	    Account a = new Account();
	    a.Name = acctName;
	    a.phone = phone;
	    a.NumberofLocations__c = numLocations;
	    a.NumberOfEmployees = numEmployees;
	    insert a;
		return 'Done';
	}
   
	/*
	@HttpPatch
	global static String updateAccount(String accountId, String accountStatus, String accountNote) {
    Account companyAccount = [SELECT Id, Subject, Status, Description from Account WHERE Id =: accountId];
    
    companyAccount.Status = accountStatus;
    companyAccount.Description = accountNote;
    update companyAccount;
    
    return 'Account Updated';
  }
 */  
}