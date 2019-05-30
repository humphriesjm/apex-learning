public class BookDiscountApply {
    public static void applyDiscount(Book__c[] books) {
    	for (Book__c b : books) {
    		b.price__c = b.price__c * 0.9;
    	}
    }
}