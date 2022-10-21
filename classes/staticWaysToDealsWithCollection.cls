public class staticWaysToDealsWithCollection {

    public static Map <String,Map<String,List<String>>>  staticWaysToDealsWithCollection(){
        List<String> RajasthanCities = new List<String>{'Jaipur','Kota','udaipur'}; 
        List<String> WestBengalcities = new List<String>{'Kolkata','Asansol','Siliguri'};
       	List<String> ukEnglandcities = new List<String>{'London','Oxford','Cambridge'};
        List<String> ukScotlandcities = new List<String>{'Edinburgh','Glasgow','Perth','Stirling'};
		        
        Map<String,List<String>> IndiaStates = new Map<String,List<String>>{'Raj'=>RajasthanCities,'West'=>WestBengalcities};
		Map<String,List<String>> UkStates = new Map<String,List<String>>{'England'=>ukEnglandcities,'Scotland'=>ukScotlandcities};
       	
        Map <String , Map<String,List<String>>> CountriesList = new Map <String , Map<String,List<String>>>{'India'=>IndiaStates,'Uk'=>UkStates}; 

        //System.debug('India : '+ CountriesList.get('India') + '\n'+'United Kingdom : ' +CountriesList.get('Uk'));
        Return  CountriesList;
    }
}