/**
 * Service class for Flight__c sObject
 * 
 * @author Witold Przyżycki
 * @created 04.10.2022
 */
public with sharing class Flight_Service {
    

    private static final Set<String> fieldsToCheck = new Set<String>{
        'ArrivalAirport__c',
        'DepartureAirport__c'
    };
    /**
     * Method  to calculate distance for new Flight__c sObjects
     * 
     * @author Witold Przyżycki
     * @created 04.10.2022
     * @param1 List of new Flight__c objects to calculate distances
     * @param2 Map of old Flight__c objects ids to Flight__c objects
     */
    public static void recalculateFlightsDistances(List<Flight__c> flights, Map<Id, Flight__c> oldFlightId2Flight) {
        try {
            List<Flight__c> changedFlights = new List<Flight__c>();
            Set<Id> airportIds = new Set<Id>();
            for (Flight__c flight : flights) {
                if (UtilityService.isFieldChanged(flight, oldFlightId2Flight, fieldsToCheck)) {
                    airportIds.add(flight.ArrivalAirport__c);
                    airportIds.add(flight.DepartureAirport__c);
                    changedFlights.add(flight);
                }
            }

            Map<Id, Airport__c> id2Airport = Airport_Selector.getAirportsByIds(airportIds);

            for (Flight__c flight : changedFlights) {
                if (id2Airport.containsKey(flight.ArrivalAirport__c) && id2Airport.containsKey(flight.DepartureAirport__c)) {
                    flight.Distance__c = UtilityService.calculateDistance(id2Airport.get(flight.DepartureAirport__c).Location__Latitude__s,
                                                                                id2Airport.get(flight.DepartureAirport__c).Location__Longitude__s,
                                                                                id2Airport.get(flight.ArrivalAirport__c).Location__Latitude__s,
                                                                                id2Airport.get(flight.ArrivalAirport__c).Location__Longitude__s
                                                                                );
                    flight.Name = id2Airport.get(flight.DepartureAirport__c).IATA_Code__c + 
                        '-' + 
                        id2Airport.get(flight.ArrivalAirport__c).IATA_Code__c;
                }
            }
        } catch(Exception ex) {
            System.debug(System.Label.UnexpectedError + ' ' + ex.getMessage());
        }
    } 
}
