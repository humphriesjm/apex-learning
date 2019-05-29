global class AccountLoader implements Database.Batchable<sObject>, Database.Stateful {
    // query string that is set in the scheduler and controller
    public string query;
    
    // Database.executeBatch() in scheduler calls this start method
    global database.querylocator start(Database.BatchableContext BC) {
    	return Database.getQueryLocator(query);
    }
    
    // execute method is called by `database.queryLocator`
    global void execute(Database.BatchableContext BC, List<sObject> scope) {
    	list<Account> myListAccounts = scope;
    	for (Account x : myListAccounts) {
    		// manipulate the cases
    	}
    }
    
    // after all batches have been executed, do any final cleanup here
    global void finish(Database.BatchableContext BC) {
    	//
    }
}