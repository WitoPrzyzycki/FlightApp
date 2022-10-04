/**
 * Selector class for Airport__c sObject
 * 
 * @author Witold Przyżycki
 * @created 04.10.2022
 */
global with sharing class Airport_Selector {

    /**
     * Selector method to define fields to fetch.
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * 
     */
    private static final List<String> mainFields = new List<String>{
        'Id',
        'Name',
        'Location__Latitude__s', 
        'Location__Longitude__s', 
        'IATA_Code__c'
    };

    /**
     * Selector method to define populate predefined fields
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @return List of Strings with defined main fields API names
     */
    global static List<String> getAirportMainFields() {
        return mainFields;
    }
    /**
     * Selector method to execute query by Ids
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @param set of Airport__c ids
     * @return Map of Airport__c ids to Airport__c objects
     */
    global static Map<Id, Airport__c> getAirportsByIds(Set<Id> ids) {
        String query = 'SELECT ' + String.join(getAirportMainFields(), ',') +
            ' FROM Airport__c ' +
            ' WHERE Id IN :ids ';
        return new Map<Id, Airport__c>((List<Airport__c>) Database.query(String.escapeSingleQuotes(query)));
    }
     /**
     * Selector method to execute main query
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @return List of all Airport__c objects
     */
    global static List<Airport__c> getAllAirports() {
        String query = 'SELECT ' + 
                        String.join(getAirportMainFields(), ',') +
                        ' FROM Airport__c';
        return Database.query(String.escapeSingleQuotes(query));
    }
}
