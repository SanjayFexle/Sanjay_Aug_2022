@isTest
private class SumTest {
    @isTest static void testDosum(){
        Sum obj = new Sum();
        Integer n =obj.doSum(5,7);
		System.assertEquals(12, n);
        
    }
    
    @isTest static void testDoDiv(){
        Sum obj = new Sum();
        decimal n =obj.doDiv(10,2);
		System.assertEquals(5, n);
        
    }
}