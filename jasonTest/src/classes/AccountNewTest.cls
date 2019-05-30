@IsTest
public class AccountNewTest {
	
	static testMethod void addNewAccount() {
		Account a = new Account();
		a.name = 'JPMorgan';
		a.NumberOfEmployees = 20000;
		insert a;
	}
	
	static testMethod void addNewAccountWithoutAccountName() {
		Account a = new Account();
		//fix
		a.name = 'something';
		//
		a.NumberOfEmployees = 20000;
		insert a;
	}
	
}