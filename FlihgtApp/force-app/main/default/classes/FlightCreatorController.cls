/**
 * Controller class for flightCreator component
 * 
 * @author Witold Przyżycki
 * @created 04.10.2022
 */
public with sharing class FlightCreatorController {
    /**
     * Controller method to fetch all available Airports
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @return All Airport__c objects
     */
    @AuraEnabled(cacheable=true)
    public static List<Airport__c> getAllAirports() {
        return Airport_Selector.getAllAirports();
    }
     /**
     * Service method to calculate and save Flight__c record 
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @param List of two Airport__c objects to create a Flight__c object between them
     */
    @AuraEnabled
    public static Flight_Factory calculateAndSaveNewFlight(List<Airport__c> airports) {
        try {
            Flight__c newFlight = new Flight__c (
                DepartureAirport__c = airports.get(0).Id,
                ArrivalAirport__c = airports.get(1).Id,
                Distance__c = UtilityService.calculateDistance(
                    airports.get(0).Location__Latitude__s,
                    airports.get(0).Location__Longitude__s,
                    airports.get(1).Location__Latitude__s,
                    airports.get(1).Location__Longitude__s
                ),
                Name = airports.get(0).Name + '-' + airports.get(1).Name
            );
            insert newFlight;
            
            Flight_Factory flight = new Flight_Factory();
            return flight.cloneFlight(newFlight).withNames(airports.get(0).Name, airports.get(1).Name).getRecord();
        } catch(DmlException ex) {
            throw new AuraHandledException(System.Label.UnexpectedError + ' ' + ex.getMessage());
        }
    }
}
