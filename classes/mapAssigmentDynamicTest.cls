@isTest
private class mapAssigmentDynamicTest {
    
    @testSetup static void setDatat(){
        CountryCode__c  conCode = new CountryCode__c(Name='SInd');
        Insert conCode;
        
        Country__c con = new Country__c(Name='SIndia',CountryCode_Lookup__c=conCOde.Id);
        Insert con;
        
        State__c state = new State__c(Name='SRaj',Country_Lookup__c=con.id);
        Insert state;
        
        City__c city = new City__c(Name='Sikar',State_Lookup__c=state.Id);
        Insert city;
        
        City__c city2 = new City__c(Name='Sirohi',State_Lookup__c=state.Id);
        Insert city2;
        
        State__c state2 = new State__c(Name='West Bengal',Country_Lookup__c=con.id);
        Insert state2;
        
        City__c city3 = new City__c(Name='Kolkata',State_Lookup__c=state2.Id);
        Insert city3;
        
        City__c city4 = new City__c(Name='Asansol',State_Lookup__c=state2.Id);
        Insert city4;
       
        Country__c con11 = new Country__c(Name='United kingdom',CountryCode_Lookup__c=conCOde.Id);
        Insert con11;
        
         State__c state12 = new State__c(Name='England',Country_Lookup__c=con11.id);
        Insert state12;
        
        City__c city13 = new City__c(Name='Sikar',State_Lookup__c=state.Id);
        Insert city13;

     }
    
    @isTest static void method1(){
        	mapAssigmentDynamic m = new mapAssigmentDynamic();
        	List<String> citiesByName = m.citiesName('S'); 
        	
        	List<String> ExpectedCities = new  List<String> {'Sikar','Sirohi'};
                System.assertEquals(ExpectedCities, citiesByName);
    }

}