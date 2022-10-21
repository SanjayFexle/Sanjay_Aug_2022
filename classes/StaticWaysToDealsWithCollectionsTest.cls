@isTest
private class StaticWaysToDealsWithCollectionsTest {
    @isTest  static void check1(){
        Map<String,Map<String,List<String>>> forCheck= staticWaysToDealsWithCollections.staticWaysToDealsWithCollections();
        
        List<String> rajcitiesList = new List<String>{'Jaipur','Kota', 'udaipur'};
            System.assertEquals(rajcitiesList, forcheck.get('India').get('Raj'));
        	
        
        List<String> westCitiesList = new List<String>{'Kolkata','Asansol','Siliguri'};
            System.assertEquals(westCitiesList, forcheck.get('India').get('West'));

        List<String> ukEnglandcities = new List<String>{'London','Oxford','Cambridge'};
            System.assertEquals(ukEnglandcities, forcheck.get('Uk').get('England'));
        
        List<String> ukScotlandcities = new List<String>{'Edinburgh','Glasgow','Perth','Stirling'};
            System.assertEquals(ukScotlandcities, forcheck.get('Uk').get('Scotland'));

    }
}