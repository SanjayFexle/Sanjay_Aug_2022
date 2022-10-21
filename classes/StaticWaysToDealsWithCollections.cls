/**
*
*  Purpose          :   Class to demonstrate the static ways to deal with or populate collections in apex.
*
*  Created Date     :   09/01/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class StaticWaysToDealsWithCollections 
{
    //Map to have States, Cities Details with Respect to respective countries
    Map<String, Map<String, List<String>>> mapOfCountriesWithStatesAndCitiesDetails;
    
    //Constructor
    public StaticWaysToDealsWithCollections() 
    {
        mapOfCountriesWithStatesAndCitiesDetails = new Map<String, Map<String, List<String>>>
        {
            'India' =>
                new Map<String, List<String>>
                {
                    'Rajasthan' => new List<String> {'Jaipur', 'Udaipur'},
                    'WB' => new List<String> {'Kolkata', 'Asansole'}
                },
            'USA' =>
                new Map<String, List<String>>
                {
                    'Texas' => new List<String> {'Dallas', 'Austin'},
                    'NC' => new List<String> {'Charlotte', 'Rayleigh'}
                }
        };
    }
}